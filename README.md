# PKasir - Point of Sales Apotek

Aplikasi Point of Sales (POS) untuk Apotek berbasis **Delphi 7** dengan database **MySQL**.

## 📋 Informasi Project

| Item | Keterangan |
|------|------------|
| **Nama Aplikasi** | PKasir |
| **Versi** | 1.0 (Development) |
| **Platform** | Windows (Delphi 7) |
| **Database** | MySQL 5.x / MariaDB |
| **Bahasa Pengkodean** | Pascal (Object Pascal) |
| **Gaya Kode** | Bahasa Indonesia (komentar & penamaan) |

## 🛠️ Technology Stack

- **IDE**: Delphi 7 (tidak kompatibel dengan versi lebih tinggi)
- **Database**: MySQL via phpMyAdmin
- **Database Components**: ZeosLib (TZConnection, TZQuery, TZTable)
- **Virtual Table**: UNIDAC TVirtualTable (bukan TDataSet bawaan)
- **Reporting**: FastReport 5 (tidak kompatibel dengan versi lebih tinggi)

## 📂 Struktur Project

```
Proyek 2025/
│
├── PKasir.dpr              # File project utama
├── PKasir.res              # Resource file (icon, version)
├── .gitignore              # Git ignore configuration
│
├── database/               # 📁 SQL Scripts & Database Documentation
│   ├── README.md              # Panduan setup database
│   ├── 01_create_database.sql # Script create database
│   ├── 02_create_tables.sql   # Script create tabel
│   └── 03_initial_data.sql    # Script data awal (optional)
│
├── UAjar.pas/.dfm          # Form Penjualan (Form Utama)
├── ULogin.pas/.dfm         # Form Login
├── Ubayar.pas/.dfm         # Form Pembayaran
├── URacik.pas/.dfm         # Form Racik Obat
├── UTest.pas/.dfm          # Form Testing
├── UDM.pas/.dfm            # Data Module (koneksi & dataset)
├── UPustaka.pas            # Library fungsi umum
└── UDBSetup.pas            # Auto-validation database
```

## 🚀 Setup Project (Komputer Baru)

### 1️⃣ Clone Repository
```bash
git clone https://github.com/gustyk/newMida.git
cd newMida
```

### 2️⃣ Setup Database
Ikuti panduan lengkap di: [database/README.md](database/README.md)

**Quick Setup:**
1. Buka phpMyAdmin: http://localhost/phpmyadmin
2. Klik tab **SQL**
3. Jalankan script berurutan:
   - `database/01_create_database.sql`
   - `database/02_create_tables.sql`
   - `database/03_initial_data.sql` (optional - data sample)

### 3️⃣ Konfigurasi Koneksi Database
Buka Delphi 7 → Double-click `UDM.dfm` → Cek komponen `Koneksi` (TZConnection):
- **HostName**: localhost
- **Port**: 3306
- **Database**: apotek
- **User**: root
- **Password**: (sesuaikan dengan MySQL Anda)

### 4️⃣ Compile & Run
1. Buka `PKasir.dpr` di Delphi 7
2. Project → Build PKasir
3. Run → Run (F9)

## 🔑 Login Default

Setelah menjalankan `03_initial_data.sql`:

| Username | Password | Level |
|----------|----------|-------|
| admin | admin123 | Admin |
| kasir1 | kasir123 | Kasir |
| kasir2 | kasir123 | Kasir |

⚠️ **GANTI PASSWORD** setelah setup!

## 📊 Database Schema

### Tabel Utama (Tahap Awal - 5 Tabel):
1. **Tab_User** - Master data user untuk login (nama, password, shift)
2. **Tab_Obat_Mst** - Master data obat dengan harga dan stok
3. **Tab_Obat_Dtl** - Detail stok obat per item
4. **Tab_Mut_Mst** - Header mutasi stok (pembelian, penjualan, retur, dll)
5. **Tab_Mut_Dtl** - Detail item obat per mutasi

**Catatan:** Database dikembangkan **bertahap** sesuai kebutuhan pengembangan kode, bukan ideal dari awal.

Lihat detail struktur di: [database/README.md](database/README.md)

## 🎯 Fitur

### ✅ Sudah Diimplementasi:
- Login dengan User, Password, Shift
- Pencarian obat (autocomplete)
- Input penjualan ke VirtualTable
- Perhitungan otomatis:
  - SubTotal = (Harga × Jumlah) - Diskon + Embalase
  - Grand Total
  - Konversi Diskon % ↔ Rupiah
- Form Racik untuk perhitungan obat racikan
- Multi metode pembayaran (Tunai, QRIS, Bank, BPJS, dll)
- Auto-validasi database saat startup

### 🚧 Dalam Pengembangan:
- Integrasi FastReport 5 untuk cetak struk
- Laporan penjualan (harian, periodik)
- Manajemen stok obat
- Retur penjualan
- Close kasir per shift
- Backup database otomatis

## ⌨️ Keyboard Shortcuts

| Tombol | Fungsi |
|--------|--------|
| **Enter** | Pindah kolom / konfirmasi input |
| **F2** | Save transaksi (placeholder) |
| **F4** | Buka Form Racik (dari kolom Jumlah) |
| **Esc** | Cancel / kembali |

## 📝 Gaya Pengkodean (Coding Style)

**WAJIB ditiru untuk konsistensi:**

### 1. Komentar dalam Bahasa Indonesia
```pascal
// Jika ada perubahan di Edt_Obat maka Grid Obat akan menampilkan sesuai dengan
// Yang dipilih
```

### 2. Header Blok dengan Border
```pascal
// *****************************************************************************
// Procedure HitungSubTotal
// Menghitung subtotal per item: (Harga × Jumlah) - Diskon + Embalase
// *****************************************************************************
```

### 3. Prefix Penamaan Komponen
- `Frm_` untuk Form (Frm_Login, Frm_Jual)
- `Btn_` untuk Button (Btn_Exit, Btn_Ok)
- `Edt_` untuk Edit (Edt_Obat, Edt_User)
- `Lbl_` untuk Label
- `Que_` untuk Query
- `DS_` untuk DataSource
- `CDS_` untuk ClientDataSet
- `CB_` untuk ComboBox

### 4. Komentar Inline
```pascal
VT.FieldByName('JUMLAH').AsString := '1';     // default = 1
Grid_Jual.EditorMode := true;                 // Warna jadi biru
```

### 5. DILARANG Hapus Kode!
Jika perlu mengubah/menghapus, **COMMENT** kode lama + tambahkan keterangan:
```pascal
// --- Kode lama (dihapus karena tidak efisien) ---
// if Diskon > 0 then ...

// --- Kode baru menggunakan validasi NULL ---
if not VT.fieldByName('Diskon').IsNull then
  Diskon := VT.fieldByName('Diskon').AsFloat 
else 
  Diskon := 0;
```

## 🔄 Git Workflow

### Pull (Sinkronisasi) sebelum kerja:
```bash
git pull origin main
```

### Commit perubahan:
```bash
git add .
git commit -m "Deskripsi perubahan dengan jelas"
git push origin main
```

### Cek status:
```bash
git status
git log --oneline -5
```

## ⚠️ File yang TIDAK di-track Git

File-file berikut **tidak** akan di-upload ke repository (sudah ada di `.gitignore`):
- `*.~*` - File backup Delphi
- `*.dcu` - File compiled unit
- `*.cfg`, `*.dof`, `*.ddp` - Konfigurasi lokal (berbeda tiap komputer)
- `*.exe`, `*.dll` - Binary files
- `backup_*.sql` - Backup database

## 🐛 Troubleshooting

### Error: Database belum setup
- Jalankan SQL scripts di folder `database/`
- Lihat panduan: [database/README.md](database/README.md)

### Error: Koneksi database gagal
- Pastikan MySQL Server sudah running
- Cek username/password di `UDM.dfm` → komponen `Koneksi`
- Test koneksi: `Connected := True` di Object Inspector

### Error: Komponen ZeosLib tidak ditemukan
- Install ZeosLib components di Delphi 7
- Restart Delphi

### Error: TVirtualTable tidak ditemukan
- Install UNIDAC components
- Restart Delphi

## 📞 Kontak & Support

Project ini adalah "pusat kebenaran" (source of truth) untuk aplikasi PKasir.  
Semua perubahan WAJIB di-commit ke repository ini.

---

**Terakhir Update**: 13 Januari 2026  
**Repository**: https://github.com/gustyk/newMida.git
