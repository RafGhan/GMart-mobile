# Tugas 7

<details>
<summary>1. Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?</summary>

* Stateless
    + tidak punya state, tidak bisa berubah dengan sendirinya melalui tindakan internal.
    + Stateless widget diubah oleh peristiwa eksternal pada widget induk di dalam pohon widget
    + memungkinkan widget induk tertentu dalam pohon widget untuk mengontrol bagaimana mereka dibangun.
    + Widget anak akan menerima deskripsi atau karakteristiknya dari widget induk dan tidak dapat mengubahnya sendiri.
    + Stateless widget hanya memiliki properti final yang ditentukan selama konstruksi, dan itulah satu-satunya hal yang perlu dibangun di layar perangkat

* Stateful
    + dapat mengubah deskripsinya secara dinamis selama hidupnya.
    + bersifat immutable, tetapi mereka memiliki class State yang mewakili status saat ini dari widget tersebut
</details>

<details>
<summary>2. Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.</summary>

* ```MyHomePage``` digunakan sebagai halaman utama aplikasi yang berisi daftar item toko.
* ```Scaffold``` digunakan untuk membuat tata letak dasar aplikasi dan mengatur kerangka umum tampilan halaman
* ```AppBar``` digunakan untuk menampilkan judul aplikasi di bilah atas dan sebagai tanda pengenal aplikasi.
* ```Padding``` digunakan untuk mengatur jarak atau margin di antara widget anaknya
* ```ShopCard``` digunakan untuk menampilkan setiap item toko dalam bentuk kartu
* ```Icon``` digunakan untuk menampilkan ikon untuk item toko
* ```Text``` digunakan untuk menampilkan text untuk nama item toko 
* ```SnackBar``` digunakan untuk menampilkan pesan yang muncul ketika salah satu tombol ditekan
* ```ScaffoldMessenger``` digunakan untuk menampilkan pesan snackbar ketika salah satu tombol ditekan
* ```SingleChildScrollView```
* ```Column``` digunakan untuk menampilkan children secara vertikal
* ```GridView.count``` digunakan untuk membuat grid layout dengan jumlah baris dan kolom yang dapat diatur
* ```ShopItem``` digunakan untuk merepresentasikan item toko 
* ```Material``` digunakan untuk  mengatur latar belakang kartu item toko
* ```InkWell``` digunakan untuk membuat area responsif terhadap sentuhan. Ketika di-klik, widget ini menampilkan ```SnackBar``` yang memberikan pesan
* ```Container``` digunakan untuk mengelompokkan ikon dan teks dalam kartu item toko

</details>

<details>
<summary>3. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)</summary>

- [x] Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.

    * Pada cmd, generate proyek flutter baru dengan perintah ```flutter create gmart``` pada folder tempat proyek flutter akan dibuat
    * Buat file ```menu.dart``` pada direktori ```gmart/lib```, dan tambahkan ```import 'package:flutter/material.dart';``` pada baris pertamanya
    * Pada file ```main.dart```, _cut_ kode dari baris 39 hingga akhir dan _paste_ pada ```menu.dart```
    * Pada file ```main.dart```, tambahkan ```import 'package:gmart/menu.dart';```pada baris pertamanya supaya tidak error karena class MyHomePage sudah dipindahkan ke ```menu.dart``` dan ubah ```MyHomePage(title: 'Flutter Demo Home Page')``` menjadi ```MyHomePage()``` saja.
    * Pada ```menu.dart```, ubah ```({super.key, required this.title})``` menjadi ```({Key? key}) : super(key: key);```, hapus ```final String title;``` sampai bawah dan tambahkan widget build sehingga bentuk kodenya menjadi berikut:
    ``` dart
    class MyHomePage extends StatelessWidget {
        MyHomePage({Key? key}) : super(key: key);

        @override
        Widget build(BuildContext context) {
            return Scaffold(
                ...
            );
        }
    }
    ```

- [x] Membuat tiga tombol sederhana dengan ikon dan teks untuk:
    - [x] Melihat daftar item (```Lihat Item```)
    - [x] Menambah item (```Tambah Item```)
    - [x] Logout (```Logout```)

    * untuk menambah card, kita dapat mendifine tipe dengan menambahkan
    ``` dart
    class ShopItem {
        final String name;
        final IconData icon;

        ShopItem(this.name, this.icon);
    }
    ```

    * tambahkan barang-barang yang dijual (nama, harga, dan icon barang tersebut) dengan kode berikut di bawah ```MyHomePage({Key? key}) : super(key: key);```
    ``` dart
    final List<ShopItem> items = [
        ShopItem("Lihat Produk", Icons.checklist),
        ShopItem("Tambah Produk", Icons.add_shopping_cart),
        ShopItem("Logout", Icons.logout),
    ];
    ```

    * tambahkan kode berikut di dalam widget build
    ``` dart
        class ShopCard extends StatelessWidget {
            final ShopItem item;

            const ShopCard(this.item, {super.key}); // Constructor

            @override
            Widget build(BuildContext context) {
                return Material(
                color: Colors.indigo,
                child: InkWell(
                    // Area responsive terhadap sentuhan
                    onTap: () {
                    // Memunculkan SnackBar ketika diklik
                    ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text("Kamu telah menekan tombol ${item.name}!")));
                    },
                    child: Container(
                    // Container untuk menyimpan Icon dan Text
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(
                            item.icon,
                            color: Colors.white,
                            size: 30.0,
                            ),
                            const Padding(padding: EdgeInsets.all(3)),
                            Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                            ),
                        ],
                        ),
                    ),
                    ),
                ),
                );
            }
        }
    ```

- [x] Memunculkan ```Snackbar``` dengan tulisan:
    - [x] "Kamu telah menekan tombol Lihat Item" ketika tombol ```Lihat Item``` ditekan.
    - [x] "Kamu telah menekan tombol Tambah Item" ketika tombol ```Tambah Item``` ditekan.
    - [x] "Kamu telah menekan tombol Logout" ketika tombol ```Logout``` ditekan.

    * untuk menambahkan ```snackbar``` dapat menambahkan kode berikut di ```menu.dart``` pada widget build pada class ShopCard
    ``` dart
    onTap: () {
        // Memunculkan SnackBar ketika diklik
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("Kamu telah menekan tombol ${item.name}!")));
    },
    ```

- [x] BONUS! mengimplementasikan warna-warna yang berbeda untuk setiap tombol (```Lihat Item```, ```Tambah Item```, dan ```Logout```).

    * Pada file ```menu.dart```, tambahkan properti color pada class ShopItem
    ``` dart
    class ShopItem {
        final String name;
        final IconData icon;
        final Color color;

        ShopItem(this.name, this.icon, this.color);
    }
    ```
    * tambahkan warna pada ```List<ShopItem>``` sehingga menjadi
    ``` dart
        final List<ShopItem> items = [
            ShopItem("Lihat Item", Icons.checklist, const Color.fromARGB(255, 69, 168, 250)),
            ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.indigo),
            ShopItem("Logout", Icons.logout, const Color.fromARGB(255, 200, 118, 146)),
        ];
    ``` 

    * untuk mengubah warna card sesuai dengan warna yang kita setting ubah widget build pada class ShopCard dari 
    ``` dart
    Widget build(BuildContext context) {
        return Material(
            color: Colors.indigo,
    ...
    )}
    ```

    menjadi
     
    ``` dart
    Widget build(BuildContext context) {
    return Material(
      color: item.color,
    ...
    )}
    ```
</details> 
 
