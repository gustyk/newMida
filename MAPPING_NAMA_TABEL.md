# Mapping Nama Tabel & Field (English → Bahasa Indonesia)

## Tabel Master Data

| Nama Lama | Nama Baru | Keterangan |
|-----------|-----------|------------|
| `tab_apotek_mst` | `tb_apotek_mst` | Apotek |
| `tab_cabang_mst` | `tb_cabang_mst` | Cabang |
| `tab_cat_mst` | `tb_kategori_mst` | Kategori obat |
| `tab_satuan_mst` | `tb_satuan_mst` | Satuan |
| `tab_obat_mst` | `tb_obat_mst` | Master obat |
| `tab_obat_batch` | `tb_batch_obat` | Batch obat |
| `tab_stok_per_cabang` | `tb_stok_cabang` | Stok per lokasi |
| `tab_supplier_mst` | `tb_supplier_mst` | Supplier |
| `tab_bayar_mst` | `tb_metode_bayar_mst` | Metode pembayaran |
| `tab_user_mst` | `tb_pengguna_mst` | User/Pengguna |
| `tab_role_permission` | `tb_hak_akses` | Permission |

## Tabel Transaksi

| Nama Lama | Nama Baru | Keterangan |
|-----------|-----------|------------|
| `tab_order_mst` | `tb_pembelian_trx` | Header pembelian |
| `tab_order_det` | `tb_pembelian_dtl` | Detail pembelian |
| `tab_receive_mst` | `tb_penerimaan_trx` | Header penerimaan |
| `tab_receive_det` | `tb_penerimaan_dtl` | Detail penerimaan |
| `tab_kirim_mst` | `tb_pengiriman_trx` | Header pengiriman |
| `tab_kirim_det` | `tb_pengiriman_dtl` | Detail pengiriman |
| `tab_request_barang_mst` | `tb_request_trx` | Header request barang |
| `tab_request_barang_det` | `tb_request_dtl` | Detail request |
| `tab_sell_mst` | `tb_penjualan_trx` | Header penjualan |
| `tab_sell_det` | `tb_penjualan_dtl` | Detail penjualan |
| `tab_racik_mst` | `tb_racikan_trx` | Header racikan |
| `tab_racik_det` | `tb_racikan_dtl` | Detail racikan |
| `tab_mut_mst` | `tb_mutasi_trx` | Header mutasi stok |
| `tab_mut_det` | `tb_mutasi_dtl` | Detail mutasi |

## Tabel Payroll

| Nama Lama | Nama Baru | Keterangan |
|-----------|-----------|------------|
| `tab_karyawan_mst` | `tb_karyawan_mst` | Master karyawan |
| `tab_jabatan_mst` | `tb_jabatan_mst` | Master jabatan |
| `tab_komponen_gaji` | `tb_komponen_gaji_mst` | Komponen gaji |
| `tab_payroll_mst` | `tb_penggajian_trx` | Header payroll |
| `tab_payroll_det` | `tb_penggajian_dtl` | Detail payroll |

## Tabel Akuntansi

| Nama Lama | Nama Baru | Keterangan |
|-----------|-----------|------------|
| `tab_coa` | `tb_akun_mst` | Chart of Accounts |
| `tab_jurnal_mst` | `tb_jurnal_trx` | Header jurnal |
| `tab_jurnal_det` | `tb_jurnal_dtl` | Detail jurnal |
| `tab_closing_periode` | `tb_closing_periode` | Closing periode |

## Tabel Sistem

| Nama Lama | Nama Baru | Keterangan |
|-----------|-----------|------------|
| `tab_generator` | `tb_auto_number` | Auto numbering |
| `tab_log` | `tb_log_aktivitas` | Activity log |
| `tab_sync_queue` | `tb_antrian_sync` | Sync queue |
| `tab_sync_log` | `tb_log_sync` | Sync log |
| `tab_settings` | `tb_pengaturan` | Settings |
| `tab_stok_history` | `tb_histori_stok` | Histori stok |
| `tab_notification` | `tb_notifikasi` | Notifikasi |

---

## Mapping Field Umum

| Field Lama | Field Baru | Keterangan |
|------------|------------|------------|
| `*_id` | `*_id` | ID tetap sama |
| `*_code` | `kode_*` | Kode |
| `*_name` | `nama_*` | Nama |
| `*_number` | `no_*` | Nomor |
| `address` | `alamat` | Alamat |
| `phone` | `telepon` | Telepon |
| `description` | `keterangan` | Keterangan |
| `notes` | `catatan` | Catatan |
| `is_active` | `is_aktif` | Status aktif |
| `created_at` | `waktu_buat` | Waktu dibuat |
| `updated_at` | `waktu_ubah` | Waktu update |
| `created_by` | `dibuat_oleh` | User pembuat |
| `updated_by` | `diubah_oleh` | User update |
| `approved_by` | `disetujui_oleh` | User approval |
| `approved_at` | `waktu_approve` | Waktu approval |
| `qty_*` | `qty_*` | Quantity (singkatan umum) |
| `harga_*` | `harga_*` | Harga (tetap) |
| `total_*` | `total_*` | Total (tetap) |
| `discount_*` | `diskon_*` | Diskon |
| `grand_total` | `total_akhir` | Total akhir |
| `status` | `status` | Status (tetap) |
| `date` | `tanggal` atau `tgl_*` | Tanggal |

---

## Contoh Transformasi

### Sebelum:
```sql
CREATE TABLE tab_order_mst (
    order_id SERIAL PRIMARY KEY,
    order_number VARCHAR(30),
    order_date DATE,
    supplier_id INT,
    total_amount DECIMAL(15,2),
    created_by INT,
    created_at TIMESTAMP
);
```

### Sesudah:
```sql
CREATE TABLE tb_pembelian_trx (
    pembelian_id SERIAL PRIMARY KEY,
    no_pembelian VARCHAR(30),
    tgl_pembelian DATE,
    supplier_id INT,
    nominal_total DECIMAL(15,2),
    dibuat_oleh INT,
    waktu_buat TIMESTAMP
);
```
