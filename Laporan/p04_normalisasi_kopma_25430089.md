# Dokumen Normalisasi Basis Data - Kasus Kopma Sejahtera

**Nama:** Ria Rahmadani  
**NIM:** 25430089

---

## 1. Identifikasi Anomali Data pada Spreadsheet / Dokumen Sumber Unnormalized (UNF)

Pada dokumen sumber transaksi Penjualan dan Pembelian yang belum dinormalisasi, ditemukan 3 jenis anomali data:

1. **Anomali Sisip (Insert Anomaly):**
   * Kita tidak dapat menambahkan data Anggota baru ke dalam sistem sebelum anggota tersebut melakukan transaksi penjualan pertama (jika data anggota digabung dalam 1 tabel transaksi).
   * Kita tidak dapat menginputkan data Pemasok baru jika belum ada transaksi pembelian/faktur darinya.

2. **Anomali Ubah (Update Anomaly):**
   * Jika nama anggota atau nama barang berubah (misal: "Indomie Goreng" menjadi "Indomie Goreng Aceh"), maka kita harus mengubah banyak baris transaksi berulang yang memuat barang tersebut. Jika ada satu baris yang terlewat, akan terjadi inkonsistensi data.
   * Jika alamat atau nomor telepon pemasok berubah, seluruh data faktur lama yang memuat pemasok tersebut harus diperbarui satu per satu.

3. **Anomali Hapus (Delete Anomaly):**
   * Jika satu-satunya nota penjualan milik seorang anggota dihapus, maka seluruh data identitas anggota (NIM, Nama, Prodi, No HP) ikut terhapus dari sistem.
   * Jika faktur pembelian dari pemasok tertentu dihapus, data Pemasok tersebut bisa hilang total dari sistem.

---

## 2. Unnormalized Form (UNF)

Bentuk **UNF** merepresentasikan data transaksi sebagaimana tercatat pada dokumen fisik (Nota Penjualan dan Faktur Pembelian) yang masih memuat grup berulang (*repeating groups*):

### A. Dokumen Nota Penjualan (UNF)
`Nota_Penjualan` (`no_nota`, `tanggal_jam`, `id_kasir`, `no_anggota`, `nim`, `nama_anggota`, `program_studi`, `no_hp`, `status_aktif`, {`kode_barang`, `nama_barang`, `kategori`, `harga_jual_katalog`, `qty`, `harga_satuan_transaksi`, `subtotal`}, `total_bayar`)

### B. Dokumen Faktur Pembelian (UNF)
`Faktur_Pembelian` (`no_faktur`, `tanggal_pesan`, `id_petugas`, `kode_pemasok`, `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`, {`kode_barang`, `nama_barang`, `kategori`, `qty_beli`, `harga_beli`})

---

## 3. First Normal Form (1NF)

Pada tahap **1NF**, kita menghilangkan grup berulang (*repeating groups*) sehingga setiap sel memiliki nilai tunggal/atomik, dan menentukan *Composite Primary Key* untuk entitas transaksi detail.

### A. Transaksi Penjualan (1NF)
`PENJUALAN_1NF` (<ins>`no_nota`</ins>, <ins>`kode_barang`</ins>, `tanggal_jam`, `id_kasir`, `no_anggota`, `nim`, `nama_anggota`, `program_studi`, `no_hp`, `status_aktif`, `nama_barang`, `kategori`, `harga_jual_katalog`, `qty`, `harga_satuan_transaksi`, `subtotal`, `total_bayar`)

* **Primary Key:** (`no_nota`, `kode_barang`)

### B. Transaksi Pembelian (1NF)
`PEMBELIAN_1NF` (<ins>`no_faktur`</ins>, <ins>`kode_barang`</ins>, `tanggal_pesan`, `id_petugas`, `kode_pemasok`, `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`, `nama_barang`, `kategori`, `qty_beli`, `harga_beli`)

* **Primary Key:** (`no_faktur`, `kode_barang`)

---

## 4. Daftar Dependensi Fungsional (Functional Dependency / FD)

Berdasarkan Aturan Bisnis (**AB-01** s.d. **AB-07**), disusun dependensi fungsional sebagai berikut:

* **FD-01 (Aturan Bisnis AB-05):** `no_anggota` -> `nim`, `nama_anggota`, `program_studi`, `no_hp`, `status_aktif`
* **FD-02 (Aturan Bisnis AB-05):** `nim` -> `no_anggota`, `nama_anggota`, `program_studi`, `no_hp`, `status_aktif`
* **FD-03 (Katalog Barang):** `kode_barang` -> `nama_barang`, `kategori`, `harga_jual_katalog`, `stok`, `batas_minimum`
* **FD-04 (Dokumen Nota / AB-01, AB-02):** `no_nota` -> `tanggal_jam`, `id_kasir`, `no_anggota`
* **FD-05 (Aturan Bisnis AB-04):** `no_nota`, `kode_barang` -> `qty`, `harga_satuan_transaksi`
* **FD-06 (Vendor/Pemasok):** `kode_pemasok` -> `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`
* **FD-07 (Dokumen Pembelian / AB-06):** `no_faktur` -> `tanggal_pesan`, `id_petugas`, `kode_pemasok`
* **FD-08 (Detail Pembelian):** `no_faktur`, `kode_barang` -> `qty_beli`, `harga_beli`

---

## 5. Second Normal Form (2NF)

Tahap **2NF** bertujuan memisahkan Ketergantungan Parsial (*Partial Dependency*), di mana atribut non-kunci yang hanya bergantung pada sebagian dari *Composite Primary Key* dipisahkan ke dalam tabel tersendiri.

### Pemisahan dari Transaksi Penjualan:
* **Tabel Penjualan (Header):**  
  `PENJUALAN` (<ins>`no_nota`</ins>, `tanggal_jam`, `id_kasir`, `no_anggota`, `nim`, `nama_anggota`, `program_studi`, `no_hp`, `status_aktif`, `total_bayar`)
* **Tabel Barang:**  
  `BARANG` (<ins>`kode_barang`</ins>, `nama_barang`, `kategori`, `harga_jual_katalog`, `stok`, `batas_minimum`)
* **Tabel Detail Penjualan:**  
  `DETAIL_PENJUALAN` (<ins>`no_nota`</ins>, <ins>`kode_barang`</ins>, `qty`, `harga_satuan_transaksi`, `subtotal`)

### Pemisahan dari Transaksi Pembelian:
* **Tabel Pembelian (Header):**  
  `PEMBELIAN` (<ins>`no_faktur`</ins>, `tanggal_pesan`, `id_petugas`, `kode_pemasok`, `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`)
* **Tabel Detail Pembelian:**  
  `DETAIL_PEMBELIAN` (<ins>`no_faktur`</ins>, <ins>`kode_barang`</ins>, `qty_beli`, `harga_beli`)

---

## 6. Third Normal Form (3NF)

Tahap **3NF** bertujuan memisahkan Ketergantungan Transitif (*Transitive Dependency*), di mana atribut non-kunci bergantung pada atribut non-kunci lainnya.

1. **Tabel ANGGOTA (dari PENJUALAN):**  
   Atribut `nim`, `nama_anggota`, `program_studi`, `no_hp`, dan `status_aktif` bergantung pada `no_anggota` (bukan langsung pada `no_nota`).  
   -> `ANGGOTA` (<ins>`no_anggota`</ins>, `nim`, `nama_anggota`, `program_studi`, `no_hp`, `status_aktif`)

2. **Tabel PEMASOK (dari PEMBELIAN):**  
   Atribut `nama_pemasok`, `telepon_pemasok`, dan `alamat_pemasok` bergantung pada `kode_pemasok` (bukan langsung pada `no_faktur`).  
   -> `PEMASOK` (<ins>`kode_pemasok`</ins>, `nama_pemasok`, `telepon`, `alamat`)

3. **Penghapusan Atribut Turunan/Kalkulasi:**  
   Atribut `subtotal` dan `total_bayar` dihilangkan dari skema fisik tabel sesuai kaidah normalisasi murni, karena nilainya dapat dihitung sewaktu-waktu melalui *query* SQL (`qty * harga_satuan_transaksi` dan `SUM(subtotal)`).

### Hasil Skema Relasional 3NF Kanonik:

1. **`ANGGOTA`** (<ins>`no_anggota`</ins>, `nim`, `nama`, `program_studi`, `no_hp`, `status_aktif`)
2. **`BARANG`** (<ins>`kode_barang`</ins>, `nama_barang`, `kategori`, `harga_jual`, `stok`, `batas_minimum`)
3. **`PENJUALAN`** (<ins>`no_nota`</ins>, `tanggal_jam`, `id_kasir`, <ins>`no_anggota`</ins>*)
4. **`DETAIL_PENJUALAN`** (<ins>`no_nota`*</ins>, <ins>`kode_barang`*</ins>, `qty`, `harga_satuan_transaksi`)
5. **`PEMASOK`** (<ins>`kode_pemasok`</ins>, `nama_pemasok`, `telepon`, `alamat`)
6. **`PEMBELIAN`** (<ins>`no_faktur`</ins>, `tanggal_pesan`, `id_petugas`, <ins>`kode_pemasok`</ins>*)
7. **`DETAIL_PEMBELIAN`** (<ins>`no_faktur`*</ins>, <ins>`kode_barang`*</ins>, `qty_beli`, `harga_beli`)

*(Keterangan: `<ins>Kunci</ins>` = Primary Key, `*` = Foreign Key)*

---

## 7. Analisis BCNF (Boyce-Codd Normal Form)

Setiap ketergantungan fungsional X -> Y yang berlaku pada seluruh tabel di atas memenuhi syarat **BCNF**, karena determinan X merupakan **Super Key** / **Candidate Key**:

* Pada tabel `ANGGOTA`: `no_anggota` adalah *Primary Key* dan `nim` adalah *Candidate Key* unik (**FD-01** & **FD-02**). Keduanya merupakan *superkey*.
* Pada tabel `BARANG`: `kode_barang` adalah *Primary Key* (**FD-03**).
* Pada tabel `PENJUALAN`: `no_nota` adalah *Primary Key* (**FD-04**).
* Pada tabel `DETAIL_PENJUALAN`: (`no_nota`, `kode_barang`) adalah *Composite Primary Key* (**FD-05**).
* Pada tabel `PEMASOK`: `kode_pemasok` adalah *Primary Key* (**FD-06**).
* Pada tabel `PEMBELIAN`: `no_faktur` adalah *Primary Key* (**FD-07**).
* Pada tabel `DETAIL_PEMBELIAN`: (`no_faktur`, `kode_barang`) adalah *Composite Primary Key* (**FD-08**).

**Kesimpulan BCNF:** Skema relasional Kopma Sejahtera telah memenuhi BCNF dan terbebas dari anomali redundansi.

---

## 8. Jawaban Titik Analisis

### **Titik Analisis 1: Perbedaan `harga_jual` di Katalog dan `harga_satuan_transaksi` di Nota**
* **Mengapa `harga_satuan_transaksi` harus disimpan per baris transaksi di `DETAIL_PENJUALAN`?**  
  Karena harga produk di tabel `BARANG` bersifat dinamis dan dapat berubah sewaktu-waktu akibat inflasi atau penyesuaian harga pasar. Jika `DETAIL_PENJUALAN` hanya mengambil harga dari tabel `BARANG` secara *live*, maka nilai histori transaksi lama pada nota akan berubah ikut naik/turun. Sesuai **AB-04**, `harga_satuan_transaksi` direkam sebagai bukti transaksi historis yang *immutable* (tidak boleh berubah).

### **Titik Analisis 2: Alasan Nilai Turunan (`subtotal` dan `total_bayar`) Tidak Disimpan**
* **Mengapa nilai `subtotal` dan `total_bayar` dihilangkan dari tabel fisik?**  
  Nilai `subtotal` (`qty` x `harga_satuan_transaksi`) dan `total_bayar` (sum subtotal) merupakan atribut derivatif (turunan). Menyimpan atribut turunan di dalam basis data berisiko menimbulkan inkonsistensi data jika nilai `qty` atau `harga` diubah tanpa memperbarui `subtotal`. Nilai ini dapat dengan mudah dihitung secara cepat saat pembuatan laporan menggunakan ekspresi kalkulasi atau *VIEW* pada SQL.

### **Titik Analisis 3: Penyimpanan Informasi Pemasok**
* **Mengapa data pemasok dipisahkan ke dalam tabel `PEMASOK` tersendiri?**  
  Jika informasi pemasok (nama, telepon, alamat) disimpan langsung di tabel `PEMBELIAN`, akan terjadi redundansi data setiap kali Kopma melakukan pemesanan ulang ke pemasok yang sama. Selain itu, memisahkan ke tabel `PEMASOK` mencegah **Anomali Sisip** (bisa mencatat pemasok baru sebelum ada pembelian) dan **Anomali Hapus** (data pemasok tidak hilang jika riwayat pembelian dihapus).