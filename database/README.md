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

#### Tabel: `Tab_Mut_Mst` (Master/Header Mutasi Obat)
| Kolom | Tipe | Keterangan |
|-------|------|------------|
| No_Mutasi | VARCHAR(50) (PK) | Nomor mutasi unik (format: JUAL-YYYYMMDD-XXXX) |
| Tgl_Mutasi | DATETIME | Tanggal mutasi |
| Kode_Mutasi | VARCHAR(20) | JUAL/MASUK/KELUAR/RETUR/OPNAME/RUSAK/KADALUARSA/PINDAH |
| Keterangan_Mutasi | VARCHAR(100) | Deskripsi singkat mutasi |
| ID_User | VARCHAR(20) | User yang melakukan mutasi |
| Shift | VARCHAR(10) | Shift kerja (Pagi/Siang/Malam) |
| Grand_Total | DECIMAL(15,2) | Total keseluruhan (untuk JUAL) |
| Cara_Bayar | ENUM | Tunai/Qris/BCA/BRI/BNI/Hallo DOC/BPJS/Transfer/Kredit |
| Jumlah_Bayar | DECIMAL(15,2) | Jumlah yang dibayar customer (untuk JUAL) |
| Kembalian | DECIMAL(15,2) | Kembalian (untuk JUAL) |
| Status | ENUM | DRAFT/PENDING/SELESAI/BATAL |
| Keterangan | TEXT | Catatan lengkap mutasi |

**Kode Mutasi yang dapat digunakan:**
- **JUAL**: Penjualan ke customer (mengurangi stok)
- **MASUK**: Pembelian/penerimaan obat dari supplier (menambah stok)
- **KELUAR**: Pengeluaran obat non-penjualan (mengurangi stok)
- **RETUR**: Retur dari customer (menambah stok)
- **OPNAME**: Stock opname (koreksi stok)
- **RUSAK**: Obat rusak (mengurangi stok)
- **KADALUARSA**: Obat kadaluarsa (mengurangi stok)
- **PINDAH**: Pindah lokasi/gudang (tidak mengubah stok total)

#### Tabel: `Tab_Mut_Dtl` (Detail Mutasi Obat)
| Kolom | Tipe | Keterangan |
|-------|------|------------|
| ID_Detail | INT (PK, AI) | ID unik detail |
| No_Mutasi | VARCHAR(50) (FK) | Referensi ke Tab_Mut_Mst |
| ID_Obat | INT (FK) | Referensi ke Tab_Obat_Mst |
| Jumlah | DECIMAL(10,2) | Jumlah obat (+ untuk masuk, - untuk keluar) |
| Harga | DECIMAL(15,2) | Harga per unit |
| Diskon_Persen | DECIMAL(5,2) | Diskon dalam persen (%) |
| Diskon_Rupiah | DECIMAL(15,2) | Diskon dalam rupiah |
| Embalase | DECIMAL(15,2) | Biaya embalase |
| SubTotal | DECIMAL(15,2) | SubTotal = (Harga × Jumlah) - Diskon + Embalase |
| Keterangan | VARCHAR(255) | Catatan tambahan per item |

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
DESCRIBE Tab_Mut_Mst;
DESCRIBE Tab_Mut_Dtl;
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
- Tab_Obat_Mst dan Tab_Mut_Mst harus dibuat dulu sebelum Tab_Mut_Dtl

## 💡 Konsep Mutasi

Sistem menggunakan konsep **Mutasi** untuk semua pergerakan obat:
- **Header Mutasi** (`Tab_Mut_Mst`) menyimpan informasi umum: siapa, kapan, jenis mutasi apa
- **Detail Mutasi** (`Tab_Mut_Dtl`) menyimpan item-item obat yang terlibat dalam mutasi tersebut

**Contoh Penggunaan:**

**Penjualan (JUAL):**
```
Tab_Mut_Mst:
  No_Mutasi: JUAL-20260113-0001
  Kode_Mutasi: JUAL
  Grand_Total: 50000
  Cara_Bayar: Tunai
  Status: SELESAI

Tab_Mut_Dtl:
  - Paracetamol, Jumlah: 2, Harga: 5000, SubTotal: 10000
  - OBH Combi, Jumlah: 2, Harga: 20000, SubTotal: 40000
```

**Pembelian (MASUK):**
```
Tab_Mut_Mst:
  No_Mutasi: MASUK-20260113-0001
  Kode_Mutasi: MASUK
  Keterangan_Mutasi: Pembelian dari PT Kimia Farma
  Status: SELESAI

Tab_Mut_Dtl:
  - Paracetamol, Jumlah: 100, Harga: 4000
  - Amoxicillin, Jumlah: 50, Harga: 12000
```

Sistem ini fleksibel untuk berbagai jenis mutasi stok!
