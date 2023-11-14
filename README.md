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

# Tugas 8
<details>
<summary>1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!</summary>

* ```Navigator.push()``` menambahkan route baru ke dalam stack, sehingga isi dari stack adalah route yang baru ditambahkan dan route-route sebelumnya
contoh:
``` dart
if (item.name == "Tambah Item"){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const ShopFormPage()));
}
```

* ```Navigator.pushReplacement()``` akan menggantikan route yang sudah ada di stack dengan route baru
contoh:
```dart
onTap: () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => MyHomePage(),
    ));
},
``` 
</details>

<details>
<summary>2. Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!</summary>

* ```Container```
Sebuah _widget_ dasar yang digunakan untuk mengelompokkan widget lain dan mengatur properti-properti seperti padding, margin, warna latar, dan lainnya. 

* ```Row``` dan ```Column```
_Widget_ yang mengatur elemen anak dalam satu baris atau kolom.```Row``` digunakan untuk menyusun _widget_ secara horizontal, sedangkan ```Column``` menyusun _widget_ secara vertikal.

* ```ListView```
_Widget_ yang digunakan untuk menampilkan daftar _widget_ dalam daftar yang dapat di-scroll, baik secara vertikal maupun horizontal. 

* ```GridView```
_Widget_ yang digunakan untuk menampilkan _widget_ dalam pola grid yang dapat di-scroll secara horizontal maupun vertikal.

* ```Stack```
_Widget_ yang memungkinkan penumpukan (layer) _widget_ di atas satu sama lain. 

* ```Expanded``` dan ```Flexible```
```Expanded``` digunakan untuk mengisi ruang yang tersedia dalam ```Row```, ```Column```, atau ```Flex``` sesuai dengan proporsi yang ditentukan. ```Flexible``` memberikan kontrol yang lebih besar terhadap cara ruang ditetapkan untuk widget dalam tata letak yang bisa diubah-ubah.  
</details>

<details>
<summary>3. Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!</summary>

Pada tugas kali ini, saya menggunakan  ```TextFormField``` sebagai elemen input data seperti ```name```, ```amount```, ```description```, dan ```type```. Alasan saya menggunakan ```TextFormField``` karena ```TextFormField``` memberikan kemudahan untuk mengambil dan mengelola input data. Selain itu, ```TextFormField``` juga memberikan fitur bawaan seperti validator yang dapat saya gunakan untuk memvalidasi ketika inputnya masih kosong ketika tombol save dipencet dan memvalidasi ketika tipe data yang kita input tidak sesuai.
</details>

<details>
<summary>4. Bagaimana penerapan clean architecture pada aplikasi Flutter?</summary>

Implementasi Clean Architecture pada aplikasi Flutter bertujuan untuk memisahkan ide bisnis dari infrastruktur dan detail teknis lainnya. Umumnya, arsitektur ini terdiri dari tiga lapisan, yaitu _Domain Layer_, _Data Layer_, dan _Presentation Layer_.

* _Domain Layer_: merupakan inti dari aplikasi yang berisi aturan bisnis, entitas, use case (interaksi antara aktor dan sistem), dan logika aplikasi.

* _Data Layer_: Berisi implementasi teknis seperti repository, data sources (API, database), dan transformasi data.

* _Presentation Layer_: Bertanggung jawab atas tampilan UI, state management, dan logika yang terkait dengan tampilan.
</details>

<details>
<summary>5. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)</summary>

- [x] Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru dengan ketentuan sebagai berikut:
    
* Membuat file baru ```gmart_form.dart``` pada ```lib```

    - [x] Memakai minimal tiga elemen input, yaitu ```name```, ```amount```, ```description```. Tambahkan elemen input sesuai dengan model pada aplikasi tugas Django yang telah kamu buat.

    * Tambahkan kode berikut pada file yang sudah dibuat tadi:
    ``` dart
    import 'package:flutter/material.dart';
    import 'package:gmart/widgets/left_drawer.dart';
    import 'package:gmart/widgets/shop_card.dart';

    class ShopFormPage extends StatefulWidget {
    const ShopFormPage({Key? key}) : super(key: key);

    @override
    State<ShopFormPage> createState() => _ShopFormPageState();
    }

    class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _amount = 0;
    String _description = "";
    String _type = "";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Center(
            child: Text(
                'Form Tambah Item',
            ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Nama Item",  
                        labelText: "Nama Item",
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                    ),
                    onChanged: (String? value) {
                        setState(() {
                        _name = value!;
                        });
                    },
                    validator: (String? value) {
                        if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong!";
                        }
                        return null;
                    },
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Jumlah",
                        labelText: "Jumlah",
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                    ),
                    onChanged: (String? value) {
                        setState(() {
                        _amount = int.parse(value!);
                        });
                    },
                    validator: (String? value) {
                        if (value == null || value.isEmpty) {
                        return "Jumlah tidak boleh kosong!";
                        }
                        if (int.tryParse(value) == null) {
                        return "Jumlah harus berupa angka!";
                        }
                        return null;
                    },
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Deskripsi",
                        labelText: "Deskripsi",
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                    ),
                    onChanged: (String? value) {
                        setState(() {
                        _description = value!;
                        });
                    },
                    validator: (String? value) {
                        if (value == null || value.isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                        }
                        return null;
                    },
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Tipe",
                        labelText: "Tipe",
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                    ),
                    onChanged: (String? value) {
                        setState(() {
                        _type = value!;
                        });
                    },
                    validator: (String? value) {
                        if (value == null || value.isEmpty) {
                        return "Tipe tidak boleh kosong!";
                        }
                        return null;
                    },
                    ),
                ),
                ]
            ),
            ),
        )
        );
    }
    }
    ```
    - [x] Memiliki sebuah tombol ```Save```.

    * Tambahkan kode berikut:
    ``` dart
    Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () {
                if (_formKey.currentState!.validate()) {
                    listitem.add(Item(_name, _amount, _description, _type)); // save ke list item
                    showDialog(
                    context: context,
                    builder: (context) {
                        return AlertDialog(
                        title: const Text('Item berhasil tersimpan'),
                        content: SingleChildScrollView(
                            child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                                Text('Nama: $_name'),
                                Text('Jumlah: $_amount'),
                                Text('Deskripsi: $_description'),
                                Text('Tipe: $_type')
                            ],
                            ),
                        ),
                        actions: [
                            TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                                Navigator.pop(context);
                            },
                            ),
                        ],
                        );
                    },
                    );
                    _formKey.currentState!.reset();
                }
                },
                child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
                ),
            ),
        ),
    ),
    ```
    - [x] Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut:
        - [x] Setiap elemen input tidak boleh kosong.
        - [x] Setiap elemen input harus berisi data dengan tipe data atribut modelnya.
    
    * Jika tipe datanya ```String```, maka tambahkan _validator_ pada _form_ dengan kode berikut:
    ``` dart
    validator: (String? value) {
        if (value == null || value.isEmpty) {
        return "Nama tidak boleh kosong!";
        }
        return null;
    },
    ```

    * Jika tipenya ```int```, maka tambahkan _validator_ pada _form_ dengan kode berikut:
    ``` dart
    validator: (String? value) {
        if (value == null || value.isEmpty) {
        return "Jumlah tidak boleh kosong!";
        }
        if (int.tryParse(value) == null) {
        return "Jumlah harus berupa angka!";
        }
        return null;
    },
    ```

- [x] Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol ```Tambah Item``` pada halaman utama.

* Pada file ```shop_card.dart```, tambahkan Navigator push untuk push ```ShopFormPage```  ke stack.
``` dart
if (item.name == "Tambah Item"){
    Navigator.push(
    context, 
    MaterialPageRoute(
        builder: (context) => const ShopFormPage()
    ));
}
```

- [x] Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah ```pop-up``` setelah menekan tombol ```Save``` pada halaman formulir tambah item baru.

* Pada bagian ```onPressed()```, tambahkan fungsi ```showDialog``` dan ```idget``` ```AlertDialog``` sebagai ```pop-up``` dan sesuaikan data pada _child_ ```Column```
``` dart
onPressed: () {
    if (_formKey.currentState!.validate()) {
        listitem.add(Item(_name, _amount, _description, _type)); // save ke list item
        showDialog(
        context: context,
        builder: (context) {
            return AlertDialog(
            title: const Text('Item berhasil tersimpan'),
            content: SingleChildScrollView(
                child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                    Text('Nama: $_name'),
                    Text('Jumlah: $_amount'),
                    Text('Deskripsi: $_description'),
                    Text('Tipe: $_type')
                ],
                ),
            ),
            actions: [
                TextButton(
                child: const Text('OK'),
                onPressed: () {
                    Navigator.pop(context);
                },
                ),
            ],
            );
        },
        );
        _formKey.currentState!.reset();
    }
},
```

- [x] Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut:
    - [x] Drawer minimal memiliki dua buah opsi, yaitu ```Halaman Utama``` dan ```Tambah Item```.

    * buatlah file baru ```left_drawer.dart``` dengan kode:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:gmart/screens/list_item.dart';
    import 'package:gmart/screens/menu.dart';
    import 'package:gmart/screens/gmart_form.dart';

    class LeftDrawer extends StatelessWidget {
    const LeftDrawer({super.key});

    @override
    Widget build(BuildContext context) {
        return Drawer(
        child: ListView(
            children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                color: Colors.indigo,
                ),
                child: Column(
                children: [
                    Text(
                    'GMart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                    ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text("Catat seluruh keperluan belanjamu di sini!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                    ),
                    ),
                ],
                ),
            ),
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Halaman Utama'),
                // Bagian redirection ke MyHomePage
                onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                    ));
                },
            ),
            ListTile(
                leading: const Icon(Icons.add_shopping_cart),
                title: const Text('Tambah Item'),
                // Bagian redirection ke ShopFormPage
                onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const ShopFormPage(),
                    ));
                },
            ),
            ListTile(
                leading: const Icon(Icons.checklist),
                title: const Text('Lihat Item'),
                onTap: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const ListItemPage(),
                    ));
                },
            ),
            ],
        ),
        );
    }
    }
    ```

    * Tambahkan kode ```drawer: const LeftDrawer(),``` pada setiap halaman untuk memunculkan drawer

    - [x] Ketika memiih opsi ```Halaman Utama```, maka aplikasi akan mengarahkan pengguna ke halaman utama.

    * Pada _widget_ ```ListTile``` "Halaman Utama", pada bagian ```onTap()``` tambahkan Navigator push replacement untuk menggantikan route sebelumnya menjadi route ke halaman utama.
    ``` dart
    onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (context) => MyHomePage(),
        ));
    },
    ```

    - [x] Ketika memiih opsi (```Tambah Item```), maka aplikasi akan mengarahkan pengguna ke halaman form tambah item baru.

    * Pada _widget_ ```ListTile``` "Tambah Item", pada bagian ```onTap()``` tambahkan Navigator push replacement untuk menggantikan route sebelumnya menjadi route ke halaman ShopForm.
    ``` dart
    ListTile(
        leading: const Icon(Icons.add_shopping_cart),
        title: const Text('Tambah Item'),
        // Bagian redirection ke ShopFormPage
        onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
            builder: (context) => const ShopFormPage(),
            ));
        },
    ),
    ```

- [x] BONUS! Membuat sebuah halaman baru, yaitu halaman daftar item yang sudah dibuat dengan isi halamannya adalah setiap data produk yang sudah pernah dibuat.

* Buat file baru ```list_item.dart``` yang berisi:
``` dart
import 'package:flutter/material.dart';
import 'package:gmart/widgets/left_drawer.dart';
import 'package:gmart/widgets/shop_card.dart';

class ListItemPage extends StatefulWidget{
  const ListItemPage({Key? key});

  @override
  State<ListItemPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'List Item'
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: listitem.length,
                itemBuilder: (BuildContext context, int i){
                  return ListTile(
                    title: Text(
                      "${i + 1}. ${listitem[i].name}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Container(
                      child: Text(
                        'Jumlah: ${listitem[i].amount}\nDeskripsi: ${listitem[i].description}\nTipe: ${listitem[i].type}',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
```


- [x] BONUS! Mengarahkan pengguna ke halaman tersebut jika menekan tombol Lihat Produk pada halaman utama atau drawer.

* Pada halaman utama, tambahkan kode berikut di bagian ```onTap()```
```dart
if (item.name == "Lihat Item"){
    Navigator.push(
    context, 
    MaterialPageRoute(
        builder: (context) => const ListItemPage()
    ));
}
```

* Pada drawer, tambahkan kode berikut
``` dart
ListTile(
    leading: const Icon(Icons.checklist),
    title: const Text('Lihat Item'),
    onTap: (){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const ListItemPage(),
        ));
    },
),
```
</details> 