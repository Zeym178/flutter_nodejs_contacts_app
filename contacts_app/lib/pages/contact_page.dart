import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final Map contact;
  const ContactPage({super.key, required this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C O N T A C T O"), centerTitle: true),
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
              child: Text(widget.contact['name']),
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
              child: Text(widget.contact['email']),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.contact['phone']),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final Uri phoneurl = Uri(
                    scheme: 'tel',
                    path: widget.contact['phone'],
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
}
