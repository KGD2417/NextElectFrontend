import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:next_elect/providers/auth_provider.dart';
import 'package:next_elect/providers/election_provider.dart';
import 'package:next_elect/screens/auth/login_screen.dart';
import 'package:next_elect/screens/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ElectionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voting System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isAuthenticated ? const HomeScreen() :  LoginScreen();
        },
      ),


































      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}