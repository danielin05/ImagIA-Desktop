import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'saveCredentials.dart';

void main() {  
  runApp(
    ChangeNotifierProvider(
      create: (context) => SaveCredentials(),
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

class PaginaLogIn extends StatefulWidget {
  const PaginaLogIn({super.key});

  @override
  _PaginaLogInState createState() => _PaginaLogInState();
}

class _PaginaLogInState extends State<PaginaLogIn> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showSnackBar({
    required String message,
    SnackBarAction? action,
    int duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Center(
          child: Text(
            message, 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        action: action,
        duration: Duration(seconds: duration),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Controladores para los campos de texto
    final TextEditingController urlController = TextEditingController();
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void _saveFile() {
      final appData = Provider.of<SaveCredentials>(context, listen: false);
      appData.saveUserCredentials(
        urlController.text,
        userController.text,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 25),
            child: TextField(
<<<<<<< Updated upstream
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5),
                ),
=======
              controller: urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
>>>>>>> Stashed changes
                hintText: 'URL Servidor',
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 25),
            child: TextFormField(
              controller: userController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5),
                ),
                labelText: 'Usuario',
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 25),
            child: TextFormField(
<<<<<<< Updated upstream
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5),
                ),
=======
              controller: passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
>>>>>>> Stashed changes
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              obscureText: _obscureText,
              onChanged: (value) {
                Future.delayed(const Duration(seconds: 1), () {
                  if (mounted) {
                    setState(() {
                      _obscureText = true;
                    });
                  }
                });
              },
            ),
          ),
        ),
        Center(
<<<<<<< Updated upstream
          child: IconButton(
            iconSize: 60,
            icon: const Icon(Icons.arrow_forward_outlined),
            onPressed: () => {_showSnackBar(message: "Usuario guardado correctamente")},
            color: Colors.blue,
=======
          child: ElevatedButton(
            onPressed: _saveFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white, 
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text('Iniciar Sesión'),
>>>>>>> Stashed changes
          ),
        ),
      ],
    );
  }
}
