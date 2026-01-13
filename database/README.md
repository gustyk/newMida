# Database Management - PKasir

## 📋 Deskripsi
Folder ini berisi SQL scripts untuk setup database aplikasi PKasir (Point of Sales Apotek).

## 🚀 Cara Setup Database (Komputer Baru)

### Metode 1: Via phpMyAdmin
1. Buka phpMyAdmin di browser: `http://localhost/phpmyadmin`
2. Login dengan user `root` (password: kosong atau sesuai setting)
3. Klik tab **SQL**
4. Jalankan script secara berurutan:
   - Copy-paste isi `01_create_database.sql` → Execute
   - Copy-paste isi `02_create_tables.sql` → Execute
   - Copy-paste isi `03_initial_data.sql` → Execute (optional)

### Metode 2: Via Command Line MySQL
```bash
# Masuk ke folder database
cd "c:\Apps\Mida050125\Proyek 2025\database"

# Jalankan script berurutan
mysql -u root -p < 01_create_database.sql
mysql -u root -p < 02_create_tables.sql
mysql -u root -p < 03_initial_data.sql
```

## 📂 Daftar File SQL

| File | Deskripsi | Wajib? |
|------|-----------|--------|
| `01_create_database.sql` | Membuat database `apotek` | ✅ Ya |
| `02_create_tables.sql` | Membuat semua tabel | ✅ Ya |
| `03_initial_data.sql` | Data awal untuk testing | ⚪ Optional |

## 🗄️ Struktur Database

### Database: `apotek`

#### Tabel: `Tab_Obat_Mst` (Master Data Obat)
| Kolom | Tipe | Keterangan |
|-------|------|------------|
| ID_Obat | INT (PK, AI) | ID unik obat |
| Nama_Obat | VARCHAR(100) | Nama obat |
| Harga | DECIMAL(15,2) | Harga jual |
| Lokasi | VARCHAR(50) | Lokasi penyimpanan (contoh: Rak A1) |
| Satuan | VARCHAR(20) | Satuan (Strip/Botol/Box/dll) |
| Kategori | VARCHAR(50) | Kategori obat |
| Stok_Min | INT | Stok minimum (untuk alert) |
| Status_Aktif | TINYINT(1) | 1=Aktif, 0=Nonaktif |
| Tgl_Input | DATETIME | Tanggal input data |
| Tgl_Update | DATETIME | Tanggal terakhir update |

#### Tabel: `Tab_Obat_Dtl` (Detail Transaksi)
| Kolom | Tipe | Keterangan |
|-------|------|------------|
| ID_Detail | INT (PK, AI) | ID unik detail |
| ID_Obat | INT (FK) | Referensi ke Tab_Obat_Mst |
| No_Transaksi | VARCHAR(50) | Nomor transaksi |
| Tgl_Transaksi | DATETIME | Tanggal transaksi |
| Jenis_Transaksi | ENUM | MASUK/KELUAR/JUAL/RETUR |
| Jumlah | DECIMAL(10,2) | Jumlah obat |
| Harga | DECIMAL(15,2) | Harga per unit |
| Diskon_Persen | DECIMAL(5,2) | Diskon dalam persen (%) |
| Diskon_Rupiah | DECIMAL(15,2) | Diskon dalam rupiah |
| Embalase | DECIMAL(15,2) | Biaya embalase |
| SubTotal | DECIMAL(15,2) | SubTotal = (Harga × Jumlah) - Diskon + Embalase |
| Keterangan | VARCHAR(255) | Catatan tambahan |

#### Tabel: `Tab_Transaksi_Hdr` (Header Transaksi)
| Kolom | Tipe | Keterangan |
|-------|------|------------|
| No_Transaksi | VARCHAR(50) (PK) | Nomor transaksi (format: TRX-YYYYMMDD-XXXX) |
| Tgl_Transaksi | DATETIME | Tanggal transaksi |
| ID_User | VARCHAR(20) | User yang melakukan transaksi |
| Shift | VARCHAR(10) | Shift kerja (Pagi/Siang/Malam) |
| Grand_Total | DECIMAL(15,2) | Total keseluruhan |
| Cara_Bayar | ENUM | Tunai/Qris/BCA/BRI/BNI/Hallo DOC/BPJS |
| Jumlah_Bayar | DECIMAL(15,2) | Jumlah yang dibayar customer |
| Kembalian | DECIMAL(15,2) | Kembalian |
| Status | ENUM | PENDING/SELESAI/BATAL |
| Keterangan | VARCHAR(255) | Catatan transaksi |

#### Tabel: `Tab_User` (Master User)
| Kolom | Tipe | Keterangan |
|-------|------|------------|
| ID_User | VARCHAR(20) (PK) | Username untuk login |
| Nama_User | VARCHAR(100) | Nama lengkap user |
| Password | VARCHAR(255) | Password (plaintext - TODO: encrypt) |
| Level | ENUM | Admin/Kasir/Manager |
| Status_Aktif | TINYINT(1) | 1=Aktif, 0=Nonaktif |
| Tgl_Input | DATETIME | Tanggal input data |
| Tgl_Update | DATETIME | Tanggal terakhir update |

## 🔧 Verifikasi Database

Setelah menjalankan script, verifikasi dengan query berikut di phpMyAdmin:

```sql
-- Cek database
SHOW DATABASES LIKE 'apotek';

-- Cek tabel
USE apotek;
SHOW TABLES;

-- Cek struktur tabel
DESCRIBE Tab_Obat_Mst;
DESCRIBE Tab_Obat_Dtl;
DESCRIBE Tab_Transaksi_Hdr;
DESCRIBE Tab_User;

-- Cek data awal
SELECT * FROM Tab_User;
SELECT * FROM Tab_Obat_Mst;
```

## 📝 Catatan Penting

1. **Backup Database**: Sebelum menjalankan migration, backup dulu database yang ada:
   ```sql
   mysqldump -u root -p apotek > backup_apotek_YYYYMMDD.sql
   ```

2. **Restore Database**:
   ```bash
   mysql -u root -p apotek < backup_apotek_YYYYMMDD.sql
   ```

3. **Password Default**:
   - User: `admin`, Password: `admin123`
   - User: `kasir1`, Password: `kasir123`
   - **⚠️ GANTI PASSWORD setelah setup!**

4. **Koneksi di Delphi**:
   - Host: `localhost`
   - Port: `3306`
   - Database: `apotek`
   - User: `root`
   - Password: (sesuaikan dengan setting MySQL Anda)

## 🔄 Update Schema (Migrasi)

Jika ada perubahan struktur database:
1. Buat file baru: `04_alter_xxx.sql`
2. Gunakan `ALTER TABLE` bukan `CREATE TABLE`
3. Commit file SQL ke Git
4. Update dokumentasi ini

Contoh:
```sql
-- 04_alter_add_kolom_barcode.sql
USE apotek;
ALTER TABLE Tab_Obat_Mst ADD COLUMN Barcode VARCHAR(50) AFTER Nama_Obat;
```

## ⚠️ Troubleshooting

**Error: Database already exists**
- Tidak masalah, script menggunakan `CREATE IF NOT EXISTS`

**Error: Table already exists**
- Tidak masalah, script menggunakan `CREATE TABLE IF NOT EXISTS`

**Error: Access denied**
- Pastikan user MySQL memiliki privilege yang cukup
- Gunakan user `root` atau user dengan `GRANT ALL PRIVILEGES`

**Error: Foreign key constraint fails**
- Pastikan menjalankan script secara berurutan
- Tab_Obat_Mst harus dibuat dulu sebelum Tab_Obat_Dtl
