CREATE DATABASE IF NOT EXISTS kopma_089;
USE kopma_089;

-- 1. Tabel PEMASOK
CREATE TABLE pemasok (
    id_pemasok INT AUTO_INCREMENT PRIMARY KEY,
    nama_pemasok VARCHAR(100) NOT NULL,
    telepon_pemasok VARCHAR(20) NULL,
    alamat_pemasok VARCHAR(255) NULL
) ENGINE=InnoDB;

-- 2. Tabel ANGGOTA
CREATE TABLE anggota (
    id_anggota INT AUTO_INCREMENT PRIMARY KEY,
    no_anggota CHAR(15) UNIQUE,
    nim_anggota CHAR(20) UNIQUE,
    nama_anggota VARCHAR(100) NOT NULL,
    prodi_anggota VARCHAR(100) NOT NULL,
    no_hp_anggota VARCHAR(20) NULL,
    status_anggota ENUM('aktif','nonaktif')
        NOT NULL DEFAULT 'aktif',
    tgl_daftar_anggota DATE NOT NULL
) ENGINE=InnoDB;

-- 3. Tabel PETUGAS
CREATE TABLE petugas (
    id_petugas SMALLINT AUTO_INCREMENT PRIMARY KEY,
    kode_petugas CHAR(10) UNIQUE,
    nama_petugas VARCHAR(100) NOT NULL,
    peran_petugas ENUM('kasir','gudang','ketua')
        NOT NULL
) ENGINE=InnoDB;

-- 4. Tabel BARANG
CREATE TABLE barang (
    id_barang INT AUTO_INCREMENT PRIMARY KEY,
    kode_barang VARCHAR(20) UNIQUE,
    nama_barang VARCHAR(100) NOT NULL,
    kategori_barang ENUM('ATK','makanan','minuman')
        NOT NULL,
    harga_jual_barang DECIMAL(12,2)
        CHECK (harga_jual_barang >= 0),
    stok_barang INT
        CHECK (stok_barang >= 0),
    stok_min_barang INT DEFAULT 5
) ENGINE=InnoDB;

-- 5. Tabel PEMBELIAN
CREATE TABLE pembelian (
    id_pembelian INT AUTO_INCREMENT PRIMARY KEY,
    no_faktur_pembelian VARCHAR(30) NOT NULL,
    tgl_pembelian DATE NOT NULL,
    id_pemasok INT NOT NULL,
    status_pembelian ENUM('dipesan','diterima')
        NOT NULL,
    FOREIGN KEY (id_pemasok)
        REFERENCES pemasok(id_pemasok)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 6. Tabel PENJUALAN
CREATE TABLE penjualan (
    id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
    no_nota_penjualan VARCHAR(30) UNIQUE,
    tgl_penjualan DATETIME NOT NULL,
    id_petugas SMALLINT NOT NULL,
    id_anggota INT NULL,
    bayar_penjualan DECIMAL(12,2) NOT NULL
        CHECK (bayar_penjualan >= 0),
    FOREIGN KEY (id_petugas)
        REFERENCES petugas(id_petugas)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_anggota)
        REFERENCES anggota(id_anggota)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- 7. Tabel DETAIL_PEMBELIAN
CREATE TABLE detail_pembelian (
    id_pembelian INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_pembelian INT
        CHECK (qty_detail_pembelian > 0),
    harga_beli_detail_pembelian DECIMAL(12,2)
        NOT NULL CHECK (harga_beli_detail_pembelian >= 0),

    PRIMARY KEY (id_pembelian, id_barang),

    FOREIGN KEY (id_pembelian)
        REFERENCES pembelian(id_pembelian)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_barang)
        REFERENCES barang(id_barang)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 8. Tabel DETAIL_PENJUALAN
CREATE TABLE detail_penjualan (
    id_penjualan INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_penjualan SMALLINT
        CHECK (qty_detail_penjualan > 0),
    harga_satuan_detail_penjualan DECIMAL(12,2)
        NOT NULL CHECK (harga_satuan_detail_penjualan >= 0),

    PRIMARY KEY (id_penjualan, id_barang),

    FOREIGN KEY (id_penjualan)
        REFERENCES penjualan(id_penjualan)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_barang)
        REFERENCES barang(id_barang)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;