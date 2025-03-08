import 'package:contacts_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(child: Center(child: Icon(Icons.contacts, size: 50))),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.home),
            title: Text('H O M E'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            leading: Icon(Icons.home),
            title: Text('S E T T I N G S'),
          ),
        ],
      ),
    );
  }
}
