import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intelligentcounter/main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: RoundedTextBox(),
        )));
  }
}

class RoundedTextBox extends StatefulWidget {
  const RoundedTextBox({super.key});

  @override
  State<RoundedTextBox> createState() => _RoundedTextBoxState();
}

class _RoundedTextBoxState extends State<RoundedTextBox> {
  String data_value = "IMPORTED_VALUE";
  String data_conso = "IMPORTED_VALUE";

  Future<String> getValue() async {
    Query ref = FirebaseDatabase.instance
        .ref('${FirebaseAuth.instance.currentUser!.uid}/values/')
        .orderByValue()
        .limitToLast(1);
    DatabaseEvent event = await ref.once();
    Map data = event.snapshot.value as Map;
    debugPrint(data.toString());
    return data[data.keys.first]["Value"];
  }

  Future<String> getConso() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${FirebaseAuth.instance.currentUser!.uid}/conso/Value');
    DatabaseEvent event = await ref.once();
    int data = event.snapshot.value as int;
    debugPrint(data.toString());
    return data.toString();
  }

  void updateData() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${FirebaseAuth.instance.currentUser!.uid}/activities');
    ref.update({
      "/isActive": true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Padding(
        padding: EdgeInsets.all(50.0),
        child: SizedBox(
          child: Text("Current Value",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              )),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(
              255, 125, 8, 141), // Customize the color here
        ),
        child: Text(
          data_value,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Customize the text color here
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(50.0),
        child: SizedBox(
          child: Text("Latest Increase",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              )),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(
              255, 125, 8, 141), // Customize the color here
        ),
        child: Text(
          data_conso,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Customize the text color here
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: FilledButton(
            onPressed: () async {
              updateData();
            },
            child: const Text("Capture")),
      ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: FilledButton(
            onPressed: () async {
              data_conso = await getConso();
              data_value = await getValue();
              setState(() {});
            },
            child: const Text("Update")),
      ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: FilledButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            child: const Text("Logout")),
      ),
    ])));
  }
}
