# <center>Plantify Mobile :deciduous_tree:</center>

<center>
    <br>
</center>
<br>

> :sunflower: **Reminder:** Have you watered your plants today?

---

### Jawaban Tugas :seven:

<details>
    <summary>Lihat disini</summary>

##### 1. Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.

- Stateless widget adalah widget yang tidak memiliki state, artinya widget ini tidak dapat diubah setelah diinisialisasi. Stateless widget hanya memiliki satu method yaitu `build()` yang digunakan untuk mengembalikan widget yang akan ditampilkan. Stateless widget biasanya digunakan untuk menampilkan widget yang tidak akan berubah, seperti text, icon, dan lain-lain.
- Stateful widget adalah widget yang memiliki state, artinya widget ini dapat diubah setelah diinisialisasi. Stateful widget memiliki dua method yaitu `createState()` dan `build()`. Method `createState()` digunakan untuk membuat state yang akan digunakan oleh widget, sedangkan method `build()` digunakan untuk mengembalikan widget yang akan ditampilkan. Stateful widget biasanya digunakan untuk menampilkan widget yang akan berubah, seperti form, list, dan lain-lain.

Perbedaan dari keduanya adalah stateless widget tidak memiliki state, sedangkan stateful widget memiliki state.

##### 2. Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.

1. MaterialApp: Digunakan untuk membuat aplikasi Flutter.
2. ThemeData: Digunakan untuk mengatur tema aplikasi Flutter.
3. ColorScheme: Digunakan untuk mengatur skema warna aplikasi Flutter.
4. StatelessWidget: Digunakan untuk membuat widget yang tidak memiliki state.
5. Scaffold: Digunakan untuk membuat layout dasar aplikasi Flutter.
6. AppBar: Digunakan untuk membuat AppBar pada aplikasi Flutter.
7. Text: Digunakan untuk menampilkan teks pada aplikasi Flutter.
8. Padding: Digunakan untuk menambahkan padding pada widget.
9. Column: Digunakan untuk menampilkan widget secara vertikal.
10. Row: Digunakan untuk menampilkan widget secara horizontal.
11. Expanded: Digunakan untuk mengatur ukuran widget secara fleksibel.
12. SizedBox: Digunakan untuk menambahkan box kosong pada widget.
13. GridView: Digunakan untuk menampilkan widget dalam bentuk grid.
14. Card: Digunakan untuk membuat kartu pada aplikasi Flutter.
15. Container: Digunakan untuk membuat kotak pada aplikasi Flutter.
16. Material: Digunakan untuk membuat material design pada aplikasi Flutter.
17. InkWell: Digunakan untuk menambahkan efek inkwell pada widget.
18. SnackBar: Digunakan untuk menampilkan snackbar pada aplikasi Flutter.
19. Icon: Digunakan untuk menampilkan icon pada aplikasi Flutter.
20. Widget Custom: Digunakan untuk membuat widget custom pada aplikasi Flutter.

##### 3. Apa fungsi dari `setState()`? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.

Fungsi dari `setState()` adalah untuk memberitahukan Flutter bahwa state dari widget telah berubah dan perlu diperbarui. Dengan menggunakan `setState()`, Flutter akan memanggil method `build()` kembali untuk mengembalikan widget yang akan ditampilkan. Variabel yang dapat terdampak dengan fungsi `setState()` adalah variabel yang digunakan dalam widget yang diubah nilainya.

##### 4. Jelaskan perbedaan antara `const` dengan `final`.

Perbedaan antara `const` dengan `final` adalah:

- `const` digunakan untuk membuat variabel yang memiliki nilai tetap sejak waktu kompilasi, artinya nilai variabel tersebut harus diketahui sebelum aplikasi dijalankan. Variabel yang dideklarasikan dengan `const` akan menjadi konstanta dan tidak dapat diubah nilainya. `const` tidak dapat digunakan untuk menyimpan objek yang mutable seperti List dan Map.
- `final` digunakan untuk membuat variabel yang memiliki nilai tetap sejak waktu runtime, artinya nilai variabel tersebut dapat diinisialisasi saat aplikasi dijalankan. Variabel yang dideklarasikan dengan `final` tidak dapat diubah nilainya, tetapi hanya dapat diinisialisasi sekali pada waktu runtime. `final` dapat digunakan untuk menyimpan objek yang mutable seperti List dan Map.

##### 5. Jelaskan bagaimana cara kamu mengimplementasikan checklist-checklist di atas.

- [x] Membuat tiga tombol sederhana dengan ikon dan teks untuk melihat daftar produk, menambah produk, dan logout

  Dimulai dengan mempersiapkan class `ItemHomepage` yang berfungsi untuk menyimpan data dari tombol yang akan dibuat:

  ```dart
  class ItemHomepage {
      final String name;
      final IconData icon;
      final Color color;

      ItemHomepage(this.name, this.icon, {this.color = Colors.blue});
  }
  ```

  Kemudian membuat list dari item (button) yang akan ditampilkan di `MyHomepage`:

  ```dart
  final List<ItemHomepage> items = [
      ItemHomepage("Lihat Daftar Produk", Icons.list, color: Colors.green),
      ItemHomepage("Tambah Produk", Icons.add, color: Colors.orange),
      ItemHomepage("Logout", Icons.logout, color: Colors.red),
  ];
  ```

  Untuk menampilkan buttonnya, dibuat sebuah custom widget bernama `ItemCard`:

  ```dart
  class ItemCard extends StatelessWidget {
      final ItemHomepage item;
      const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
      return Material(
        // Menentukan warna latar belakang dari tema aplikasi.
        color: item.color,
        // Membuat sudut kartu melengkung.
        borderRadius: BorderRadius.circular(12),

        child: InkWell(
          // Aksi ketika kartu ditekan.
          onTap: () {
            // Menampilkan pesan SnackBar saat kartu ditekan.
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text("Kamu telah menekan tombol ${item.name}")));
          },
          // Container untuk menyimpan Icon dan Text
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                // Menyusun ikon dan teks di tengah kartu.
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

- [x] Mengimplementasikan warna-warna yang berbeda untuk setiap tombol

  Pada class `ItemHomepage`, menambahkan parameter `color` yang digunakan untuk menentukan warna dari tombol:

  ```dart
  class ItemHomepage {
      final String name;
      final IconData icon;
      final Color color;

      ItemHomepage(this.name, this.icon, {this.color = Colors.blue});
  }
  ```

  Kemudian menentukan warna dari tombol pada list `items`:

  ```dart
  final List<ItemHomepage> items = [
      ItemHomepage("Lihat Daftar Produk", Icons.list, color: Colors.orange),
      ItemHomepage("Tambah Produk", Icons.add, color: Colors.green),
      ItemHomepage("Logout", Icons.logout, color: Colors.red),
  ];
  ```

  Dan menampilkan warna dari tombol pada widget `ItemCard`:

  ```dart
  // Di dalam custom widget button
  Material(
      color: item.color,
      ...
  ),
  ```

- [x] Memunculkan Snackbar dengan tulisan "Kamu telah menekan tombol {nama tombol}" ketika ketiga tombol ditekan

  Pada custom widget button ditambahkan aksi onTap yang menampilkan pesan Snackbar:

  ```dart
  onTap: () {
        // Menampilkan pesan SnackBar saat kartu ditekan.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text("Kamu telah menekan tombol ${item.name}")));
  },
  ```

</details>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
