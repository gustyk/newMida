# Database Setup - Apotek Kasir System

## 📋 Daftar File SQL

### 1. **00_check_database.sql**
**Deskripsi:** Script validasi untuk memeriksa status database  
**Fungsi:** 
- Cek koneksi ke server MySQL
- Verifikasi database 'apotek' sudah dibuat
- Validasi struktur tabel (Tab_User, Tab_Obat_Mst, Tab_Obat_Dtl, Tab_Mut_Mst, Tab_Mut_Dtl)
- Hitung jumlah record di tiap tabel

**Kapan Digunakan:** Sebelum atau sesudah instalasi untuk memastikan database setup dengan benar

---

### 2. **01_create_database.sql**
**Deskripsi:** Script untuk membuat database  
**Fungsi:**
- DROP DATABASE IF EXISTS (hati-hati, akan hapus semua data!)
- CREATE DATABASE `apotek`
- SET CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci

**Kapan Digunakan:** Instalasi fresh/baru pertama kali

---

### 3. **02_create_tables.sql**
**Deskripsi:** Script untuk membuat struktur tabel  
**Fungsi:**
- CREATE TABLE `Tab_User` (master user login)
- CREATE TABLE `Tab_Obat_Mst` (master data obat)
- CREATE TABLE `Tab_Obat_Dtl` (detail stok obat)
- CREATE TABLE `Tab_Mut_Mst` (master transaksi)
- CREATE TABLE `Tab_Mut_Dtl` (detail transaksi)
- Semua dengan IF NOT EXISTS (aman dijalankan berulang kali)

**Kapan Digunakan:** Setelah database dibuat (step 2)

---

### 4. **03_initial_data.sql** ⭐
**Deskripsi:** Script insert data awal (PRODUCTION DATA)  
**Fungsi:**
- INSERT 4 user default (a/a, admin/admin123, kasir1/kasir123, kasir2/kasir123)
- INSERT 5609 data obat dari database existing (mfkalimantan.tab_obt_mst)
- Data obat lengkap dengan harga, stok minimum, dan lokasi

**Sumber Data:**  
Migrasi dari database existing mfkalimantan.tab_obt_mst pada tanggal 2025-01-14

**Ukuran File:** ~318 KB (5652 baris)

**Column Mapping:**
- OBT_ID → ID_Obat
- OBT_NM → Nama_obat  
- OBT_CATEGORY → Golongan (banyak yang NULL, perlu diisi manual)
- PRC_RETAIL → harga
- STOCK_MINIMAL → Minimum
- STOCK_LOCATION → lokasi

**Kapan Digunakan:** Setelah tabel dibuat (step 3) untuk populate data awal

---

### 5. **tab_obat_mst.sql** (Reference Only)
**Deskripsi:** Export phpMyAdmin dari database production  
**Fungsi:** File reference/backup, sudah diintegrasikan ke 03_initial_data.sql  
**Status:** Tidak perlu dijalankan, hanya untuk dokumentasi

---

## 🚀 Cara Instalasi Database (Fresh Install)

### Option A: Via phpMyAdmin
1. Buka phpMyAdmin → klik "Import"
2. Import file berurutan:
   ```
   01_create_database.sql
   02_create_tables.sql
   03_initial_data.sql
   ```
3. Jalankan 00_check_database.sql untuk verifikasi

### Option B: Via MySQL Command Line
```bash
mysql -u root -p < 01_create_database.sql
mysql -u root -p apotek < 02_create_tables.sql
mysql -u root -p apotek < 03_initial_data.sql
mysql -u root -p apotek < 00_check_database.sql
```

### Option C: Via Delphi/Aplikasi
- Gunakan ZConnection untuk eksekusi script SQL
- Atau manual copy-paste query ke SQL Query panel

---

## 📊 Struktur Data Setelah Setup

| Tabel | Jumlah Record | Deskripsi |
|-------|--------------|-----------|
| Tab_User | 4 | User login (a, admin, kasir1, kasir2) |
| Tab_Obat_Mst | 5609 | Master data obat (dari database existing) |
| Tab_Obat_Dtl | 0 | Detail stok (kosong, diisi saat transaksi) |
| Tab_Mut_Mst | 0 | Master transaksi (kosong) |
| Tab_Mut_Dtl | 0 | Detail transaksi (kosong) |

---

## ⚠️ Catatan Penting

1. **Backup dulu sebelum DROP DATABASE!**  
   File `01_create_database.sql` akan menghapus database existing jika ada.

2. **Password Plain Text**  
   User password disimpan plain text. Untuk production sebaiknya gunakan MD5/SHA hash.

3. **Data Obat - Golongan NULL**  
   Banyak field `Golongan` bernilai NULL karena dari database sumber. Perlu diisi manual sesuai kebutuhan.

4. **ID_Obat Manual**  
   ID_Obat tidak auto-increment, menggunakan ID dari database sumber untuk consistency.

5. **Character Encoding**  
   Database menggunakan utf8mb4_unicode_ci untuk support karakter khusus.

---

## 🔧 Troubleshooting

### Error: "Table already exists"
- Normal jika jalankan script berulang kali
- Script menggunakan `CREATE TABLE IF NOT EXISTS` dan `INSERT IGNORE`

### Error: "Duplicate entry"
- Normal jika data sudah ada
- Script menggunakan `INSERT IGNORE` untuk skip duplicate

### Error: "Unknown database 'apotek'"
- Pastikan sudah jalankan `01_create_database.sql` terlebih dahulu

### Data obat tidak muncul di aplikasi
1. Jalankan query: `SELECT COUNT(*) FROM Tab_Obat_Mst;`
2. Harusnya return 5609 records
3. Check koneksi ZConnection di aplikasi
4. Pastikan DataSource terhubung dengan benar

---

## 📝 Log Perubahan

**2025-01-14**
- ✅ Migrasi 5609 data obat dari mfkalimantan.tab_obt_mst
- ✅ Konsolidasi 03_initial_data.sql dengan data production
- ✅ Hapus file temporary (04_import_from_existing.sql, 05_export_current_data.sql)
- ✅ Update dokumentasi README

**2025-01-13**
- ✅ Setup struktur database awal
- ✅ Buat file 01, 02, 03 untuk instalasi fresh

---

## 💡 Tips

- Untuk testing, gunakan user `a` dengan password `a` (paling cepat)
- Untuk demo, gunakan user `admin` dengan password `admin123`
- Data obat bisa di-filter di form UAjar.pas dengan cara ketik nama obat
- Aplikasi support pencarian case-insensitive dengan UPPER()

---

**Dibuat oleh:** GitHub Copilot  
**Tanggal:** 14 Januari 2025  
**Stack:** Delphi 7 + MySQL + ZeosLib + UNIDAC TVirtualTable
