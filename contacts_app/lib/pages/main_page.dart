import 'package:contacts_app/pages/home_page.dart';
import 'package:contacts_app/pages/login_page.dart';
import 'package:contacts_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: Text('loading ...')));
        }

        if (snapshot.hasData && snapshot.data == true) {
          return HomePage();
        }

        return LoginPage();
      },
    );
  }
}
