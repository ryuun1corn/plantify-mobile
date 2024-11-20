# <center>Plantify Mobile :deciduous_tree:</center>

> :sunflower: **Reminder:** Have you watered your plants today?

---

### Jawaban Tugas :nine:

<details open>
    <summary>Lihat disini</summary>

##### 1. Jelaskan mengapa kita perlu membuat model untuk melakukan pengambilan ataupun pengiriman data JSON? Apakah akan terjadi error jika kita tidak membuat model terlebih dahulu?

Model digunakan untuk mengatur data yang akan diambil atau dikirim dalam format JSON. Dengan menggunakan model, kita dapat mengatur struktur data yang akan diambil atau dikirim sehingga memudahkan proses pengambilan atau pengiriman data. Jika tidak membuat model terlebih dahulu, maka akan sulit untuk mengatur data yang akan diambil atau dikirim dalam format JSON.

Error dapat terjadi jika tidak membuat model terlebih dahulu, karena data yang diambil atau dikirim dalam format JSON tidak dapat diatur dengan baik. Hal ini dapat menyebabkan data tidak sesuai dengan yang diharapkan dan menyebabkan error pada aplikasi.

##### 2. Jelaskan fungsi dari library http yang sudah kamu implementasikan pada tugas ini

Library http digunakan untuk melakukan request HTTP ke server dan mengambil data dalam format JSON. Library http memiliki method yang digunakan untuk melakukan request GET, POST, PUT, DELETE, dan lain-lain. Library http juga memiliki method yang digunakan untuk mengatur header, body, dan parameter dari request HTTP.

##### 3. Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

CookieRequest digunakan untuk menyimpan cookie yang diterima dari server dan digunakan untuk request HTTP selanjutnya. CookieRequest perlu dibagikan ke semua komponen di aplikasi Flutter agar cookie yang diterima dari server dapat digunakan oleh semua komponen di aplikasi Flutter. Dengan menggunakan CookieRequest, kita dapat menyimpan cookie yang diterima dari server dan menggunakannya untuk request HTTP selanjutnya.

##### 4. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

Mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter adalah sebagai berikut:

1. Input data pada aplikasi Flutter menggunakan widget seperti `TextFormField`, `DropdownButtonFormField`, dan lain-lain.
2. Data yang diinputkan oleh pengguna disimpan dalam variabel atau model yang digunakan untuk mengirim data ke server.
3. Data yang diinputkan oleh pengguna dikirim ke server menggunakan request HTTP seperti POST, PUT, atau DELETE.
4. Server menerima data yang dikirim dari aplikasi Flutter dan memproses data tersebut.
5. Server mengirimkan data yang telah diproses ke aplikasi Flutter dalam format JSON.
6. Aplikasi Flutter menerima data yang dikirim dari server dan menampilkannya menggunakan widget seperti `Text`, `ListView`, `GridView`, dan lain-lain.

##### 5. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Mekanisme autentikasi dari login, register, hingga logout adalah sebagai berikut:

1. Input data akun pada aplikasi Flutter menggunakan widget seperti `TextFormField`, `ElevatedButton`, dan lain-lain.
2. Data akun yang diinputkan oleh pengguna disimpan dalam variabel atau model yang digunakan untuk mengirim data ke server.
3. Data akun yang diinputkan oleh pengguna dikirim ke server menggunakan request HTTP seperti POST, PUT, atau DELETE.
4. Server menerima data akun yang dikirim dari aplikasi Flutter dan memproses data tersebut.
5. Server melakukan autentikasi data akun yang diterima dari aplikasi Flutter menggunakan Django.
6. Jika autentikasi berhasil, server mengirimkan data akun yang telah diautentikasi ke aplikasi Flutter dalam format JSON.
7. Aplikasi Flutter menerima data akun yang dikirim dari server dan menampilkannya menggunakan widget seperti `Text`, `ListView`, `GridView`, dan lain-lain.
8. Jika autentikasi gagal, server mengirimkan pesan error ke aplikasi Flutter dalam format JSON.
9. Aplikasi Flutter menerima pesan error yang dikirim dari server dan menampilkannya menggunakan widget seperti `Text`, `SnackBar`, dan lain-lain.

##### 6. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

- [x] Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.

  1. Membuat app django baru bernama `authentication` untuk melakukan integrasi dengan aplikasi Flutter.
  2. Menambahkan fungsi registrasi di views aplikasi yang baru dibuat:

  ```python
  @csrf_exempt
  def register(request):
      if request.method == "POST":
          data = json.loads(request.body)
          username = data["username"]
          password1 = data["password1"]
          password2 = data["password2"]

          # Check if the passwords match
          if password1 != password2:
              return JsonResponse(
                  {"status": False, "message": "Passwords do not match."}, status=400
              )

          # Check if the username is already taken
          if User.objects.filter(username=username).exists():
              return JsonResponse(
                  {"status": False, "message": "Username already exists."}, status=400
              )

          # Create the new user
          user = User.objects.create_user(username=username, password=password1)
          user.save()

          return JsonResponse(
              {
                  "username": user.username,
                  "status": "success",
                  "message": "User created successfully!",
              },
              status=200,
          )

      else:
          return JsonResponse(
              {"status": False, "message": "Invalid request method."}, status=400
          )
  ```

  3. Menambahkan fungsi tersebut ke dalam `urls.py`
  4. Membuat halaman form registrasi pada aplikasi Flutter pada file `register_page.dart`:

  ```dart
  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:plantify_mobile/screens/login.dart';
  import 'package:pbp_django_auth/pbp_django_auth.dart';
  import 'package:provider/provider.dart';

  class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    State<RegisterPage> createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password1 = _passwordController.text;
                        String password2 = _confirmPasswordController.text;

                        final response = await request.postJson(
                            "http://127.0.0.1:8000/auth/register/",
                            jsonEncode({
                              "username": username,
                              "password1": password1,
                              "password2": password2,
                            }));
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully registered!'),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to register!'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
  ```

- [x] Membuat halaman login pada proyek tugas Flutter.

  1. Halaman yang dibuat terletak pada file `login_page.dart`:

  ```dart
  import 'package:plantify_mobile/screens/menu.dart';
  import 'package:flutter/material.dart';
  import 'package:pbp_django_auth/pbp_django_auth.dart';
  import 'package:provider/provider.dart';
  import 'package:plantify_mobile/screens/register.dart';

  void main() {
    runApp(const LoginApp());
  }

  class LoginApp extends StatelessWidget {
    const LoginApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Login',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(secondary: Colors.deepPurple[400]),
        ),
        home: const LoginPage(),
      );
    }
  }

  class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        final response = await request
                            .login("http://127.0.0.1:8000/auth/login/", {
                          'username': username,
                          'password': password,
                        });

                        if (request.loggedIn) {
                          String message = response['message'];
                          String uname = response['username'];
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                    content:
                                        Text("$message Selamat datang, $uname.")),
                              );
                          }
                        } else {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Login Gagal'),
                                content: Text(response['message']),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 36.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
  ```

- [x] Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.

  1. Membuat fungsi login pada views aplikasi Django:

  ```python
  @csrf_exempt
  def login(request):
      username = request.POST["username"]
      password = request.POST["password"]
      user = authenticate(username=username, password=password)
      if user is not None:
          if user.is_active:
              auth_login(request, user)
              # Status login sukses.
              return JsonResponse(
                  {
                      "username": user.username,
                      "status": True,
                      "message": "Login sukses!",
                      # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
                  },
                  status=200,
              )
          else:
              return JsonResponse(
                  {"status": False, "message": "Login gagal, akun dinonaktifkan."},
                  status=401,
              )

      else:
          return JsonResponse(
              {
                  "status": False,
                  "message": "Login gagal, periksa kembali email atau kata sandi.",
              },
              status=401,
          )
  ```

  2. Menambahkan fungsi tersebut ke dalam `urls.py`
  3. Membuat fungsi logout pada views aplikasi Django:

  ```python
  @csrf_exempt
  def logout(request):
      username = request.user.username

      try:
          auth_logout(request)
          return JsonResponse(
              {"username": username, "status": True, "message": "Logout berhasil!"},
              status=200,
          )
      except:
          return JsonResponse({"status": False, "message": "Logout gagal."}, status=401)
  ```

  4. Menambahkan fungsi tersebut ke dalam `urls.py`
  5. Membuat fungsi logout pada aplikasi Flutter pada widget 'ItemCard':

  ```dart
  if (item.name == "Logout") {
      final response = await request.logout(
        "http://127.0.0.1:8000/auth/logout/",
      );

      String message = response['message'];

      if (context.mounted) {
        if (response['status']) {
          String uname = response["username"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$message Sampai jumpa, $uname."),
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        }
      }
    }
  ```

  6. Menampilkan halaman login saat pertama kali membuka aplikasi Flutter:

  ```dart
  home: const LoginPage(),
  ```

  7. Menginstall library berupa: `http`, `provider`, `pbp_django_auth` untuk memastikan integrasi dengan Django berjalan dengan baik.
  8. Menambahkan `Provider` pada `main.dart`:

  ```dart
  return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Plantify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(secondary: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ));
  ```

- [x] Membuat model kustom sesuai dengan proyek aplikasi Django.

  1. Model kustom terletak pada file `models/tropical_plant.dart`, dan dibuat dengan bantuan website [QuickType](https://app.quicktype.io/):

  ```dart
  import 'dart:convert';

  List<TropicalPlant> tropicalPlantFromJson(String str) =>
      List<TropicalPlant>.from(
          json.decode(str).map((x) => TropicalPlant.fromJson(x)));

  String tropicalPlantToJson(List<TropicalPlant> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  class TropicalPlant {
    String model;
    String pk;
    Fields fields;

    TropicalPlant({
      required this.model,
      required this.pk,
      required this.fields,
    });

    factory TropicalPlant.fromJson(Map<String, dynamic> json) => TropicalPlant(
          model: json["model"],
          pk: json["pk"],
          fields: Fields.fromJson(json["fields"]),
        );

    Map<String, dynamic> toJson() => {
          "model": model,
          "pk": pk,
          "fields": fields.toJson(),
        };
  }

  class Fields {
    int user;
    String name;
    int price;
    String description;
    int weight;
    DateTime createdAt;

    Fields({
      required this.user,
      required this.name,
      required this.price,
      required this.description,
      required this.weight,
      required this.createdAt,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
          user: json["user"],
          name: json["name"],
          price: json["price"],
          description: json["description"],
          weight: json["weight"],
          createdAt: DateTime.parse(json["created_at"]),
        );

    Map<String, dynamic> toJson() => {
          "user": user,
          "name": name,
          "price": price,
          "description": description,
          "weight": weight,
          "created_at": createdAt.toIso8601String(),
        };
  }
  ```

- [x] Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.

  1. Membuat halaman daftar item pada file `list_tropicalplant.dart`:

  ```dart
  import 'package:flutter/material.dart';
  import 'package:pbp_django_auth/pbp_django_auth.dart';
  import 'package:plantify_mobile/models/tropical_plant.dart';
  import 'package:plantify_mobile/widgets/left_drawer.dart';
  import 'package:provider/provider.dart';
  import 'package:plantify_mobile/screens/detail_tropicalplant.dart';

  class TropicalPlantPage extends StatefulWidget {
    const TropicalPlantPage({super.key});

    @override
    State<TropicalPlantPage> createState() => _TropicalPlantPageState();
  }

  class _TropicalPlantPageState extends State<TropicalPlantPage> {
    Future<List<TropicalPlant>> fetchTropicalPlants(CookieRequest request) async {
      final response =
          await request.get('http://127.0.0.1:8000/tropical-plant-json/');

      var data = response;

      List<TropicalPlant> tropicalPlants = [];
      for (var d in data) {
        if (d != null) {
          tropicalPlants.add(TropicalPlant.fromJson(d));
        }
      }
      return tropicalPlants;
    }

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();

      return Scaffold(
          appBar: AppBar(
            title: const Text('Tropical Plants List'),
          ),
          drawer: const LeftDrawer(),
          body: FutureBuilder(
              future: fetchTropicalPlants(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          'Belum ada data tanaman tropis pada Plantify',
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final plant = snapshot.data![index].fields;
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TropicalPlantDetailPage(
                                      plantId: snapshot.data![index].pk,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plant.name,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${plant.price}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff4CAF50),
                                          ),
                                        ),
                                        Text(
                                          "${plant.weight} kg",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      plant.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              }));
    }
  }
  ```

- [x] Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.

  1. Halaman detail item terletak pada file `detail_tropicalplant.dart`:

  ```dart
  import 'package:flutter/material.dart';
  import 'package:plantify_mobile/models/tropical_plant.dart';
  import 'package:pbp_django_auth/pbp_django_auth.dart';
  import 'package:provider/provider.dart';

  class TropicalPlantDetailPage extends StatefulWidget {
    final String plantId;

    const TropicalPlantDetailPage({super.key, required this.plantId});

    @override
    State<TropicalPlantDetailPage> createState() =>
        _TropicalPlantDetailPageState();
  }

  class _TropicalPlantDetailPageState extends State<TropicalPlantDetailPage> {
    Future<TropicalPlant> fetchTropicalPlant(
        CookieRequest request, String id) async {
      final response =
          await request.get('http://127.0.0.1:8000/tropical-plant-json/$id/');

      var data = response;

      return TropicalPlant.fromJson(data[0]);
    }

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Tropical Plant Detail'),
        ),
        body: FutureBuilder(
          future: fetchTropicalPlant(request, widget.plantId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Plant not found!',
                      style: TextStyle(fontSize: 20, color: Colors.redAccent),
                    ),
                  ],
                ),
              );
            } else {
              final plant = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          plant.fields.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                plant.fields.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Price:",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\$${plant.fields.price.toString()}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Weight:",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${plant.fields.weight.toString()} kg",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  }
  ```

- [x] Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.

  1. Filter dilakukan secara otomatis berkat komponen `CookieRequest` yang digunakan pada setiap request HTTP yang dilakukan oleh aplikasi Flutter:

  ```dart
  Future<List<TropicalPlant>> fetchTropicalPlants(CookieRequest request) async {
      final response =
          await request.get('http://127.0.0.1:8000/tropical-plant-json/');

      var data = response;

      List<TropicalPlant> tropicalPlants = [];
      for (var d in data) {
        if (d != null) {
          tropicalPlants.add(TropicalPlant.fromJson(d));
        }
      }
      return tropicalPlants;
    }
  ```

  2. Dapat dilihat bahwa fungsi di atas mengirim request kepada Django melalui `CookieRequest` yang sudah terautentikasi. Sehingga, hanya data yang terasosiasi dengan pengguna yang login yang akan ditampilkan.

</details>

---

### Jawaban Tugas :eight:

<details>
    <summary>Lihat disini</summary>

##### 1. Apa kegunaan const di Flutter? Jelaskan apa keuntungan ketika menggunakan const pada kode Flutter. Kapan sebaiknya kita menggunakan const, dan kapan sebaiknya tidak digunakan?

`const` digunakan untuk membuat variabel yang memiliki nilai tetap sejak waktu kompilasi, artinya nilai variabel tersebut harus diketahui sebelum aplikasi dijalankan. Variabel yang dideklarasikan dengan `const` akan menjadi konstanta dan tidak dapat diubah nilainya.

Widget yang dideklarasikan dengan `const` akan di-cache oleh Flutter sehingga tidak perlu dibuat ulang ketika widget tersebut di-rebuild. Hal ini akan menghemat penggunaan memori dan meningkatkan performa aplikasi Flutter.

Sebaiknya menggunakan `const` ketika nilai variabel tersebut diketahui sejak waktu kompilasi dan tidak akan berubah. Sebaliknya, sebaiknya tidak menggunakan `const` ketika nilai variabel tersebut tidak diketahui sejak waktu kompilasi atau akan berubah.

##### 2. Jelaskan dan bandingkan penggunaan Column dan Row pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!

`Column` digunakan untuk menampilkan widget secara vertikal, sedangkan `Row` digunakan untuk menampilkan widget secara horizontal. `Column` dan `Row` memiliki properti yang sama yaitu `mainAxisAlignment` dan `crossAxisAlignment` yang digunakan untuk mengatur posisi widget di dalamnya.

Contoh implementasi dari `Column`:

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Nama Tanaman: $_plantName'),
    Text('Harga Tanaman: $_plantPrice'),
    Text('Berat Tanaman: $_plantWeight'),
    Text('Deskripsi Tanaman: $_plantDescription'),
  ],
)
```

![image](https://github.com/user-attachments/assets/e33553a4-d1ae-4314-82a7-eabe9301b5c6)

Contoh implementasi dari `Row`:

```dart
// Row untuk menampilkan 3 InfoCard secara horizontal.
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    InfoCard(title: 'NPM', content: npm),
    InfoCard(title: 'Name', content: name),
    InfoCard(title: 'Class', content: className),
  ],
)
```

![image](https://github.com/user-attachments/assets/42616b89-e934-45bf-b694-96310a564280)

##### 3. Sebutkan apa saja elemen input yang kamu gunakan pada halaman form yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!

Elemen input yang saya gunakan pada halaman form tugas ini adalah `TextFormField` dan `ElevatedButton`. `TextFormField` digunakan untuk membuat input field yang dapat menerima input dari pengguna, sedangkan `ElevatedButton` digunakan untuk membuat tombol yang dapat ditekan oleh pengguna.

Elemen input Flutter lain yang tidak saya gunakan pada tugas ini adalah `CheckboxListTile`, `RadioListTile`, `SwitchListTile`, `Slider`, `DropdownButtonFormField`, dan masih banyak lagi. Elemen input tersebut digunakan untuk membuat input field yang berbeda-beda sesuai dengan kebutuhan aplikasi.

##### 4. Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?

Tema (theme) dalam aplikasi Flutter dapat diatur menggunakan class `ThemeData` yang digunakan untuk mengatur warna, font, dan style aplikasi. Tema aplikasi Flutter dapat diatur secara global menggunakan class `MaterialApp` dengan properti `theme` yang digunakan untuk menentukan tema aplikasi.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(secondary: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```

Saya mengimplementasikan tema pada aplikasi yang saya buat dengan mengatur warna tema menggunakan class `ThemeData` dan `ColorScheme` pada class `MaterialApp`.

##### 5. Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?

Navigasi dalam aplikasi dengan banyak halaman pada Flutter dapat ditangani menggunakan class `Navigator` yang digunakan untuk mengatur navigasi antar halaman. Navigasi dapat dilakukan dengan cara push, pop, replace, dan lain-lain.

</details>

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
