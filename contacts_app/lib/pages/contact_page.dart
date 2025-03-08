import 'package:contacts_app/pages/update_page.dart';
import 'package:contacts_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final Map contact;
  final VoidCallback refresh;
  const ContactPage({super.key, required this.contact, required this.refresh});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  AuthService authService = AuthService();

  void refresh() {
    widget.refresh();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authService.getOneContact(widget.contact['_id']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData && snapshot.data != null) {
          final contact = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                UpdatePage(contact: contact, refresh: refresh),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Center(child: Icon(Icons.edit)),
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(contact['name']),
                  ),
                ),

                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(contact['email']),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(contact['phone']),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri phoneurl = Uri(
                          scheme: 'tel',
                          path: contact['phone'],
                        );

                        if (await canLaunchUrl(phoneurl)) {
                          launchUrl(phoneurl);
                        } else {
                          print("something went wrong launching the phoneurl");
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Icon(Icons.phone)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
