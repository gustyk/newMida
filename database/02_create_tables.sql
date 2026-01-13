-- *****************************************************************************
-- Script: 02_create_tables.sql
-- Deskripsi: Membuat tabel-tabel untuk aplikasi PKasir
-- Tanggal: 2026-01-13
-- Update: Menggunakan konsep Mutasi (Tab_Mut_Mst dan Tab_Mut_Dtl)
-- Catatan: Pastikan database apotek sudah dibuat (jalankan 01_create_database.sql dulu)
-- *****************************************************************************

USE `apotek`;

-- =============================================================================
-- Tabel: Tab_Obat_Mst (Master Data Obat)
-- Deskripsi: Menyimpan data master obat yang dijual di apotek
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Obat_Mst` (
  `ID_Obat` INT(11) NOT NULL AUTO_INCREMENT,
  `Nama_Obat` VARCHAR(100) NOT NULL,
  `Harga` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `Lokasi` VARCHAR(50) DEFAULT NULL,
  `Satuan` VARCHAR(20) DEFAULT 'Strip',
  `Kategori` VARCHAR(50) DEFAULT NULL,
  `Stok_Min` INT(11) DEFAULT 10,
  `Status_Aktif` TINYINT(1) DEFAULT 1,
  `Tgl_Input` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Tgl_Update` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Obat`),
  KEY `idx_nama` (`Nama_Obat`),
  KEY `idx_kategori` (`Kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Master Data Obat';

-- =============================================================================
-- Tabel: Tab_Mut_Mst (Master/Header Mutasi Obat)
-- Deskripsi: Menyimpan header mutasi obat untuk berbagai keperluan
-- Kode_Mutasi yang dapat digunakan:
--   - JUAL      : Penjualan ke customer
--   - MASUK     : Pembelian/penerimaan obat
--   - KELUAR    : Pengeluaran obat (non-penjualan)
--   - RETUR     : Retur dari customer
--   - OPNAME    : Stock opname
--   - RUSAK     : Obat rusak
--   - KADALUARSA: Obat kadaluarsa
--   - PINDAH    : Pindah lokasi/gudang
-- =============================================================================
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

-- =============================================================================
-- Tabel: Tab_Mut_Dtl (Detail Mutasi Obat)
-- Deskripsi: Menyimpan detail item obat per mutasi (baik keluar maupun masuk)
-- =============================================================================
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
-- Tabel: Tab_User (Master Data User/Kasir)
-- Deskripsi: Menyimpan data user yang dapat login ke sistem
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_User` (
  `ID_User` VARCHAR(20) NOT NULL,
  `Nama_User` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `Level` ENUM('Admin','Kasir','Manager') DEFAULT 'Kasir',
  `Status_Aktif` TINYINT(1) DEFAULT 1,
  `Tgl_Input` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Tgl_Update` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Master Data User';

-- Tampilkan konfirmasi
SELECT 'Semua tabel berhasil dibuat!' AS Status;
