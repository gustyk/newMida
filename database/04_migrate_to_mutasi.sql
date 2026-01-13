-- *****************************************************************************
-- Script: 04_migrate_to_mutasi.sql
-- Deskripsi: Migration script untuk mengubah struktur dari Tab_Transaksi_Hdr/Tab_Obat_Dtl
--            menjadi Tab_Mut_Mst/Tab_Mut_Dtl
-- Tanggal: 2026-01-13
-- Catatan: BACKUP DATABASE DULU sebelum menjalankan script ini!
-- *****************************************************************************

USE `apotek`;

-- =============================================================================
-- STEP 1: Backup data lama (jika ada)
-- =============================================================================
-- Jika sudah punya tabel Tab_Obat_Dtl, data akan di-copy ke tabel baru
-- Jika sudah punya tabel Tab_Transaksi_Hdr, data akan di-copy ke tabel baru

-- =============================================================================
-- STEP 2: Drop Foreign Key constraints dari tabel lama (jika ada)
-- =============================================================================
-- Cek apakah constraint ada terlebih dahulu
SET @fk_exists = (
    SELECT COUNT(*) 
    FROM information_schema.TABLE_CONSTRAINTS 
    WHERE CONSTRAINT_SCHEMA = 'apotek' 
    AND TABLE_NAME = 'Tab_Obat_Dtl' 
    AND CONSTRAINT_NAME = 'fk_obat_dtl'
);

-- Drop constraint jika ada
SET @query = IF(@fk_exists > 0, 
    'ALTER TABLE Tab_Obat_Dtl DROP FOREIGN KEY fk_obat_dtl', 
    'SELECT "Constraint fk_obat_dtl tidak ditemukan"'
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =============================================================================
-- STEP 3: Rename tabel lama (jika ada)
-- =============================================================================
-- Rename Tab_Obat_Dtl menjadi Tab_Obat_Dtl_OLD (backup)
SET @table_exists = (
    SELECT COUNT(*) 
    FROM information_schema.TABLES 
    WHERE TABLE_SCHEMA = 'apotek' 
    AND TABLE_NAME = 'Tab_Obat_Dtl'
);

SET @query = IF(@table_exists > 0, 
    'RENAME TABLE Tab_Obat_Dtl TO Tab_Obat_Dtl_OLD', 
    'SELECT "Tabel Tab_Obat_Dtl tidak ditemukan"'
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Rename Tab_Transaksi_Hdr menjadi Tab_Transaksi_Hdr_OLD (backup)
SET @table_exists = (
    SELECT COUNT(*) 
    FROM information_schema.TABLES 
    WHERE TABLE_SCHEMA = 'apotek' 
    AND TABLE_NAME = 'Tab_Transaksi_Hdr'
);

SET @query = IF(@table_exists > 0, 
    'RENAME TABLE Tab_Transaksi_Hdr TO Tab_Transaksi_Hdr_OLD', 
    'SELECT "Tabel Tab_Transaksi_Hdr tidak ditemukan"'
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =============================================================================
-- STEP 4: Buat tabel baru Tab_Mut_Mst dan Tab_Mut_Dtl
-- =============================================================================

-- Buat Tab_Mut_Mst (Master/Header Mutasi Obat)
CREATE TABLE IF NOT EXISTS `Tab_Mut_Mst` (
  `No_Mutasi` VARCHAR(50) NOT NULL,
  `Tgl_Mutasi` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Kode_Mutasi` VARCHAR(20) NOT NULL,
  `Keterangan_Mutasi` VARCHAR(100) DEFAULT NULL,
  `ID_User` VARCHAR(20) DEFAULT NULL,
  `Shift` VARCHAR(10) DEFAULT NULL,
  `Grand_Total` DECIMAL(15,2) DEFAULT 0.00,
  `Cara_Bayar` ENUM('Tunai','Qris','BCA','BRI','BNI','Hallo DOC','BPJS','Transfer','Kredit') DEFAULT NULL,
  `Jumlah_Bayar` DECIMAL(15,2) DEFAULT 0.00,
  `Kembalian` DECIMAL(15,2) DEFAULT 0.00,
  `Status` ENUM('DRAFT','PENDING','SELESAI','BATAL') DEFAULT 'DRAFT',
  `Keterangan` TEXT DEFAULT NULL,
  PRIMARY KEY (`No_Mutasi`),
  KEY `idx_tanggal` (`Tgl_Mutasi`),
  KEY `idx_kode` (`Kode_Mutasi`),
  KEY `idx_user` (`ID_User`),
  KEY `idx_status` (`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Master Header Mutasi Obat';

-- Buat Tab_Mut_Dtl (Detail Mutasi Obat)
CREATE TABLE IF NOT EXISTS `Tab_Mut_Dtl` (
  `ID_Detail` INT(11) NOT NULL AUTO_INCREMENT,
  `No_Mutasi` VARCHAR(50) NOT NULL,
  `ID_Obat` INT(11) NOT NULL,
  `Jumlah` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Harga` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `Diskon_Persen` DECIMAL(5,2) DEFAULT 0.00,
  `Diskon_Rupiah` DECIMAL(15,2) DEFAULT 0.00,
  `Embalase` DECIMAL(15,2) DEFAULT 0.00,
  `SubTotal` DECIMAL(15,2) DEFAULT 0.00,
  `Keterangan` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`ID_Detail`),
  KEY `idx_mutasi` (`No_Mutasi`),
  KEY `idx_obat` (`ID_Obat`),
  CONSTRAINT `fk_mut_dtl_mst` FOREIGN KEY (`No_Mutasi`) REFERENCES `Tab_Mut_Mst` (`No_Mutasi`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_mut_dtl_obat` FOREIGN KEY (`ID_Obat`) REFERENCES `Tab_Obat_Mst` (`ID_Obat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Detail Mutasi Obat';

-- =============================================================================
-- STEP 5: Migrasi data dari tabel lama ke tabel baru (jika ada)
-- =============================================================================

-- Migrasi data dari Tab_Transaksi_Hdr_OLD ke Tab_Mut_Mst (jika ada data)
INSERT IGNORE INTO Tab_Mut_Mst 
  (No_Mutasi, Tgl_Mutasi, Kode_Mutasi, ID_User, Shift, Grand_Total, 
   Cara_Bayar, Jumlah_Bayar, Kembalian, Status, Keterangan)
SELECT 
  No_Transaksi, 
  Tgl_Transaksi, 
  'JUAL',  -- Semua transaksi lama dianggap sebagai JUAL
  ID_User, 
  Shift, 
  Grand_Total, 
  Cara_Bayar, 
  Jumlah_Bayar, 
  Kembalian, 
  Status,
  Keterangan
FROM Tab_Transaksi_Hdr_OLD
WHERE EXISTS (
  SELECT 1 FROM information_schema.TABLES 
  WHERE TABLE_SCHEMA = 'apotek' AND TABLE_NAME = 'Tab_Transaksi_Hdr_OLD'
);

-- Migrasi data dari Tab_Obat_Dtl_OLD ke Tab_Mut_Dtl (jika ada data)
INSERT IGNORE INTO Tab_Mut_Dtl 
  (No_Mutasi, ID_Obat, Jumlah, Harga, Diskon_Persen, Diskon_Rupiah, 
   Embalase, SubTotal, Keterangan)
SELECT 
  No_Transaksi, 
  ID_Obat, 
  Jumlah, 
  Harga, 
  Diskon_Persen, 
  Diskon_Rupiah, 
  Embalase, 
  SubTotal, 
  Keterangan
FROM Tab_Obat_Dtl_OLD
WHERE EXISTS (
  SELECT 1 FROM information_schema.TABLES 
  WHERE TABLE_SCHEMA = 'apotek' AND TABLE_NAME = 'Tab_Obat_Dtl_OLD'
)
AND No_Transaksi IN (SELECT No_Mutasi FROM Tab_Mut_Mst);

-- =============================================================================
-- STEP 6: Verifikasi hasil migrasi
-- =============================================================================
SELECT 'Migration selesai!' AS Status;
SELECT COUNT(*) AS 'Jumlah data di Tab_Mut_Mst' FROM Tab_Mut_Mst;
SELECT COUNT(*) AS 'Jumlah data di Tab_Mut_Dtl' FROM Tab_Mut_Dtl;

-- =============================================================================
-- CATATAN PENTING:
-- Setelah memastikan data sudah ter-migrasi dengan benar, Anda dapat menghapus
-- tabel backup dengan perintah:
--   DROP TABLE IF EXISTS Tab_Obat_Dtl_OLD;
--   DROP TABLE IF EXISTS Tab_Transaksi_Hdr_OLD;
-- 
-- JANGAN HAPUS tabel backup sebelum memastikan aplikasi berjalan normal!
-- =============================================================================
