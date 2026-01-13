-- *****************************************************************************
-- Script: 01_create_database.sql
-- Deskripsi: Membuat database apotek jika belum ada
-- Tanggal: 2026-01-13
-- Catatan: Run script ini pertama kali sebelum script lainnya
-- *****************************************************************************

-- Buat database jika belum ada
CREATE DATABASE IF NOT EXISTS `apotek` 
DEFAULT CHARACTER SET utf8mb4 
DEFAULT COLLATE utf8mb4_general_ci;

-- Gunakan database apotek
USE `apotek`;

-- Tampilkan konfirmasi
SELECT 'Database apotek berhasil dibuat atau sudah ada!' AS Status;
