# Dokumen Kebutuhan Data - Academic Center RR

---

## 1. Latar Belakang dan Aktivitas Organisasi

**Academic Center RR** adalah unit layanan akademik di bawah naungan Koperasi Mahasiswa Sejahtera yang berfokus pada penyediaan layanan pengelolaan data mahasiswa, mata kuliah, jadwal perkuliahan, Kartu Rencana Studi (KRS), serta penilaian hasil studi. Berdasarkan identitas mahasiswa **Ria Rahmadani (NIM: 25430089)**, sistem ini dirancang untuk menggantikan proses pencatatan manual yang rentan terhadap kesalahan, tumpang tindih jadwal kelas, inkonsistensi data nilai, serta kesulitan dalam rekapitulasi pelaporan akademik semesteran.

### Aktivitas Utama Organisasi:
* **Pendaftaran Mahasiswa:** Bagian akademik mencatat data diri, program studi, dan status keaktifan mahasiswa baru.
* **Pengisian & Validasi KRS:** Mahasiswa menyusun dan mengajukan rencana studi (KRS) berdasarkan mata kuliah yang ditawarkan pada semester berjalan dengan persetujuan dosen pembimbing akademik.
* **Pengelolaan Kurikulum & Jadwal:** Bagian akademik mengatur penawaran mata kuliah, alokasi ruang kelas, kuota peserta, dan penugasan dosen pengampu.
* **Input & Penilaian Studi:** Dosen pengampu menginput komponen nilai (tugas, UTS, UAS) dan menerbitkan nilai akhir mahasiswa.
* **Pelaporan & Evaluasi Akademik:** Ketua program studi dan pimpinan menerima rekapitulasi Kartu Hasil Studi (KHS), transkrip nilai, serta statistik keaktifan studi setiap akhir semester.

---

## 2. Aktor dan Proses Bisnis

| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| **PB-01** | Mendaftarkan Mahasiswa Baru | Bagian Akademik | Calon mahasiswa melakukan registrasi masuk |
| **PB-02** | Mengajukan dan Memproses KRS | Mahasiswa / Dosen PA | Memasuki jadwal periode pengisian KRS awal semester |
| **PB-03** | Mengelola Mata Kuliah dan Kurikulum | Bagian Akademik | Perencanaan penawaran mata kuliah semester baru |
| **PB-04** | Menyusun Jadwal Perkuliahan dan Ruangan | Bagian Akademik | Kepastian jumlah kelas dan alokasi waktu perkuliahan |
| **PB-05** | Menginput dan Memperbarui Nilai Akademik | Dosen Pengampu | Berakhirnya masa ujian atau penugasan semester |
| **PB-06** | Menerbitkan Rekapitulasi Laporan Akademik | Ketua / Pimpinan | Akhir periode semester atau permintaan evaluasi |

---

## 3. Dokumen Sumber yang Dianalisis

1. **Formulir Pendaftaran Mahasiswa:** Memuat NIM, Nama Lengkap, Program Studi, Angkatan, dan Kontak Pribadi.
2. **Lembar Kartu Rencana Studi (KRS):** Memuat Nomor KRS, NIM, Semester Aktif, Daftar Kode Mata Kuliah yang Diambil, dan Validasi Persetujuan.
3. **Dokumen Penawaran Mata Kuliah & Kuota Kelas:** Memuat Kode Mata Kuliah, Nama MK, SKS, Semester, Kuota Kursi, dan Ruangan.
4. **Berita Acara / Lembar Input Nilai Ujian:** Memuat Kode MK, Kelas, NIM Mahasiswa, Komponen Nilai (Tugas, UTS, UAS), Nilai Akhir, dan Huruf Mutu.

---

## 4. Entitas Kandidat dan Elemen Data

| Entitas Kandidat | Elemen Data Utama | Sumber |
| :--- | :--- | :--- |
| **Mahasiswa** | `nim`, `nama_mahasiswa`, `program_studi`, `angkatan`, `no_hp`, `status_aktif` | Formulir Pendaftaran |
| **Dosen** | `kode_dosen`, `nama_dosen`, `email`, `prodi` | Data Kepegawaian |
| **Mata Kuliah** | `kode_mk`, `nama_mk`, `sks`, `semester_kurikulum` | Katalog Kurikulum |
| **Kelas Perkuliahan** | `id_kelas`, `kode_mk`, `kode_dosen`, `ruangan`, `kapasitas` | Penawaran Mata Kuliah |
| **KRS (Header)** | `id_krs`, `nim`, `semester_aktif`, `tanggal_pengajuan`, `status_persetujuan` | Lembar KRS |
| **Detail KRS** | `id_krs`, `id_kelas` | Lembar KRS |
| **Penilaian** | `id_nilai`, `nim`, `id_kelas`, `nilai_tugas`, `nilai_uts`, `nilai_uas`, `nilai_akhir`, `grade` | Berita Acara Ujian |

---

## 5. Aturan Bisnis

* **AB-01:** Setiap lembar KRS memiliki nomor unik (`id_krs`) dan memuat minimal satu mata kuliah, dengan batas maksimal item SKS per transaksi KRS mengikuti parameter proyek sebesar **11 SKS/mata kuliah**.
* **AB-02:** Mahasiswa hanya dapat memprogramkan mata kuliah jika status mahasiswa aktif dan telah memenuhi prasyarat akademik mata kuliah sebelumnya.
* **AB-03:** Kapasitas kelas perkuliahan tidak boleh melebihi batas kuota ruangan; sistem wajib menolak penambahan detail KRS jika kapasitas kelas sudah penuh.
* **AB-04:** Nilai akhir mahasiswa dihitung secara transparan berdasarkan bobot komponen yang disimpan per entitas `Penilaian` dan dikunci setelah masa sanggah nilai berakhir.
* **AB-05:** Nomor Induk Mahasiswa (`nim`) bersifat unik (berdasarkan identitas **25430089**), dan pencarian data akademik dapat dilakukan melalui NIM atau nama mahasiswa.
* **AB-06:** Pembukaan kelas perkuliahan baru (`PB-03`) wajib divalidasi oleh Bagian Akademik berdasarkan ketersediaan dosen pengampu dan kapasitas ruang.
* **AB-07:** Setiap perubahan status aktif mahasiswa (cuti/aktif/lulus) wajib dicatat dengan riwayat waktu perubahan untuk keperluan audit akademik.
* **AB-08:** Mahasiswa dengan IP Semester di bawah 2.00 pada periode sebelumnya dibatasi maksimal pengambilan SKS-nya sesuai ketentuan akademik yang berlaku.

---

## 6. Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| **KI-01** | Rekapitulasi jumlah mahasiswa aktif dan total KRS per program studi per semester | Mahasiswa, KRS, Detail KRS |
| **KI-02** | Daftar lima mata kuliah dengan jumlah peminat terbanyak pada semester berjalan | Mata Kuliah, Kelas, Detail KRS |
| **KI-03** | Laporan Kartu Hasil Studi (KHS) dan Indeks Prestasi Semester (IPS) per mahasiswa | Mahasiswa, Penilaian, Mata Kuliah |
| **KI-04** | Daftar kelas perkuliahan yang mengalami kelebihan kuota atau belum memenuhi batas minimum peserta | Kelas, Detail KRS, Mata Kuliah |
| **KI-05** | Transkrip nilai kumulatif mahasiswa lengkap dengan Indeks Prestasi Kumulatif (IPK) | Mahasiswa, Penilaian, Mata Kuliah |

---

## 7. Matriks CRUD

| Proses Bisnis | Mahasiswa | Dosen | Mata Kuliah | Kelas | KRS | Detail KRS | Penilaian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** (Daftar Mahasiswa) | C, U | - | - | - | - | - | - |
| **PB-02** (Proses KRS) | R | R | R | R | C, U | C, U | - |
| **PB-03** (Kelola Kurikulum) | - | R | C, U | R | - | - | - |
| **PB-04** (Susun Jadwal) | - | R | R | C, U | - | - | - |
| **PB-05** (Input Nilai) | R | R | R | R | - | - | C, U |
| **PB-06** (Laporan Akademik) | R | R | R | R | R | R | R |

---

## 8. Kamus Data Awal

| No | Elemen Data | Arti / Deskripsi | Contoh Nilai | Aturan / Format | Penanggung Jawab |
| :---: | :--- | :--- | :--- | :--- | :--- |
| 1 | `nim` | Nomor Induk Mahasiswa | 25430089 | Unik, 8 digit numerik | Bagian Akademik |
| 2 | `nama_mahasiswa` | Nama lengkap mahasiswa | Ria Rahmadani | Huruf dan spasi, maks 100 karakter | Bagian Akademik |
| 3 | `program_studi` | Nama program studi mahasiswa | Sistem Informasi | Teks standar prodi | Bagian Akademik |
| 4 | `angkatan` | Tahun masuk angkatan mahasiswa | 2025 | Bilangan 4 digit tahun | Bagian Akademik |
| 5 | `no_hp` | Nomor kontak telepon seluler | 081234567890 | Data pribadi, akses terbatas | Bagian Akademik |
| 6 | `status_aktif` | Status keaktifan studi mahasiswa | Aktif | Pilihan: Aktif, Cuti, Keluar | Bagian Akademik |
| 7 | `kode_dosen` | Nomor identitas unik dosen | DSN-012 | Unik, alfanumerik | Bagian Kepegawaian |
| 8 | `nama_dosen` | Nama lengkap beserta gelar dosen | Dr. Budi Santoso, M.Kom. | Teks dengan gelar | Bagian Kepegawaian |
| 9 | `email` | Surat elektronik resmi civitas | budi@academic.ac.id | Format email valid | Bagian Kepegawaian |
| 10 | `kode_mk` | Kode unik mata kuliah kurikulum | IF-301 | Unik, alfanumerik | Bagian Kurikulum |
| 11 | `nama_mk` | Nama resmi mata kuliah | Basis Data Lanjut | Teks nama MK | Bagian Kurikulum |
| 12 | `sks` | Bobot satuan kredit semester | 3 | Bilangan bulat 1 - 6 | Bagian Kurikulum |
| 13 | `semester_kurikulum`| Penempatan semester mata kuliah | 3 | Bilangan bulat 1 - 8 | Bagian Kurikulum |
| 14 | `id_kelas` | Nomor identitas kelas paralel | KLS-IF301-A | Unik alfanumerik | Bagian Akademik |
| 15 | `ruangan` | Lokasi ruangan ruang perkuliahan | Lab Komputer 2 | Teks lokasi ruangan | Bagian Sarpras |
| 16 | `kapasitas` | Batas maksimal kuota peserta kelas | 40 | Bilangan bulat $\ge 0$ | Bagian Akademik |
| 17 | `id_krs` | Nomor unik dokumen KRS mahasiswa | KRS-20261-089 | Unik per semester | Mahasiswa |
| 18 | `semester_aktif` | Periode semester berjalan KRS | 20261 | Format tahun+semester | Mahasiswa |
| 19 | `tanggal_pengajuan` | Tanggal pengisian/pengajuan KRS | 2026-02-10 | Format YYYY-MM-DD | Mahasiswa |
| 20 | `status_persetujuan` | Status validasi KRS oleh Dosen PA | Disetujui | Pilihan: Pending, Disetujui, Ditolak | Dosen PA |
| 21 | `id_nilai` | Nomor unik rekaman penilaian | NIL-20261-001 | Unik per transaksi nilai | Dosen Pengampu |
| 22 | `nilai_tugas` | Nilai akumulasi penugasan terstruktur | 85.00 | Desimal 0.00 - 100.00 | Dosen Pengampu |
| 23 | `nilai_uts` | Nilai Ujian Tengah Semester | 80.00 | Desimal 0.00 - 100.00 | Dosen Pengampu |
| 24 | `nilai_uas` | Nilai Ujian Akhir Semester | 90.00 | Desimal 0.00 - 100.00 | Dosen Pengampu |
| 25 | `nilai_akhir` | Nilai akhir hasil kalkulasi bobot | 85.50 | Desimal 0.00 - 100.00 | Dosen Pengampu |
| 26 | `grade` | Huruf mutu nilai akhir konversi | A | Pilihan: A, AB, B, BC, C, D, E | Dosen Pengampu |

---

## 9. Kebutuhan Non-Fungsional Data & Parameter Proyek

* **Parameter Proyek ($P$):** 
  * Berdasarkan NIM `25430089`, 2 digit terakhir adalah **`89`**.
  * Rumus: $P = (89 \pmod 9) + 1 = 8 + 1 = \mathbf{9}$.
  * **Batas maksimal item / SKS per transaksi KRS:** $9 + 2 = \mathbf{11 \text{ SKS / mata kuliah}}$.
  * **Persentase denda administratif / penyesuaian telat ($P$):** **$\mathbf{9\%}$** (atau nilai setara Rp9.000 jika relevan).
  * **Perkiraan volume transaksi pengisian KRS harian:** $40 + (5 \times 9) = \mathbf{85 \text{ transaksi/hari}}$.
* **Retensi Data:** Seluruh dokumen rekam jejak KRS, transkrip nilai, dan riwayat studi mahasiswa wajib diarsipkan secara permanen sekurang-kurangnya selama **5 tahun** atau hingga masa studi mahasiswa dinyatakan selesai.
* **Privasi & Keamanan Data (PDP):** Data pribadi mahasiswa seperti nomor telepon (`no_hp`) dan rekam nilai akademik diklasifikasikan sebagai data rahasia. Akses ubah nilai dan data kontak dibatasi secara ketat menggunakan otorisasi berbasis peran (*Role-Based Access Control* / RBAC) hanya untuk **Bagian Akademik** dan **Dosen Pengampu**.

---

## 10. Isu Kualitas Data yang Diantisipasi

1. **Konflik Jadwal dan Bentrok Waktu Kuliah:** Diatasi melalui aturan validasi sistem pada proses pengisian KRS (`PB-02`) yang secara otomatis mendeteksi kesamaan waktu pada atribut entitas `Kelas Perkuliahan`.
2. **Perubahan Nilai Ilegal Tanpa Audit Jejak:** Dicegah dengan menerapkan tabel riwayat audit pada entitas `Penilaian` di mana setiap perubahan nilai oleh dosen wajib mendapatkan persetujuan tertulis dari Ketua Program Studi.
3. **Inkonsistensi Data Identitas Lintas Semester:** Diantisipasi dengan menjadikan `nim` sebagai *Primary Key* tunggal yang mutlak pada seluruh relasi tabel operasional akademik.

---

## E. Perbaikan Pernyataan Kebutuhan Kabur

1. **Sebelum:** *"Data mahasiswa harus aman."*  
   * **Sesudah (Dapat Diuji):** *"Password akun mahasiswa wajib dienkripsi menggunakan algoritma hashing standar industri (bcrypt), dan hak akses peninjauan data pribadi dibatasi eksklusif hanya untuk peran Bagian Akademik melalui sistem login terautentikasi."*
2. **Sebelum:** *"Sistem harus cepat mencari mata kuliah."*  
   * **Sesudah (Dapat Diuji):** *"Pencarian data mata kuliah berdasarkan `kode_mk` atau `nama_mk` pada katalog KRS wajib menghasilkan respons keluaran data (response time) dalam waktu kurang dari 0,5 detik untuk total 500 data mata kuliah aktif."*
3. **Sebelum:** *"Laporan kapasitas kelas harus akurat."*  
   * **Sesudah (Dapat Diuji):** *"Selisih antara jumlah kuota kursi terpakai pada tabel `Kelas Perkuliahan` dan jumlah riil mahasiswa yang memprogramkan KRS pada akhir periode pengisian harus bernilai 0 (nol)."*