# Database Management - PKasir

## 📋 Deskripsi
Folder ini berisi SQL scripts untuk setup database aplikasi PKasir (Point of Sales Apotek).

**Catatan Penting:** Database dikembangkan secara **bertahap** sesuai kebutuhan pengembangan kode, bukan dibuat ideal dari awal.

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
| `02_create_tables.sql` | Membuat 5 tabel dasar | ✅ Ya |
| `03_initial_data.sql` | Data awal untuk testing | ⚪ Optional |

## 🗄️ Struktur Database (Tahap Awal)

### Database: `apotek`

Pada tahap pengembangan ini, database memiliki **5 tabel**:

---

#### Tabel 1: `Tab_User` (Master Data User)
Daftar pengguna untuk login ke sistem.

| Kolom | Tipe | Keterangan |
|-------|------|------------|
| **nama** | VARCHAR(50) PK | Username untuk login |
| **password** | VARCHAR(50) | Password user |
| **shift** | VARCHAR(20) | Shift kerja (Pagi/Siang/Malam) |

---

#### Tabel 2: `Tab_Obat_Mst` (Master Data Obat)
Header data obat dengan informasi lengkap harga dan stok.

| Kolom | Tipe | Keterangan |
|-------|------|------------|
| **OBT_ID** | INT(11) PK | ID unik obat |
| **OBT_NM** | VARCHAR(30) | Nama obat |
| OBT_CATEGORY | VARCHAR(15) | Kategori obat |
| PRC_RETAIL | DOUBLE | Harga jual retail |
| PRC_PURCNET | DOUBLE | Harga beli netto |
| OBT_QTY | DOUBLE | Quantity/jumlah stok |
| OBT_MINQTY | DOUBLE | Stok minimum |
| BOX_CONTAIN | INT(11) | Isi per box |
| SatuanEcer | VARCHAR(15) | Satuan ecer (Strip/Botol/dll) |
| PRC_BOX | DOUBLE(15,3) | Harga per box |
| OBT_LOCATION | VARCHAR(10) | Lokasi penyimpanan |
| MODIFY | INT(11) | Flag modifikasi |
| EMP_ID | INT(11) | ID employee yang input |
| STOCK_OP | INT(11) | Stock opname |
| BARCODE | VARCHAR(15) | Barcode obat |
| CODE | VARCHAR(15) | Kode obat |
| LAST_ORDER | INT(11) | Pesanan terakhir |

---

#### Tabel 3: `Tab_Obat_Dtl` (Detail Stok Obat)
Detail stok obat per item.

| Kolom | Tipe | Keterangan |
|-------|------|------------|
| **ID_STOCK** | INT(11) PK AI | ID unique stok |
| ID_OBAT | INT(11) | Referensi ke OBT_ID di Tab_Obat_Mst |
| STOCK | DECIMAL(10,0) | Jumlah stok |
| BARCODE | VARCHAR(15) | Barcode item |

---

#### Tabel 4: `Tab_Mut_Mst` (Header Mutasi Stok)
Header/kepala dari mutasi stok obat (keluar/masuk).

| Kolom | Tipe | Keterangan |
|-------|------|------------|
| MUT_ID | VARCHAR(13) | ID mutasi unik |
| **MUT_TYPE** | VARCHAR(2) | Jenis mutasi (01=Beli, 02=Jual, dst) |
| MUT_INPDATE | DATETIME | Tanggal input mutasi |
| FAK_NO | VARCHAR(30) | Nomor faktur |
| FAK_DATE | DATETIME | Tanggal faktur |
| SUP_ID | VARCHAR(3) | ID supplier |
| MUT_VALUE | DOUBLE(15,3) | Nilai mutasi |
| PPN | DOUBLE(15,3) | Nilai PPN |
| PPN_INCLUDED | TINYINT(1) | PPN sudah termasuk? |
| PAY_TYPE | VARCHAR(1) | Tipe pembayaran (C=Cash, dll) |
| PAY_DATE | DATETIME | Tanggal pembayaran |
| MUT_TO | VARCHAR(25) | Mutasi ke siapa/mana |
| REQ_ID | VARCHAR(20) | ID permintaan |
| EMP_ID | INT(11) | ID employee |
| IS_LOCKED | TINYINT(4) | Status locked |
| MUT_STATUS | INT(4) | Status mutasi |
| jenis_nota | VARCHAR(20) | Jenis nota |

**Kode MUT_TYPE (contoh):**
- `01` = Pembelian/Stock In
- `02` = Penjualan/Stock Out
- `03` = Retur
- `04` = Pindah gudang
- Dan seterusnya sesuai kebutuhan

---

#### Tabel 5: `Tab_Mut_Dtl` (Detail Mutasi Stok)
Detail item obat per mutasi dengan perhitungan harga lengkap.

| Kolom | Tipe | Keterangan |
|-------|------|------------|
| **MUT_NO** | INT(11) PK AI | Nomor urut mutasi |
| MUT_ID | VARCHAR(20) | Referensi ke MUT_ID di Tab_Mut_Mst |
| OBT_ID | INT(11) | Referensi ke OBT_ID di Tab_Obat_Mst |
| OBT_NM | VARCHAR(30) | Nama obat (denormalisasi) |
| PRC_BOX | DOUBLE(15,3) | Harga per box |
| OBT_QTY | DOUBLE | Quantity obat |
| PRC_BON | INT(11) | Harga bonus |
| PRC_DISCNUM | DOUBLE(15,3) | Diskon nominal |
| PRC_DISCPERC | DOUBLE(15,3) | Diskon persentase |
| PUR_TOT | DOUBLE(15,3) | Total pembelian |
| PRC_PURCNET | DOUBLE(15,3) | Harga beli netto |
| PRC_PURCGROSS | DOUBLE(15,3) | Harga beli gross |
| PRC_PURCNET_TOT | DOUBLE(15,3) | Total harga beli netto |
| PRC_RETAIL | DOUBLE(15,3) | Harga retail |
| BOX_QTY | DOUBLE(15,3) | Quantity box |
| BOX_CONTAIN | INT(11) | Isi per box |
| PPN_FLAG | DOUBLE | Flag PPN |
| OBT_LOCATION | VARCHAR(5) | Lokasi obat |
| EMP_ID | INT(11) | ID employee |
| STOK | INT(11) | Stok saat ini |
| RET_MUT_ID | VARCHAR(30) | ID mutasi retur |
| MUT_DATE | DATETIME | Tanggal mutasi |
| MUT_STATUS | INT(11) | Status mutasi |
| MUT_TYPE | INT(11) | Tipe mutasi |
| PRC_RETAIL_TOT | DOUBLE | Total harga retail |
| PRC_RETAILNET_TOT | DOUBLE | Total harga retail netto |
| EMBALASE | DOUBLE | Biaya embalase |

---

## 🔧 Verifikasi Database

Setelah menjalankan script, verifikasi dengan query berikut di phpMyAdmin:

```sql
-- Cek database
SHOW DATABASES LIKE 'apotek';

-- Cek tabel
USE apotek;
SHOW TABLES;

-- Cek struktur tabel
DESCRIBE Tab_User;
DESCRIBE Tab_Obat_Mst;
DESCRIBE Tab_Obat_Dtl;
DESCRIBE Tab_Mut_Mst;
DESCRIBE Tab_Mut_Dtl;

-- Cek data awal
SELECT * FROM Tab_User;
SELECT * FROM Tab_Obat_Mst;
SELECT * FROM Tab_Obat_Dtl;
```

## 📝 Catatan Penting

1. **Database Bertahap**: Struktur database akan berkembang sesuai kebutuhan kode. Ini bukan design ideal dari awal, tapi disesuaikan dengan kebutuhan pengguna.

2. **Backup Database**: Sebelum menjalankan perubahan, backup dulu database:
   ```sql
   mysqldump -u root -p apotek > backup_apotek_YYYYMMDD.sql
   ```

3. **Restore Database**:
   ```bash
   mysql -u root -p apotek < backup_apotek_YYYYMMDD.sql
   ```

4. **Password Default**:
   - User: `admin`, Password: `admin123`, Shift: `Pagi`
   - User: `kasir1`, Password: `kasir123`, Shift: `Pagi`
   - User: `kasir2`, Password: `kasir123`, Shift: `Siang`
   - **⚠️ GANTI PASSWORD setelah setup!**

5. **Koneksi di Delphi**:
   - Host: `localhost`
   - Port: `3306`
   - Database: `apotek`
   - User: `root`
   - Password: (sesuaikan dengan setting MySQL Anda)

## 🔄 Pengembangan Database Selanjutnya

Ketika ada penambahan tabel atau perubahan struktur:
1. Buat file baru: `04_alter_xxx.sql` atau `05_create_xxx.sql`
2. Commit ke Git dengan deskripsi jelas
3. Update dokumentasi ini
4. Informasikan ke tim developer lain

Contoh:
```sql
-- 04_add_table_supplier.sql
USE apotek;
CREATE TABLE IF NOT EXISTS Tab_Supplier (
  SUP_ID VARCHAR(3) PRIMARY KEY,
  SUP_NAME VARCHAR(50),
  ...
);
```

## ⚠️ Troubleshooting

**Error: Database already exists**
- Tidak masalah, script menggunakan `CREATE IF NOT EXISTS`

**Error: Table already exists**
- Tidak masalah, script menggunakan `CREATE TABLE IF NOT EXISTS`

**Error: Access denied**
- Pastikan user MySQL memiliki privilege yang cukup
- Gunakan user `root` atau user dengan `GRANT ALL PRIVILEGES`

## 💡 Konsep Nama Field

Database ini menggunakan konvensi penamaan yang **existing/legacy**:
- `OBT_` = Obat (medicine)
- `PRC_` = Price (harga)
- `MUT_` = Mutasi (mutation/movement)
- `SUP_` = Supplier
- `EMP_` = Employee
- `FAK_` = Faktur (invoice)

Pertahankan konvensi ini untuk konsistensi dengan sistem yang sudah berjalan.
