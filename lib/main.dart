import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intelligentcounter/validator.dart';
import 'firebase_options.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  final formLoginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: formLoginKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("INTELLIGENT COUNTER.",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 50)),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                    validator: validateEmail,
                    controller: emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username',
                    ))),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                  validator: validatePassword,
                  controller: passwordController,
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
                  if (formLoginKey.currentState!.validate()) {
                    loginUser();
                  }
                },
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    ));
  }

  void loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Profile()));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('There is no user with that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password.'),
          ),
        );
      } else if (e.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your internet connection.'),
          ),
        );
      } else {
        debugPrint(e.code);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Try again.'),
          ),
        );
      }
    }
  }
}
