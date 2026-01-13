-- *****************************************************************************
-- Script: 02_create_tables.sql
-- Deskripsi: Membuat tabel-tabel untuk aplikasi PKasir
-- Tanggal: 2026-01-13
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
-- Tabel: Tab_Obat_Dtl (Detail Transaksi/Stock Obat)
-- Deskripsi: Menyimpan detail transaksi atau pergerakan stock obat
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Obat_Dtl` (
  `ID_Detail` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_Obat` INT(11) NOT NULL,
  `No_Transaksi` VARCHAR(50) DEFAULT NULL,
  `Tgl_Transaksi` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Jenis_Transaksi` ENUM('MASUK','KELUAR','JUAL','RETUR') DEFAULT 'JUAL',
  `Jumlah` DECIMAL(10,2) DEFAULT 0.00,
  `Harga` DECIMAL(15,2) DEFAULT 0.00,
  `Diskon_Persen` DECIMAL(5,2) DEFAULT 0.00,
  `Diskon_Rupiah` DECIMAL(15,2) DEFAULT 0.00,
  `Embalase` DECIMAL(15,2) DEFAULT 0.00,
  `SubTotal` DECIMAL(15,2) DEFAULT 0.00,
  `Keterangan` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`ID_Detail`),
  KEY `idx_obat` (`ID_Obat`),
  KEY `idx_transaksi` (`No_Transaksi`),
  KEY `idx_tanggal` (`Tgl_Transaksi`),
  CONSTRAINT `fk_obat_dtl` FOREIGN KEY (`ID_Obat`) REFERENCES `Tab_Obat_Mst` (`ID_Obat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Detail Transaksi Obat';

-- =============================================================================
-- Tabel: Tab_Transaksi_Hdr (Header Transaksi Penjualan)
-- Deskripsi: Menyimpan header/kepala transaksi penjualan
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Transaksi_Hdr` (
  `No_Transaksi` VARCHAR(50) NOT NULL,
  `Tgl_Transaksi` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `ID_User` VARCHAR(20) DEFAULT NULL,
  `Shift` VARCHAR(10) DEFAULT NULL,
  `Grand_Total` DECIMAL(15,2) DEFAULT 0.00,
  `Cara_Bayar` ENUM('Tunai','Qris','BCA','BRI','BNI','Hallo DOC','BPJS') DEFAULT 'Tunai',
  `Jumlah_Bayar` DECIMAL(15,2) DEFAULT 0.00,
  `Kembalian` DECIMAL(15,2) DEFAULT 0.00,
  `Status` ENUM('PENDING','SELESAI','BATAL') DEFAULT 'SELESAI',
  `Keterangan` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`No_Transaksi`),
  KEY `idx_tanggal` (`Tgl_Transaksi`),
  KEY `idx_user` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Header Transaksi Penjualan';

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
