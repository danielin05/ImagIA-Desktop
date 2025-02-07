import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/CredentialsProvider.dart';
import 'Providers/UserProvider.dart';
import 'Providers/LoginProvider.dart';
import 'Scenes/PaginaLogIn.dart';
import 'Providers/LogsProvider.dart';
import 'Providers/RequestsProvider.dart';

void main() {  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CredentialsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogsProvider(),
        ),
        ChangeNotifierProvider(create:
          (context) => RequestsProvider(),
        )
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
      title: 'IMAGIA DESKTOP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'IMAGIA DESKTOP',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const PaginaLogIn(),
      ),
    );
  }
}



/*

TODO:
-Use the new SaveCredentials Provider in the LoginS
-if an apiKey is found on start directly go to the usersScene
 if not go to the loginScene with saveCredentials on the textfields*/