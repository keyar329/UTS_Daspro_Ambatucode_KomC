# Survival Quest: Terramok

Proyek UTS Dasar Pemrograman (DP 6), Semester Ganjil T.A. 2026/2027
Program Studi Ilmu Komputer, Fakultas Ilmu Komputer dan Teknologi Informasi, Universitas Sumatera Utara

## Deskripsi Singkat

Survival Quest: Terramok adalah permainan petualangan berbasis teks yang dibuat menggunakan bahasa pemrograman Pascal. Pemain memilih satu dari empat class karakter, kemudian menghadapi tiga gelombang musuh dan seorang boss dengan cara menyerang, menggunakan potion, atau melarikan diri. Program ini dibuat untuk mengintegrasikan materi praktikum berupa input-output, percabangan, perulangan, serta kontrol perulangan (`break` dan `continue`).

## Anggota Kelompok (KOM C)

| No | Nama | NIM | KOM | Lab |
|----|------|-----|-----|-----|
| 1 | Ferdin Giant Tambun | 261401135 | C | 6 |
| 2 | John Arnold Lumbantobing | 261401044 | C | 5 |
| 3 | Kevin Yarden Tarigan | 261401088 | C | 6 |

## Struktur Repositori

| Berkas | Keterangan |
|--------|------------|
| `GamePetualangan.pas` | Source code utama program |
| `Dokumentasi.pdf` | Tangkapan layar hasil jalannya program |
| `README.md` | Dokumentasi repositori |

## Fitur Utama dan Logika Program

**1. Menu utama.** Program menampilkan menu Play dan Exit di dalam perulangan `repeat-until`. Perulangan berhenti ketika pemain memilih Exit (`E`).

**2. Pemilihan class.** Pemain memilih class melalui struktur `case-of`. Setiap class memiliki nilai HP dan damage awal yang berbeda. Pilihan di luar 1 sampai 4 akan menghasilkan class Novice sebagai nilai bawaan.

| Class | HP | Damage Awal |
|-------|----|-------------|
| Ranger | 450 | 35 |
| Mage | 350 | 50 |
| Swordsman | 600 | 25 |
| Assassin | 300 | 60 |

**3. Gelombang musuh.** Permainan terdiri dari tiga gelombang yang dikendalikan perulangan `for-to-do`. HP dan damage musuh bertambah sesuai nomor gelombang.

**4. Sistem pertarungan.** Pertarungan berjalan dalam perulangan `while-do` selama HP pemain dan HP musuh masih lebih dari nol. Pada setiap giliran, pemain memilih satu aksi melalui `case-of`:
- Attack: mengurangi HP musuh sebesar damage pemain, kemudian musuh membalas jika masih hidup. Damage pemain bertambah setiap kali menyerang.
- Item: memulihkan HP menggunakan potion (tersedia 3 buah). Jika potion habis atau input tidak valid, `continue` digunakan agar pemain memilih ulang tanpa kehilangan giliran.
- Run: melarikan diri dari pertarungan menggunakan `break`, kemudian gelombang diulang dari awal.

**5. Level dan XP.** Setiap musuh yang dikalahkan memberikan XP. Ketika XP mencapai batas, pemain naik level, HP maksimum dan damage bertambah, dan HP dipulihkan penuh.

**6. Boss.** Setelah gelombang 1 dan 2 selesai, boss muncul dengan peluang 20% yang ditentukan menggunakan `Random(100)`. Pada gelombang 3, boss selalu muncul. Pada pertarungan boss, damage pemain dikalikan pengali acak (normal, strong hit, atau critical hit), sedangkan boss memiliki peluang menggunakan serangan Rage Strike dengan damage dua kali lipat.

**7. Kondisi akhir permainan.**
- Pemain gugur: ditampilkan pesan Game Over dan program kembali ke menu utama.
- Pemain melarikan diri dari boss pada gelombang 1 atau 2: permainan berlanjut ke gelombang berikutnya.
- Pemain melarikan diri dari boss pada gelombang 3: permainan berakhir sebagai kekalahan.
- Boss gelombang 3 dikalahkan: permainan dinyatakan tamat.

## Pemenuhan Ketentuan Proyek

| Ketentuan | Implementasi |
|-----------|--------------|
| Input-output dan tipe data | `write`, `writeln`, `readln`; tipe `char`, `integer`, `string`, `boolean` |
| Struktur pengkondisian | `if-then-else`, nested-if, `case-of` |
| Minimal dua jenis perulangan | `repeat-until`, `for-to-do`, `while-do` |
| `break` atau `continue` | `break` saat melarikan diri dan game over; `continue` saat input tidak valid atau potion habis |
| Menu interaktif | Menu berbasis `repeat-until` dengan fitur Play dan Exit |

## Cara Menjalankan

1. Pastikan Free Pascal Compiler terpasang.
2. Kompilasi program dengan perintah `fpc GamePetualangan.pas`.
3. Jalankan berkas hasil kompilasi, lalu masukkan pilihan sesuai petunjuk pada layar.

Catatan: program menerima input berupa angka pada bagian pemilihan class dan aksi. Memasukkan huruf pada bagian tersebut dapat menyebabkan program berhenti.
