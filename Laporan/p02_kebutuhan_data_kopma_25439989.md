# Dokumen Kebutuhan Data - Koperasi Mahasiswa (Kopma) Sejahtera

---

## 1. Latar Belakang dan Aktivitas Organisasi

**Koperasi Mahasiswa (Kopma) Sejahtera** adalah unit usaha di lingkungan kampus yang menyediakan berbagai kebutuhan harian mahasiswa seperti alat tulis, makanan ringan, dan minuman. Berdasarkan data mahasiswa atas nama Ria Rahmadani (NIM: **25430089**), sistem ini dirancang untuk mengatasi berbagai kendala operasional harian yang selama ini dikeluhkan oleh pengurus, seperti harga pada nota lama yang tidak bisa dicek kembali, stok di buku catatan yang kadang bernilai minus, serta anggota yang sering lupa membawa kartu fisik saat berbelanja.

### Aktivitas Utama Organisasi:
* **Pendaftaran Anggota:** Mahasiswa mendaftarkan diri dengan menyerahkan NIM, nama, program studi, dan nomor HP untuk memperoleh nomor anggota berformat khusus.
* **Transaksi Penjualan:** Kasir melayani pembeli (anggota atau umum), mencatat rincian barang, menghitung diskon anggota aktif, dan mencetak nota.
* **Pengelolaan Inventaris & Gudang:** Petugas gudang memeriksa stok secara berkala, membuat pesanan pembelian ke pemasok jika stok di bawah batas minimum, serta menerima barang datang beserta faktur.
* **Pelaporan Berkala:** Ketua koperasi menerima rekapitulasi laporan omzet, barang terlaris, stok menipis, dan keaktifan anggota setiap awal bulan.

---

## 2. Aktor dan Proses Bisnis

| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| **PB-01** | Mendaftarkan Anggota | Kasir / Admin | Mahasiswa ingin mendaftar sebagai anggota baru |
| **PB-02** | Mencatat Penjualan | Kasir | Pembeli melakukan pembayaran di kasir |
| **PB-03** | Memesan Barang ke Pemasok | Petugas Gudang | Stok barang di bawah batas minimum |
| **PB-04** | Menerima Barang dari Pemasok | Petugas Gudang | Barang pesanan datang bersama faktur pemasok |
| **PB-05** | Menyusun Laporan Bulanan | Ketua / Pengurus | Memasuki awal bulan periode pelaporan |

---

## 3. Dokumen Sumber yang Dianalisis

1. **Formulir Pendaftaran Anggota:** Memuat NIM, Nama, Program Studi, dan Nomor HP.
2. **Nota Penjualan Kopma:** Memuat Nomor Nota, Tanggal & Jam, Kasir, Kode/Nama Barang, Qty, Harga Satuan saat Transaksi, dan Total Bayar.
3. **Faktur Pembelian Pemasok:** Memuat Nomor Faktur, Tanggal, Identitas Pemasok, Rincian Barang, Qty, dan Harga Beli.

---

## 4. Entitas Kandidat dan Elemen Data

| Entitas Kandidat | Elemen Data Utama | Sumber |
| :--- | :--- | :--- |
| **Anggota** | `no_anggota`, `nim`, `nama`, `program_studi`, `no_hp`, `status_aktif` | Formulir Pendaftaran |
| **Barang** | `kode_barang`, `nama_barang`, `kategori`, `harga_jual`, `stok`, `batas_minimum` | Daftar Barang / Katalog |
| **Penjualan** | `no_nota`, `tanggal_jam`, `id_kasir`, `no_anggota` (opsional), `total_bayar` | Nota Penjualan |
| **Detail Penjualan** | `no_nota`, `kode_barang`, `qty`, `harga_satuan_transaksi`, `subtotal` | Nota Penjualan |
| **Pemasok** | `kode_pemasok`, `nama_pemasok`, `telepon`, `alamat` | Faktur Pemasok |
| **Pembelian** | `no_faktur`, `tanggal_pesan`, `kode_pemasok`, `id_petugas` | Faktur Pemasok |
| **Detail Pembelian** | `no_faktur`, `kode_barang`, `qty_beli`, `harga_beli` | Faktur Pemasok |

---

## 5. Aturan Bisnis

* **AB-01:** Setiap nota transaksi penjualan memiliki nomor unik (`no_nota`) dan mencakup minimal satu baris barang. Batas maksimal item per transaksi berdasarkan parameter proyek ($P=9$) adalah **11 item barang**.
* **AB-02:** Penjualan dapat dilayani untuk pembeli umum; jika menggunakan identitas anggota, status anggota harus aktif untuk memperoleh diskon khusus sebesar 5%.
* **AB-03:** Stok fisik barang di gudang tidak boleh bernilai negatif; sistem wajib menolak transaksi penjualan jika `qty` yang diminta melebihi stok yang tersedia.
* **AB-04:** Harga jual barang pada nota wajib disimpan per baris transaksi (`harga_satuan_transaksi`) agar tidak berubah meskipun harga dasar barang di katalog mengalami kenaikan di kemudian hari.
* **AB-05:** Nomor Induk Mahasiswa (`nim`) bersifat unik (mengacu pada NIM **25430089**), dan pencarian data anggota dapat dilakukan melalui nomor anggota atau NIM.
* **AB-06:** Pesanan pembelian otomatis dibuat oleh petugas gudang jika stok barang berada di bawah batas minimum.
* **AB-07:** Setiap kelipatan belanja Rp10.000 bernilai 1 poin loyalitas anggota, dan 50 poin dapat ditukar dengan potongan harga senilai Rp5.000.

---

## 6. Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| **KI-01** | Omzet dan jumlah nota per hari dan per bulan | Penjualan, Detail Penjualan |
| **KI-02** | Daftar lima barang terlaris per bulan berdasarkan `qty` | Detail Penjualan, Barang |
| **KI-03** | Daftar barang dengan stok di bawah batas minimum | Barang |
| **KI-04** | Sepuluh anggota dengan total belanja terbesar per bulan | Penjualan, Detail Penjualan, Anggota |

---

## 7. Matriks CRUD

| Proses Bisnis | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian | Detail Pembelian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** (Daftar Anggota) | C, U | - | - | - | - | - | - |
| **PB-02** (Catat Penjualan) | R | R, U | C | C | - | - | - |
| **PB-03** (Pesan ke Pemasok) | - | R | - | - | R | C | C |
| **PB-04** (Terima Barang) | - | U | - | - | R | U | R |
| **PB-05** (Laporan Bulanan) | R | R | R | R | R | R | R |

---

## 8. Kamus Data Awal

| Elemen Data | Arti / Deskripsi | Contoh Nilai | Aturan / Format | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `no_anggota` | Nomor identitas anggota koperasi | A-0899 | Unik, format A-4 digit | Ketua |
| `nim` | Nomor Induk Mahasiswa | 25430089 | Unik, 8 digit | Ketua |
| `no_hp` | Nomor telepon seluler anggota | 081234567890 | Data pribadi, akses terbatas | Ketua |
| `no_nota` | Nomor unik dokumen nota transaksi | PJ-2610-0142 | Unik per nota | Kasir |
| `harga_satuan_transaksi` | Harga jual produk saat transaksi terjadi | 4000 | Bilangan bulat $\ge 0$ (Rupiah) | Kasir |
| `stok_barang` | Jumlah ketersediaan fisik barang di gudang | 35 | Bilangan bulat $\ge 0$ (Sesuai AB-03) | Petugas Gudang |
| `kode_pemasok` | Kode unik pemasok barang Kopma | PMS-01 | Unik, alfanumerik | Petugas Gudang |

---

## 9. Kebutuhan Non-Fungsional Data & Parameter Proyek

* **Parameter Proyek ($P$):** 
  * Berdasarkan NIM `25430089`, 2 digit terakhir adalah `89`.
  * Perhitungan: $P = (89 \pmod 9) + 1 = 8 + 1 = \mathbf{9}$.
  * **Batas maksimal item per transaksi:** $9 + 2 = \mathbf{11 \text{ item}}$.
  * **Persentase diskon / denda harian ($P$):** $\mathbf{9\%}$ (atau Rp9.000).
  * **Perkiraan volume transaksi harian:** $40 + (5 \times 9) = \mathbf{85 \text{ transaksi/hari}}$.
* **Retensi Data:** Seluruh data transaksi penjualan, nota, dan arsip laporan keuangan wajib disimpan sekurang-kurangnya selama **5 tahun**.
* **Privasi & Keamanan Data (PDP):** Data pribadi anggota seperti nomor HP diklasifikasikan sebagai data rahasia sesuai UU Pelindungan Data Pribadi. Akses hanya diberikan secara eksklusif kepada **Ketua** koperasi.

---

## 10. Isu Kualitas Data yang Diantisipasi

1. **Inkonsistensi Data Penjualan & Harga Lama:** Diatasi dengan merekam atribut `harga_satuan_transaksi` secara terpisah pada tabel *Detail Penjualan* (sesuai aturan **AB-04**).
2. **Stok Minus di Buku Catatan:** Dicegah dengan validasi otomatis pada sistem pencatatan transaksi yang menolak penjualan jika `qty` melebihi `stok_barang` (**AB-03**).
3. **Kartu Anggota Hilang / Lupa Dibawa:** Diantisipasi dengan menyediakan fitur pencarian anggota langsung melalui nomor induk mahasiswa (`nim`).

---

## E. Perbaikan Pernyataan Kebutuhan Kabur

1. **Sebelum:** *"Data anggota harus aman."*  
   * **Sesudah (Dapat Diuji):** *"Nomor HP dan data pribadi anggota wajib dienkripsi saat disimpan di basis data, dan hak akses peninjauannya dibatasi khusus untuk peran Ketua menggunakan kontrol otorisasi berbasis peran (RBAC)."*
2. **Sebelum:** *"Sistem harus cepat mencari barang."*  
   * **Sesudah (Dapat Diuji):** *"Pencarian data barang berdasarkan `kode_barang` atau `nama_barang` pada katalog kasir wajib menghasilkan respons data dalam waktu kurang dari 0,5 detik untuk 1.000 data barang aktif."*
3. **Sebelum:** *"Laporan stok harus akurat."*  
   * **Sesudah (Dapat Diuji):** *"Selisih antara jumlah stok tercatat pada tabel `Barang` dan stok fisik hasil opname gudang setiap akhir bulan harus bernilai 0 (nol) atau disertai catatan investigasi yang divalidasi oleh petugas gudang."*