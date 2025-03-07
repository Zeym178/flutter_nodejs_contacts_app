import 'package:contacts_app/pages/contact_page.dart';
import 'package:contacts_app/pages/main_page.dart';
import 'package:contacts_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  final _newnameController = TextEditingController();
  final _newemailController = TextEditingController();
  final _newphoneController = TextEditingController();
  String errorMessage = "";

  void showSuccessAlert(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: message,
    );
    setState(() {});
  }

  void showErrorAlert(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: message,
    );
    setState(() {});
  }

  void createContact() async {
    final created = await authService.createContact(
      _newnameController.text,
      _newemailController.text,
      _newphoneController.text,
    );

    if (created) {
      Navigator.pop(context);
      _newnameController.clear();
      _newemailController.clear();
      _newphoneController.clear();
      showSuccessAlert("El contacto se creó correctamente");
    } else {
      setState(() {
        errorMessage = "Los campos no son validos";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(child: Text("Crear Nuevo Contacto")),
                content: Column(
                  children: [
                    TextField(
                      controller: _newnameController,
                      decoration: InputDecoration(hintText: "Nombre"),
                    ),
                    TextField(
                      controller: _newemailController,
                      decoration: InputDecoration(hintText: "email"),
                    ),
                    TextField(
                      controller: _newphoneController,
                      decoration: InputDecoration(hintText: "phone"),
                    ),
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Center(child: Text("Cancelar")),
                    ),
                  ),

                  GestureDetector(
                    onTap: createContact,
                    child: Container(
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Center(child: Text("Crear")),
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Center(child: Icon(Icons.add)),
      ),
      appBar: AppBar(
        title: Text('C O N T A C T O S'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () async {
              if (await authService.logout()) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              } else {
                print("something went wrong ");
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 40,
              width: 40,
              child: Center(child: Icon(Icons.logout)),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: authService.getAllContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data != null) {
                  final contactsList = snapshot.data!;
                  return _contactsList(contactsList);
                }

                return Center(
                  child: Text("something went wrong getting the contacts"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView _contactsList(List<dynamic> contactsList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contactsList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 40,
          child: Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    final deleted = await authService.deleteContact(
                      contactsList[index]['_id'],
                    );
                    if (deleted) {
                      showSuccessAlert(
                        "El contacto se eliminó satisfactoriamente",
                      );
                    } else {
                      showErrorAlert("No se puedo eliminar el Contacto");
                    }
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ContactPage(contact: contactsList[index]),
                  ),
                );
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(contactsList[index]['name']),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
