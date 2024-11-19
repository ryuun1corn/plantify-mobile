import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plantify_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  }
}
