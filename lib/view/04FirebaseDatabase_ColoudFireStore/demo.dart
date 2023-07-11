import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({
    Key? key,
    required this.userID,
  }) : super(key: key);
  final String userID;

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  DocumentReference? user;

  @override
  void initState() {
    user = FirebaseFirestore.instance.collection('user').doc(widget.userID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: user!.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data;
                  TextEditingController genderController =
                      TextEditingController(text: data!['gender']);
                  TextEditingController nameController =
                      TextEditingController(text: data['name']);
                  TextEditingController usernameController =
                      TextEditingController(text: data['username']);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name : ${data['name']}"),
                      Text("Gender : ${data['gender']}"),
                      Text("EmailId : ${data['emailId']}"),
                      Text("Username : ${data['username']}"),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    height: 300,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                              labelText: 'name'),
                                        ),
                                        TextField(
                                          controller: genderController,
                                          decoration: const InputDecoration(
                                              labelText: 'gender'),
                                        ),
                                        TextField(
                                          controller: usernameController,
                                          decoration: const InputDecoration(
                                              labelText: 'username'),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              user?.update({
                                                "name": nameController.text,
                                                "gender": genderController.text,
                                                "username":
                                                    usernameController.text
                                              });
                                            },
                                            child: const Text('Update')),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text("Edit")),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
