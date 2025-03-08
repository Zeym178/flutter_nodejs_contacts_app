import 'package:contacts_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatefulWidget {
  final Map contact;
  final VoidCallback refresh;
  const UpdatePage({super.key, required this.contact, required this.refresh});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  AuthService authService = AuthService();
  String errorMessage = "";

  void updateContact() async {
    final response = await authService.updateContact(
      widget.contact['_id'],
      _nameController.text,
      _emailController.text,
      _phoneController.text,
    );

    if (response == true) {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      widget.refresh();
      Navigator.pop(context);
    } else {
      setState(() {
        errorMessage = "Los campos no son validos";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.contact['name'];
    _emailController.text = widget.contact['email'];
    _phoneController.text = widget.contact['phone'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('M O D I F I C A R'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: updateContact,
            child: Center(child: Icon(Icons.check)),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 60,
                margin: EdgeInsets.only(left: 20),
                child: Center(child: Text('Nombre: ')),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextField(
                    controller: _nameController,
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                height: 40,
                width: 60,
                margin: EdgeInsets.only(left: 20),
                child: Center(child: Text('Email: ')),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextField(
                    controller: _emailController,
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                height: 40,
                width: 60,
                margin: EdgeInsets.only(left: 20),
                child: Center(child: Text('Numero: ')),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextField(
                    controller: _phoneController,
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Center(child: Text(errorMessage)),
        ],
      ),
    );
  }
}
