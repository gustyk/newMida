-- *****************************************************************************
-- Script: 02_create_tables.sql
-- Deskripsi: Membuat tabel-tabel untuk aplikasi PKasir (Tahap Awal)
-- Tanggal: 2026-01-14
-- Catatan: Database dibuat bertahap sesuai pengembangan, bukan ideal dari awal
-- *****************************************************************************

USE `apotek`;

-- =============================================================================
-- Tabel 1: Tab_User (Master Data User/Kasir)
-- Deskripsi: Menyimpan data user yang dapat login ke sistem
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_User` (
  `nama` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `shift` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Master Data User';

-- =============================================================================
-- Tabel 2: Tab_Obat_Mst (Master Data Obat)
-- Deskripsi: Header data obat dengan informasi lengkap harga dan stok
-- Struktur disesuaikan dengan database yang sudah ada
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Obat_Mst` (
  `ID_Obat` INT(11) NOT NULL,
  `Nama_obat` VARCHAR(35) NOT NULL,
  `Golongan` CHAR(10) DEFAULT NULL,
  `Katagori` CHAR(10) DEFAULT NULL,
  `harga` DECIMAL(10,0) DEFAULT NULL,
  `Minimum` DECIMAL(10,0) DEFAULT NULL,
  `lokasi` CHAR(5) DEFAULT NULL,
  PRIMARY KEY (`ID_Obat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Master Data Obat';

-- =============================================================================
-- Tabel 3: Tab_Obat_Dtl (Detail Stok Obat)
-- Deskripsi: Detail stok obat per item dengan barcode
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Obat_Dtl` (
  `ID_STOCK` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_OBAT` INT(11) NOT NULL DEFAULT 0,
  `STOCK` DECIMAL(10,0) DEFAULT NULL,
  `BARCODE` VARCHAR(15) DEFAULT NULL,
  PRIMARY KEY (`ID_STOCK`),
  KEY `idx_obat` (`ID_OBAT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Detail Stok Obat';

-- =============================================================================
-- Tabel 4: Tab_Mut_Mst (Header Mutasi/Perubahan Stok Obat)
-- Deskripsi: Header mutasi obat (pembelian, penjualan, retur, dll)
-- MUT_TYPE: Jenis mutasi (contoh: 01=Pembelian, 02=Penjualan, dst)
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Mut_Mst` (
  `MUT_ID` VARCHAR(13) DEFAULT NULL,
  `MUT_TYPE` VARCHAR(2) DEFAULT '0',
  `MUT_INPDATE` DATETIME DEFAULT NULL,
  `FAK_NO` VARCHAR(30) NOT NULL DEFAULT 'GUDANG',
  `FAK_DATE` DATETIME DEFAULT NULL,
  `SUP_ID` VARCHAR(3) DEFAULT '0',
  `MUT_VALUE` DOUBLE(15,3) DEFAULT 0.000,
  `PPN` DOUBLE(15,3) DEFAULT 0.000,
  `PPN_INCLUDED` TINYINT(1) DEFAULT 0,
  `PAY_TYPE` VARCHAR(1) DEFAULT 'C',
  `PAY_DATE` DATETIME DEFAULT NULL,
  `MUT_TO` VARCHAR(25) DEFAULT '',
  `REQ_ID` VARCHAR(20) DEFAULT '',
  `EMP_ID` INT(11) NOT NULL DEFAULT 0,
  `IS_LOCKED` TINYINT(4) DEFAULT 0,
  `MUT_STATUS` INT(4) DEFAULT 0,
  `jenis_nota` VARCHAR(20) DEFAULT NULL,
  KEY `idx_mut_id` (`MUT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Header Mutasi Stok Obat';

-- =============================================================================
-- Tabel 5: Tab_Mut_Dtl (Detail Mutasi/Perubahan Stok Obat)
-- Deskripsi: Detail item obat per mutasi dengan perhitungan harga lengkap
-- =============================================================================
CREATE TABLE IF NOT EXISTS `Tab_Mut_Dtl` (
  `MUT_NO` INT(11) NOT NULL AUTO_INCREMENT,
  `MUT_ID` VARCHAR(20) DEFAULT NULL,
  `OBT_ID` INT(11) DEFAULT NULL,
  `OBT_NM` VARCHAR(30) DEFAULT NULL,
  `PRC_BOX` DOUBLE(15,3) DEFAULT 0.000,
  `OBT_QTY` DOUBLE DEFAULT 0,
  `PRC_BON` INT(11) DEFAULT 0,
  `PRC_DISCNUM` DOUBLE(15,3) DEFAULT 0.000,
  `PRC_DISCPERC` DOUBLE(15,3) DEFAULT 0.000,
  `PUR_TOT` DOUBLE(15,3) DEFAULT 0.000,
  `PRC_PURCNET` DOUBLE(15,3) DEFAULT 0.000,
  `PRC_PURCGROSS` DOUBLE(15,3) DEFAULT 0.000,
  `PRC_PURCNET_TOT` DOUBLE(15,3) DEFAULT 0.000,
  `PRC_RETAIL` DOUBLE(15,3) DEFAULT 0.000,
  `BOX_QTY` DOUBLE(15,3) DEFAULT 0.000,
  `BOX_CONTAIN` INT(11) DEFAULT 0,
  `PPN_FLAG` DOUBLE DEFAULT 0,
  `OBT_LOCATION` VARCHAR(5) DEFAULT NULL,
  `EMP_ID` INT(11) NOT NULL DEFAULT 0,
  `STOK` INT(11) DEFAULT 0,
  `RET_MUT_ID` VARCHAR(30) DEFAULT '',
  `MUT_DATE` DATETIME DEFAULT NULL,
  `MUT_STATUS` INT(11) DEFAULT 0,
  `MUT_TYPE` INT(11) DEFAULT 0,
  `PRC_RETAIL_TOT` DOUBLE DEFAULT 0,
  `PRC_RETAILNET_TOT` DOUBLE DEFAULT 0,
  `EMBALASE` DOUBLE DEFAULT 0,
  PRIMARY KEY (`MUT_NO`),
  KEY `idx_mut_id` (`MUT_ID`),
  KEY `idx_obt_id` (`OBT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Detail Mutasi Stok Obat';

-- Tampilkan konfirmasi
SELECT 'Semua tabel berhasil dibuat!' AS Status;
