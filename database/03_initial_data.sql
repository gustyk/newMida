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
('a', 'a', 'Pagi'),
('admin', 'admin123', 'Pagi'),
('kasir1', 'kasir123', 'Pagi'),
('kasir2', 'kasir123', 'Siang');

-- =============================================================================
-- Insert Data Obat Sample (untuk testing)
-- ID_Obat harus unique dan manual (tidak auto increment)
-- =============================================================================
INSERT IGNORE INTO `Tab_Obat_Mst` 
(`ID_Obat`, `Nama_obat`, `Golongan`, `Katagori`, `harga`, `Minimum`, `lokasi`) 
VALUES
(1, 'Paracetamol 500mg', 'Analgesik', 'Tablet', 5000, 10, 'A1'),
(2, 'Amoxicillin 500mg', 'Antibiotik', 'Kapsul', 15000, 10, 'B2'),
(3, 'OBH Combi', 'Batuk&Flu', 'Sirup', 20000, 5, 'C3'),
(4, 'Bodrex', 'Analgesik', 'Tablet', 3000, 20, 'A2'),
(5, 'Vitamin C 1000mg', 'Vitamin', 'Tablet', 25000, 10, 'D1'),
(6, 'CTM 4mg', 'Antihistam', 'Tablet', 2000, 15, 'A3'),
(7, 'Antasida DOEN', 'Maag', 'Tablet', 5000, 10, 'B1'),
(8, 'Betadine 30ml', 'Antiseptik', 'Cairan', 18000, 5, 'E1'),
(9, 'Mixagrip', 'Batuk&Flu', 'Tablet', 4000, 15, 'C1'),
(10, 'Promag', 'Maag', 'Tablet', 6000, 10, 'B3');

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
