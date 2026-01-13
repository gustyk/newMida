# 🚀 Quick Start Guide - PKasir

Panduan singkat untuk setup project di komputer baru.

## ⚡ Setup Cepat (5 Menit)

### 1. Clone Repository
```bash
git clone https://github.com/gustyk/newMida.git
cd "newMida/Proyek 2025"
```

### 2. Setup Database
Buka phpMyAdmin: http://localhost/phpmyadmin

Copy-paste dan Execute script berikut **SECARA BERURUTAN**:

#### Script 1: Create Database
```sql
CREATE DATABASE IF NOT EXISTS `apotek` 
DEFAULT CHARACTER SET utf8mb4 
DEFAULT COLLATE utf8mb4_general_ci;
USE `apotek`;
```

#### Script 2: Create Tables
Buka dan copy-paste isi file: `database/02_create_tables.sql`

#### Script 3: Data Awal (Optional)
Buka dan copy-paste isi file: `database/03_initial_data.sql`

### 3. Open di Delphi 7
1. Buka Delphi 7
2. File → Open → Pilih `PKasir.dpr`
3. Project → Build PKasir
4. Run (F9)

### 4. Login
- Username: `admin`
- Password: `admin123`
- Shift: (isi bebas)

✅ **SELESAI!** Aplikasi siap digunakan.

---

## 📝 Workflow Harian

### Sebelum Mulai Kerja:
```bash
cd "c:\Apps\Mida050125\Proyek 2025"
git pull origin main
```

### Setelah Selesai Kerja:
```bash
git add .
git commit -m "Deskripsi pekerjaan hari ini"
git push origin main
```

---

## 🆘 Troubleshooting Cepat

| Masalah | Solusi |
|---------|--------|
| **Database belum setup** | Jalankan script di folder `database/` |
| **MySQL tidak running** | Start XAMPP/MySQL service |
| **Koneksi gagal** | Cek setting di `UDM.dfm` → komponen `Koneksi` |
| **ZeosLib error** | Install komponen ZeosLib di Delphi 7 |
| **UNIDAC error** | Install komponen UNIDAC di Delphi 7 |

---

## 📚 Dokumentasi Lengkap

- **Setup Detail**: [README.md](README.md)
- **Database**: [database/README.md](database/README.md)
- **SRS**: [SRS_MidaFarma.md](SRS_MidaFarma.md)

---

**Repository**: https://github.com/gustyk/newMida.git
