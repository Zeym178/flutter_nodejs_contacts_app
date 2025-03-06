import 'package:contacts_app/pages/home_page.dart';
import 'package:contacts_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = "";

  void _login() async {
    bool isLoggedIn = await authService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        errorMessage = "Usuario o Contraseña incorrectas";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _login,
            child: Center(child: Text('Log In')),
          ),
          SizedBox(height: 20, child: Text(errorMessage)),
        ],
      ),
    );
  }
}
