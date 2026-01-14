-- *****************************************************************************
-- Script: 00_check_database.sql
-- Deskripsi: Script untuk mengecek status database apotek
-- Tanggal: 2026-01-14
-- Catatan: Jalankan script ini untuk memastikan database sudah setup dengan benar
-- *****************************************************************************

-- Cek apakah database apotek ada
SELECT SCHEMA_NAME 
FROM INFORMATION_SCHEMA.SCHEMATA 
WHERE SCHEMA_NAME = 'apotek';

-- Gunakan database apotek
USE `apotek`;

-- Cek tabel yang ada di database apotek
SHOW TABLES;

-- Cek struktur tabel Tab_User
DESCRIBE Tab_User;

-- Cek struktur tabel Tab_Obat_Mst
DESCRIBE Tab_Obat_Mst;

-- Cek struktur tabel Tab_Obat_Dtl
DESCRIBE Tab_Obat_Dtl;

-- Cek jumlah data di masing-masing tabel
SELECT 'Tab_User' AS Tabel, COUNT(*) AS Jumlah FROM Tab_User
UNION ALL
SELECT 'Tab_Obat_Mst' AS Tabel, COUNT(*) AS Jumlah FROM Tab_Obat_Mst
UNION ALL
SELECT 'Tab_Obat_Dtl' AS Tabel, COUNT(*) AS Jumlah FROM Tab_Obat_Dtl;

-- Tampilkan data user yang ada
SELECT * FROM Tab_User;

-- Tampilkan data obat yang ada
SELECT * FROM Tab_Obat_Mst;

-- Tampilkan data stok obat yang ada
SELECT * FROM Tab_Obat_Dtl;
