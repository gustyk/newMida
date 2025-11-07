-- ============================================
-- DATABASE STRUCTURE - MIDAFARMA
-- Struktur Database dengan Penamaan Indonesia
-- ============================================

-- ============================================
-- MASTER DATA TABLES
-- ============================================

CREATE TABLE tb_apotek_mst (
    apotek_id VARCHAR(20) PRIMARY KEY,
    nama_apotek VARCHAR(100) NOT NULL,
    alamat TEXT,
    telepon VARCHAR(20),
    email VARCHAR(100),
    npwp VARCHAR(30),
    no_sia VARCHAR(50),
    nama_apoteker VARCHAR(100),
    no_sipa VARCHAR(50),
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_cabang_mst (
    cabang_id SERIAL PRIMARY KEY,
    kode_cabang VARCHAR(10) UNIQUE NOT NULL,
    nama_cabang VARCHAR(100) NOT NULL,
    apotek_id VARCHAR(20) REFERENCES tb_apotek_mst(apotek_id),
    alamat TEXT,
    telepon VARCHAR(20),
    nama_pic VARCHAR(100),
    is_gudang_pusat BOOLEAN DEFAULT FALSE,
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_kategori_mst (
    kategori_id SERIAL PRIMARY KEY,
    kode_kategori VARCHAR(10) UNIQUE NOT NULL,
    nama_kategori VARCHAR(100) NOT NULL,
    keterangan TEXT,
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_satuan_mst (
    satuan_id SERIAL PRIMARY KEY,
    kode_satuan VARCHAR(10) UNIQUE NOT NULL,
    nama_satuan VARCHAR(50) NOT NULL,
    is_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE tb_obat_mst (
    obat_id SERIAL PRIMARY KEY,
    kode_obat VARCHAR(20) UNIQUE NOT NULL,
    nama_obat VARCHAR(200) NOT NULL,
    nama_generik VARCHAR(200),
    kategori_id INTEGER REFERENCES tb_kategori_mst(kategori_id),
    satuan_id INTEGER REFERENCES tb_satuan_mst(satuan_id),
    barcode VARCHAR(50),
    golongan VARCHAR(20),
    harga_beli DECIMAL(15,2),
    harga_jual_umum DECIMAL(15,2),
    harga_jual_resep DECIMAL(15,2),
    harga_jual_netto DECIMAL(15,2),
    persen_margin DECIMAL(5,2),
    stok_minimal INTEGER,
    pabrik VARCHAR(100),
    supplier_id INTEGER,
    is_resep BOOLEAN DEFAULT FALSE,
    is_racikan BOOLEAN DEFAULT FALSE,
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP,
    dibuat_oleh INTEGER,
    diubah_oleh INTEGER
);

CREATE TABLE tb_stok_cabang (
    stok_id SERIAL PRIMARY KEY,
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    batch_id INTEGER,
    qty_tersedia INTEGER DEFAULT 0,
    stok_minimal INTEGER,
    waktu_ubah TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(obat_id, cabang_id, batch_id)
);

CREATE TABLE tb_batch_obat (
    batch_id SERIAL PRIMARY KEY,
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    no_batch VARCHAR(50),
    tgl_expired DATE,
    qty_stok INTEGER,
    tgl_terima DATE,
    harga_beli DECIMAL(15,2),
    is_expired BOOLEAN DEFAULT FALSE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_supplier_mst (
    supplier_id SERIAL PRIMARY KEY,
    kode_supplier VARCHAR(20) UNIQUE NOT NULL,
    nama_supplier VARCHAR(100) NOT NULL,
    alamat TEXT,
    telepon VARCHAR(20),
    email VARCHAR(100),
    nama_pic VARCHAR(100),
    telepon_pic VARCHAR(20),
    termin_bayar INTEGER,
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_metode_bayar_mst (
    metode_bayar_id SERIAL PRIMARY KEY,
    kode_bayar VARCHAR(10) UNIQUE NOT NULL,
    nama_bayar VARCHAR(50) NOT NULL,
    no_rekening VARCHAR(50),
    nama_rekening VARCHAR(100),
    nama_bank VARCHAR(50),
    is_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE tb_pengguna_mst (
    pengguna_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telepon VARCHAR(20),
    role VARCHAR(20) NOT NULL,
    cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_login_terakhir TIMESTAMP,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_hak_akses (
    hak_akses_id SERIAL PRIMARY KEY,
    role VARCHAR(20) NOT NULL,
    nama_modul VARCHAR(50) NOT NULL,
    bisa_buat BOOLEAN DEFAULT FALSE,
    bisa_baca BOOLEAN DEFAULT FALSE,
    bisa_ubah BOOLEAN DEFAULT FALSE,
    bisa_hapus BOOLEAN DEFAULT FALSE,
    bisa_approve BOOLEAN DEFAULT FALSE,
    bisa_export BOOLEAN DEFAULT FALSE
);

-- ============================================
-- TRANSAKSI PEMBELIAN & PENERIMAAN
-- ============================================

CREATE TABLE tb_pembelian_trx (
    pembelian_id SERIAL PRIMARY KEY,
    no_pembelian VARCHAR(30) UNIQUE NOT NULL,
    supplier_id INTEGER REFERENCES tb_supplier_mst(supplier_id),
    tgl_pembelian DATE NOT NULL,
    tgl_expected DATE,
    no_faktur VARCHAR(50),
    tgl_faktur DATE,
    nominal_subtotal DECIMAL(15,2),
    nominal_diskon DECIMAL(15,2),
    nominal_ppn DECIMAL(15,2),
    nominal_total DECIMAL(15,2),
    status VARCHAR(20),
    cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    catatan TEXT,
    url_lampiran VARCHAR(255),
    dibuat_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    disetujui_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_approve TIMESTAMP,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_pembelian_dtl (
    detail_id SERIAL PRIMARY KEY,
    pembelian_id INTEGER REFERENCES tb_pembelian_trx(pembelian_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    qty_pesan INTEGER,
    satuan_id INTEGER REFERENCES tb_satuan_mst(satuan_id),
    harga_beli DECIMAL(15,2),
    persen_diskon DECIMAL(5,2),
    nominal_diskon DECIMAL(15,2),
    subtotal DECIMAL(15,2),
    no_batch VARCHAR(50),
    tgl_expired DATE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_penerimaan_trx (
    penerimaan_id SERIAL PRIMARY KEY,
    no_penerimaan VARCHAR(30) UNIQUE NOT NULL,
    pembelian_id INTEGER REFERENCES tb_pembelian_trx(pembelian_id),
    pengiriman_id INTEGER,
    supplier_id INTEGER REFERENCES tb_supplier_mst(supplier_id),
    tgl_terima DATE NOT NULL,
    jenis_penerimaan VARCHAR(20),
    dari_cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    ke_cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    total_qty INTEGER,
    catatan TEXT,
    status VARCHAR(20),
    url_lampiran VARCHAR(255),
    diterima_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    disetujui_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_approve TIMESTAMP,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_penerimaan_dtl (
    detail_id SERIAL PRIMARY KEY,
    penerimaan_id INTEGER REFERENCES tb_penerimaan_trx(penerimaan_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    qty_terima INTEGER,
    qty_pesan INTEGER,
    qty_selisih INTEGER,
    no_batch VARCHAR(50),
    tgl_expired DATE,
    kondisi VARCHAR(20),
    catatan TEXT,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TRANSAKSI PENGIRIMAN & REQUEST
-- ============================================

CREATE TABLE tb_pengiriman_trx (
    pengiriman_id SERIAL PRIMARY KEY,
    no_pengiriman VARCHAR(30) UNIQUE NOT NULL,
    dari_cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    ke_cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    jenis_lokasi_asal VARCHAR(20),
    jenis_lokasi_tujuan VARCHAR(20),
    jenis_pengiriman VARCHAR(20),
    tgl_kirim DATE NOT NULL,
    total_qty INTEGER,
    nama_kurir VARCHAR(100),
    no_kendaraan VARCHAR(20),
    status VARCHAR(20),
    status_approval VARCHAR(20),
    disetujui_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_approve TIMESTAMP,
    catatan_approval TEXT,
    catatan TEXT,
    url_lampiran VARCHAR(255),
    dibuat_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_terkirim TIMESTAMP,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_pengiriman_dtl (
    detail_id SERIAL PRIMARY KEY,
    pengiriman_id INTEGER REFERENCES tb_pengiriman_trx(pengiriman_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    batch_id INTEGER REFERENCES tb_batch_obat(batch_id),
    qty_kirim INTEGER,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_request_trx (
    request_id SERIAL PRIMARY KEY,
    no_request VARCHAR(30) UNIQUE NOT NULL,
    dari_cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    tgl_request DATE NOT NULL,
    jenis_request VARCHAR(20),
    total_item INTEGER,
    catatan TEXT,
    status VARCHAR(20),
    direquest_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    disetujui_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_approve TIMESTAMP,
    pengiriman_id INTEGER,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_request_dtl (
    detail_id SERIAL PRIMARY KEY,
    request_id INTEGER REFERENCES tb_request_trx(request_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    qty_request INTEGER,
    qty_disetujui INTEGER,
    catatan TEXT,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TRANSAKSI PENJUALAN & RACIKAN
-- ============================================

CREATE TABLE tb_penjualan_trx (
    penjualan_id SERIAL PRIMARY KEY,
    no_transaksi VARCHAR(30) UNIQUE NOT NULL,
    tgl_transaksi TIMESTAMP NOT NULL,
    cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    kasir_id INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    metode_bayar_id INTEGER REFERENCES tb_metode_bayar_mst(metode_bayar_id),
    nama_customer VARCHAR(100),
    telepon_customer VARCHAR(20),
    no_resep VARCHAR(50),
    nama_dokter VARCHAR(100),
    nominal_subtotal DECIMAL(15,2),
    persen_diskon DECIMAL(5,2),
    nominal_diskon DECIMAL(15,2),
    nominal_total DECIMAL(15,2),
    nominal_bayar DECIMAL(15,2),
    nominal_kembali DECIMAL(15,2),
    catatan TEXT,
    is_retur BOOLEAN DEFAULT FALSE,
    retur_dari_penjualan_id INTEGER,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_penjualan_dtl (
    detail_id SERIAL PRIMARY KEY,
    penjualan_id INTEGER REFERENCES tb_penjualan_trx(penjualan_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    racikan_id INTEGER,
    batch_id INTEGER REFERENCES tb_batch_obat(batch_id),
    qty INTEGER,
    satuan_id INTEGER REFERENCES tb_satuan_mst(satuan_id),
    harga_jual DECIMAL(15,2),
    persen_diskon DECIMAL(5,2),
    nominal_diskon DECIMAL(15,2),
    subtotal DECIMAL(15,2),
    is_racikan BOOLEAN DEFAULT FALSE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_racikan_trx (
    racikan_id SERIAL PRIMARY KEY,
    kode_racikan VARCHAR(30),
    nama_racikan VARCHAR(100) NOT NULL,
    jenis_racikan VARCHAR(20),
    total_biaya DECIMAL(15,2),
    harga_jual DECIMAL(15,2),
    persen_margin DECIMAL(5,2),
    qty_output INTEGER,
    satuan_output VARCHAR(20),
    dibuat_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_racikan_dtl (
    detail_id SERIAL PRIMARY KEY,
    racikan_id INTEGER REFERENCES tb_racikan_trx(racikan_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    qty DECIMAL(10,3),
    satuan_id INTEGER REFERENCES tb_satuan_mst(satuan_id),
    harga_obat DECIMAL(15,2),
    subtotal DECIMAL(15,2),
    instruksi TEXT,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TRANSAKSI MUTASI STOK
-- ============================================

CREATE TABLE tb_mutasi_trx (
    mutasi_id SERIAL PRIMARY KEY,
    no_mutasi VARCHAR(30) UNIQUE NOT NULL,
    tgl_mutasi DATE NOT NULL,
    jenis_mutasi VARCHAR(20),
    cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    alasan TEXT,
    url_lampiran VARCHAR(255),
    status VARCHAR(20),
    dibuat_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    disetujui_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_approve TIMESTAMP,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_mutasi_dtl (
    detail_id SERIAL PRIMARY KEY,
    mutasi_id INTEGER REFERENCES tb_mutasi_trx(mutasi_id),
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    batch_id INTEGER REFERENCES tb_batch_obat(batch_id),
    qty INTEGER,
    arah_mutasi VARCHAR(5),
    catatan TEXT,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- PAYROLL
-- ============================================

CREATE TABLE tb_karyawan_mst (
    karyawan_id SERIAL PRIMARY KEY,
    nik VARCHAR(20) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    jabatan_id INTEGER,
    cabang_id INTEGER REFERENCES tb_cabang_mst(cabang_id),
    tgl_masuk DATE,
    tgl_keluar DATE,
    status VARCHAR(20),
    alamat TEXT,
    telepon VARCHAR(20),
    email VARCHAR(100),
    no_rekening VARCHAR(50),
    nama_rekening VARCHAR(100),
    nama_bank VARCHAR(50),
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_jabatan_mst (
    jabatan_id SERIAL PRIMARY KEY,
    kode_jabatan VARCHAR(10) UNIQUE NOT NULL,
    nama_jabatan VARCHAR(50) NOT NULL,
    gaji_pokok DECIMAL(15,2),
    tunjangan_transport DECIMAL(15,2),
    tunjangan_makan DECIMAL(15,2),
    is_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE tb_komponen_gaji_mst (
    komponen_id SERIAL PRIMARY KEY,
    kode_komponen VARCHAR(20) UNIQUE NOT NULL,
    nama_komponen VARCHAR(100) NOT NULL,
    tipe VARCHAR(10),
    is_kena_pajak BOOLEAN DEFAULT FALSE,
    is_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE tb_penggajian_trx (
    penggajian_id SERIAL PRIMARY KEY,
    no_penggajian VARCHAR(30) UNIQUE NOT NULL,
    periode_bulan INTEGER,
    periode_tahun INTEGER,
    karyawan_id INTEGER REFERENCES tb_karyawan_mst(karyawan_id),
    gaji_pokok DECIMAL(15,2),
    total_tunjangan DECIMAL(15,2),
    total_potongan DECIMAL(15,2),
    gaji_bruto DECIMAL(15,2),
    gaji_netto DECIMAL(15,2),
    status VARCHAR(20),
    tgl_bayar DATE,
    dibuat_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    disetujui_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_penggajian_dtl (
    detail_id SERIAL PRIMARY KEY,
    penggajian_id INTEGER REFERENCES tb_penggajian_trx(penggajian_id),
    komponen_id INTEGER REFERENCES tb_komponen_gaji_mst(komponen_id),
    nominal DECIMAL(15,2),
    catatan TEXT
);

-- ============================================
-- AKUNTANSI
-- ============================================

CREATE TABLE tb_akun_mst (
    akun_id SERIAL PRIMARY KEY,
    kode_akun VARCHAR(20) UNIQUE NOT NULL,
    nama_akun VARCHAR(100) NOT NULL,
    parent_id INTEGER REFERENCES tb_akun_mst(akun_id),
    level INTEGER,
    jenis_akun VARCHAR(20),
    saldo_normal VARCHAR(10),
    is_header BOOLEAN DEFAULT FALSE,
    is_aktif BOOLEAN DEFAULT TRUE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_jurnal_trx (
    jurnal_id SERIAL PRIMARY KEY,
    no_jurnal VARCHAR(30) UNIQUE NOT NULL,
    tgl_jurnal DATE NOT NULL,
    jenis_jurnal VARCHAR(20),
    modul_sumber VARCHAR(20),
    id_sumber INTEGER,
    keterangan TEXT,
    total_debet DECIMAL(15,2),
    total_kredit DECIMAL(15,2),
    status VARCHAR(20),
    dibuat_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    diposting_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_posting TIMESTAMP,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_ubah TIMESTAMP
);

CREATE TABLE tb_jurnal_dtl (
    detail_id SERIAL PRIMARY KEY,
    jurnal_id INTEGER REFERENCES tb_jurnal_trx(jurnal_id),
    akun_id INTEGER REFERENCES tb_akun_mst(akun_id),
    keterangan TEXT,
    debet DECIMAL(15,2),
    kredit DECIMAL(15,2),
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_closing_periode (
    closing_id SERIAL PRIMARY KEY,
    periode_bulan INTEGER,
    periode_tahun INTEGER,
    jenis_closing VARCHAR(20),
    tgl_closing DATE,
    laba_rugi DECIMAL(15,2),
    ditutup_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- SISTEM & UTILITY
-- ============================================

CREATE TABLE tb_auto_number (
    nama VARCHAR(50) PRIMARY KEY,
    prefix VARCHAR(10),
    nomor_terakhir INTEGER,
    panjang INTEGER,
    reset_tahunan BOOLEAN DEFAULT FALSE,
    waktu_ubah TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_log_aktivitas (
    log_id SERIAL PRIMARY KEY,
    pengguna_id INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    nama_modul VARCHAR(50),
    jenis_aktivitas VARCHAR(50),
    nama_tabel VARCHAR(50),
    record_id INTEGER,
    keterangan TEXT,
    ip_address VARCHAR(50),
    info_device TEXT,
    waktu_aktivitas TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_antrian_sync (
    antrian_id SERIAL PRIMARY KEY,
    nama_tabel VARCHAR(50),
    record_id INTEGER,
    operasi VARCHAR(10),
    data_json JSONB,
    status_sync VARCHAR(20),
    jumlah_retry INTEGER DEFAULT 0,
    pesan_error TEXT,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_sync TIMESTAMP
);

CREATE TABLE tb_log_sync (
    log_sync_id SERIAL PRIMARY KEY,
    tgl_sync TIMESTAMP,
    arah VARCHAR(10),
    nama_tabel VARCHAR(50),
    jumlah_record INTEGER,
    status VARCHAR(20),
    pesan_error TEXT,
    durasi_ms INTEGER
);

CREATE TABLE tb_pengaturan (
    pengaturan_id SERIAL PRIMARY KEY,
    kunci_setting VARCHAR(100) UNIQUE NOT NULL,
    nilai_setting TEXT,
    tipe_setting VARCHAR(20),
    keterangan TEXT,
    diubah_oleh INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    waktu_ubah TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_histori_stok (
    histori_id SERIAL PRIMARY KEY,
    obat_id INTEGER REFERENCES tb_obat_mst(obat_id),
    batch_id INTEGER REFERENCES tb_batch_obat(batch_id),
    jenis_transaksi VARCHAR(20),
    modul_transaksi VARCHAR(20),
    id_transaksi INTEGER,
    qty_sebelum INTEGER,
    qty_perubahan INTEGER,
    qty_sesudah INTEGER,
    catatan TEXT,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_notifikasi (
    notifikasi_id SERIAL PRIMARY KEY,
    pengguna_id INTEGER REFERENCES tb_pengguna_mst(pengguna_id),
    jenis_notifikasi VARCHAR(20),
    judul VARCHAR(100),
    pesan TEXT,
    link_modul VARCHAR(50),
    link_id INTEGER,
    is_dibaca BOOLEAN DEFAULT FALSE,
    waktu_buat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_baca TIMESTAMP
);

-- ============================================
-- INDEXES untuk Performance
-- ============================================

-- Indexes untuk Foreign Keys
CREATE INDEX idx_obat_kategori ON tb_obat_mst(kategori_id);
CREATE INDEX idx_obat_supplier ON tb_obat_mst(supplier_id);
CREATE INDEX idx_stok_obat ON tb_stok_cabang(obat_id);
CREATE INDEX idx_stok_cabang ON tb_stok_cabang(cabang_id);
CREATE INDEX idx_batch_obat ON tb_batch_obat(obat_id);
CREATE INDEX idx_pembelian_supplier ON tb_pembelian_trx(supplier_id);
CREATE INDEX idx_penjualan_cabang ON tb_penjualan_trx(cabang_id);
CREATE INDEX idx_jurnal_akun ON tb_jurnal_dtl(akun_id);

-- Indexes untuk Pencarian
CREATE INDEX idx_obat_nama ON tb_obat_mst(nama_obat);
CREATE INDEX idx_obat_barcode ON tb_obat_mst(barcode);
CREATE INDEX idx_penjualan_tanggal ON tb_penjualan_trx(tgl_transaksi);
CREATE INDEX idx_pembelian_tanggal ON tb_pembelian_trx(tgl_pembelian);
CREATE INDEX idx_batch_expired ON tb_batch_obat(tgl_expired);

-- Indexes untuk Status
CREATE INDEX idx_pembelian_status ON tb_pembelian_trx(status);
CREATE INDEX idx_pengiriman_status ON tb_pengiriman_trx(status);
CREATE INDEX idx_penjualan_retur ON tb_penjualan_trx(is_retur);
