import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  DocumentReference user = FirebaseFirestore.instance
      .collection('Users')
      .doc('6CLOVMQxOUHoVyI7FSEi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // user.update({
          //   "name": "JD",
          //   "email": "jd1@gmail.com",
          // });
          users.doc('1').set({
            "name": "lalit",
          });
        },
        child: Text('Add'),
      ),
      body: FutureBuilder(
        future: user.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data['name']}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ],
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
