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
  // Controladores para los campos de texto
    final TextEditingController urlController = TextEditingController();
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

  @override 
  void initState () {
    super.initState();
    _loadCredentialsUser();
  }

  void _loadCredentialsUser() async {
    final appData = Provider.of<SaveCredentials>(context, listen: false);
    Map<String, String> credentials = await appData.loadCredentials();
    setState(() {
      urlController.text = credentials['url'] ?? '';
      userController.text = credentials['username'] ?? '';
    });
  }

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
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

    void _saveFile() {
      final appData = Provider.of<SaveCredentials>(context, listen: false);
      appData.saveUserCredentials(
        urlController.text,
        userController.text,
      );
    }


    return ListView(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            double paddingHorizontal = constraints.maxWidth * 0.3;
            double verticalPadding = 25.0;

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: verticalPadding),
                child: TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.5),
                    ),
                    hintText: 'URL Servidor',
                  ),
                ),
              ),
            );
          },
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            double paddingHorizontal = constraints.maxWidth * 0.3;
            double verticalPadding = 25.0;

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: verticalPadding),
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
            );
          },
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            double paddingHorizontal = constraints.maxWidth * 0.3;
            double verticalPadding = 25.0;

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: verticalPadding),
                child: TextFormField(
                  controller: passwordController,
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
                ),
              ),
            );
          },
        ),
        Center(
          child: IconButton(
            iconSize: 60,
            icon: const Icon(Icons.arrow_forward_outlined),
            onPressed: () => {_showSnackBar(message: "Usuario guardado correctamente"), _saveFile()},
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
