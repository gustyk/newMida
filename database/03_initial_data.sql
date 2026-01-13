-- *****************************************************************************
-- Script: 03_initial_data.sql
-- Deskripsi: Insert data awal (master data) untuk testing
-- Tanggal: 2026-01-13
-- Catatan: Script ini bersifat optional, untuk populate data awal
-- *****************************************************************************

USE `apotek`;

-- =============================================================================
-- Insert User Default (untuk testing)
-- =============================================================================
INSERT IGNORE INTO `Tab_User` (`ID_User`, `Nama_User`, `Password`, `Level`) VALUES
('admin', 'Administrator', 'admin123', 'Admin'),
('kasir1', 'Kasir 1', 'kasir123', 'Kasir'),
('kasir2', 'Kasir 2', 'kasir123', 'Kasir');

-- =============================================================================
-- Insert Data Obat Sample (untuk testing)
-- =============================================================================
INSERT IGNORE INTO `Tab_Obat_Mst` (`ID_Obat`, `Nama_Obat`, `Harga`, `Lokasi`, `Satuan`, `Kategori`) VALUES
(1, 'Paracetamol 500mg', 5000.00, 'Rak A1', 'Strip', 'Analgesik'),
(2, 'Amoxicillin 500mg', 15000.00, 'Rak B2', 'Strip', 'Antibiotik'),
(3, 'OBH Combi', 20000.00, 'Rak C3', 'Botol', 'Batuk & Flu'),
(4, 'Bodrex', 3000.00, 'Rak A2', 'Strip', 'Analgesik'),
(5, 'Vitamin C 1000mg', 25000.00, 'Rak D1', 'Strip', 'Vitamin'),
(6, 'CTM 4mg', 2000.00, 'Rak A3', 'Strip', 'Antihistamin'),
(7, 'Antasida DOEN', 5000.00, 'Rak B1', 'Strip', 'Maag'),
(8, 'Betadine 30ml', 18000.00, 'Rak E1', 'Botol', 'Antiseptik'),
(9, 'Mixagrip', 4000.00, 'Rak C1', 'Strip', 'Batuk & Flu'),
(10, 'Promag', 6000.00, 'Rak B3', 'Strip', 'Maag');

-- Tampilkan konfirmasi
SELECT 'Data awal berhasil di-insert!' AS Status;
SELECT COUNT(*) AS 'Jumlah User' FROM Tab_User;
SELECT COUNT(*) AS 'Jumlah Obat' FROM Tab_Obat_Mst;
