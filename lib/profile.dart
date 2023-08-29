import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RoundedTextBox(),
        )));
  }
}

//"https://intelligentcounter-29709-default-rtdb.europe-west1.firebasedatabase.app/qMPDfwFAnVN5J2lSmOwdfUhg20z2"
getData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/values/');
  DatabaseEvent event = await ref.once();
  String data = event.snapshot.value as String;

  debugPrint(data);

  return data;
}

// ignore: must_be_immutable, use_key_in_widget_constructors
class RoundedTextBox extends StatelessWidget {
  String data = "IMPORTED_VALUE";
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
                fontSize: 40,
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
          data,
          style: const TextStyle(
            fontSize: 40,
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
                fontSize: 40,
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
          "+$data",
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Customize the text color here
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(100.0),
        child: FilledButton(
            onPressed: () async {
              data = getData();
            },
            child: const Text("Update")),
      )
    ])));
  }
}
