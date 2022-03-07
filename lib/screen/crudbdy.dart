import 'dart:ui';

import 'package:crudy/database/database.dart';
import 'package:crudy/model/contact.dart';
import 'package:flutter/material.dart';

class CrudBdy extends StatefulWidget {
  const CrudBdy({Key? key}) : super(key: key);

  @override
  _CrudBdyState createState() => _CrudBdyState();
}

class _CrudBdyState extends State<CrudBdy> {
  String title = 'Cruddy';
  final Contact contact = Contact(name: '', mobile: '');
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  final _mobileCont = TextEditingController();
  late DatabaseHelper db;

  @override
  void initState() {
    db = DatabaseHelper.instance;
    super.initState();

    getData();
  }

  void getData() async {
    await db.getContacts();
  }

  void resetData() {
    _nameCont.clear();
    _mobileCont.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: title,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  )),
                  const TextSpan(
                    text: '😁',
                    style: TextStyle(
                      fontSize: 20,
                      
                      
                    )
                  )
                  ],),),
            TextFormField(
              controller: _nameCont,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Field is Required.';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.perm_identity_rounded)),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _mobileCont,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Field is Required.';
                } else if (val.length <= 9) {
                  return 'Characters must be at least 9. ';
                }

                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Mobile',
                  prefixIcon: Icon(Icons.mobile_friendly_rounded)),
            ),
            SizedBox(height: 20),
            submit(),
            SizedBox(height: 20),
            list()
          ]),
        ),
      ),
    );
  }

  Widget submit() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (contact.id == null) {
              await db.addContact(
                  Contact(name: _nameCont.text, mobile: _mobileCont.text));
              resetData();
            } else {
              await db.updateContact(Contact(
                  id: contact.id,
                  name: _nameCont.text,
                  mobile: _mobileCont.text));
              resetData();
            }
          }
          setState(() {
            getData();
          });
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.greenAccent,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Add Contacts'),
          )),
        ));
  }

  list() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: FutureBuilder<List<Contact>>(
          future: DatabaseHelper.instance.getContacts(),
          builder: ((BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('No data on the list'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      final x = snapshot.data![index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              x.name,
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ),
                            subtitle: Text(
                              x.mobile,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () async {
                                          // for updating

                                          setState(() {
                                            contact.id = x.id;
                                            _nameCont.text = x.name;
                                            _mobileCont.text = x.mobile;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        )),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            DatabaseHelper.instance
                                                .removeContact(x.id!);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 5,
                            color: Colors.white60,
                          )
                        ],
                      );
                    }));
          })),
    );
  }
}
