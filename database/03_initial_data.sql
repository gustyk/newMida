-- *****************************************************************************
-- Script: 03_initial_data.sql
-- Deskripsi: Insert data awal (master data) untuk testing
-- Tanggal: 2026-01-14
-- Catatan: Script ini bersifat optional, untuk populate data awal
-- *****************************************************************************

USE `apotek`;

-- =============================================================================
-- Insert User Default (untuk testing)
-- =============================================================================
INSERT IGNORE INTO `Tab_User` (`nama`, `password`, `shift`) VALUES
('admin', 'admin123', 'Pagi'),
('kasir1', 'kasir123', 'Pagi'),
('kasir2', 'kasir123', 'Siang');

-- =============================================================================
-- Insert Data Obat Sample (untuk testing)
-- OBT_ID harus unique dan manual (tidak auto increment)
-- =============================================================================
INSERT IGNORE INTO `Tab_Obat_Mst` 
(`OBT_ID`, `OBT_NM`, `OBT_CATEGORY`, `PRC_RETAIL`, `PRC_PURCNET`, `OBT_QTY`, 
 `OBT_MINQTY`, `BOX_CONTAIN`, `SatuanEcer`, `PRC_BOX`, `OBT_LOCATION`) 
VALUES
(1, 'Paracetamol 500mg', 'Analgesik', 5000, 4000, 100, 10, 10, 'Strip', 40000.000, 'A1'),
(2, 'Amoxicillin 500mg', 'Antibiotik', 15000, 12000, 50, 10, 10, 'Strip', 120000.000, 'B2'),
(3, 'OBH Combi', 'Batuk&Flu', 20000, 16000, 30, 5, 12, 'Botol', 192000.000, 'C3'),
(4, 'Bodrex', 'Analgesik', 3000, 2500, 200, 20, 10, 'Strip', 25000.000, 'A2'),
(5, 'Vitamin C 1000mg', 'Vitamin', 25000, 20000, 40, 10, 10, 'Strip', 200000.000, 'D1'),
(6, 'CTM 4mg', 'Antihistamin', 2000, 1500, 150, 15, 10, 'Strip', 15000.000, 'A3'),
(7, 'Antasida DOEN', 'Maag', 5000, 4000, 100, 10, 10, 'Strip', 40000.000, 'B1'),
(8, 'Betadine 30ml', 'Antiseptik', 18000, 15000, 25, 5, 6, 'Botol', 90000.000, 'E1'),
(9, 'Mixagrip', 'Batuk&Flu', 4000, 3200, 120, 15, 10, 'Strip', 32000.000, 'C1'),
(10, 'Promag', 'Maag', 6000, 5000, 80, 10, 10, 'Strip', 50000.000, 'B3');

-- =============================================================================
-- Insert Data Stok Detail (opsional - sesuai kebutuhan)
-- =============================================================================
INSERT IGNORE INTO `Tab_Obat_Dtl` (`ID_STOCK`, `ID_OBAT`, `STOCK`, `BARCODE`) VALUES
(1, 1, 100, '8992000000001'),
(2, 2, 50, '8992000000002'),
(3, 3, 30, '8992000000003'),
(4, 4, 200, '8992000000004'),
(5, 5, 40, '8992000000005'),
(6, 6, 150, '8992000000006'),
(7, 7, 100, '8992000000007'),
(8, 8, 25, '8992000000008'),
(9, 9, 120, '8992000000009'),
(10, 10, 80, '8992000000010');

-- Tampilkan konfirmasi
SELECT 'Data awal berhasil di-insert!' AS Status;
SELECT COUNT(*) AS 'Jumlah User' FROM Tab_User;
SELECT COUNT(*) AS 'Jumlah Obat' FROM Tab_Obat_Mst;
SELECT COUNT(*) AS 'Jumlah Detail Stok' FROM Tab_Obat_Dtl;
