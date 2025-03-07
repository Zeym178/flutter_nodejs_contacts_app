import 'package:contacts_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback goToLogin;
  const RegisterPage({super.key, required this.goToLogin});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = AuthService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password1Controller = TextEditingController();
  String errorMessage = "";

  void _register() async {
    if (_passwordController.text != _password1Controller.text) {
      setState(() {
        errorMessage = "Las contraseñas no coiciden";
      });
      return;
    }

    final success = await authService.register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      widget.goToLogin();
    } else {
      setState(() {
        errorMessage = "Los campos no son validos !";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
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
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _password1Controller,
              decoration: InputDecoration(
                hintText: 'Password again',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _register,
            child: Center(child: Text('Register')),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: widget.goToLogin,
            child: Text(
              "Ya tienes una cuenta ..?, Logeate",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),

          SizedBox(
            height: 20,
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
