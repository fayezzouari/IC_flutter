import 'package:flutter/material.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intelligent Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data = "Hello";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("INTELLIGENT COUNTER.",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 50)),
          const SizedBox(
            height: 150,
          ),
          const Text("Login to get access to your informations :",
              style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: 350,
              child: TextFormField(
                  decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.person),
                hintText: 'Username',
              ))),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
              width: 350,
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    prefixIcon: Icon(Icons.security)),
                obscureText: true,
              )),
          const SizedBox(
            height: 50,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
      ),
    ));
  }
}
