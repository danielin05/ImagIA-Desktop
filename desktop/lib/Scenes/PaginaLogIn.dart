import 'package:desktop/Providers/CredentialsProvider.dart';
import 'package:desktop/Providers/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desktop/Providers/SaveCredentials.dart';
import 'UserListScene.dart';
import 'package:desktop/Widgets/ResponsiveTextField.dart';

class PaginaLogIn extends StatefulWidget {
  const PaginaLogIn({super.key});

  @override
  _PaginaLogInState createState() => _PaginaLogInState();
}

class _PaginaLogInState extends State<PaginaLogIn> {
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
    final credentials = Provider.of<CredentialsProvider>(context, listen: false);
    await credentials.loadInitialCredentials();
    if (credentials.apiKey != '') {
      _goToUserList();
    }
    setState(() {
      urlController.text = credentials.url;
      userController.text = credentials.username;
      passwordController.text = '';
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

  void _saveFile() {
    Provider.of<CredentialsProvider>(context, listen: false).updateCredentials(
      urlController.text,
      userController.text,
      ''
    );
  }

  void _saveApiKey(String apiKey) {
    Provider.of<CredentialsProvider>(context, listen: false).updateCredentials(
      urlController.text,
      userController.text,
      apiKey
    );
  }

  void _goToUserList() {
    print("Go to user list");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListScene()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ResponsiveTextField(controller: urlController, text:  "URL Servidor", underLine: false),
        ResponsiveTextField(controller: userController, text:  "Usuario", underLine: true),
        ResponsiveTextField(controller: passwordController, text: "Contraseña", underLine: true, hidable: true),
        Center(
          child: Consumer<LoginProvider>(
            builder: (context, loginProvider, child) {
              if (loginProvider.isLoading) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                iconSize: 60,
                icon: const Icon(Icons.arrow_forward_outlined),
                color: loginProvider.isLoading ? Colors.grey : Colors.blue,
                onPressed: () async {
                    _saveFile();

                    final url = urlController.text;
                    final username = userController.text;
                    final password = passwordController.text;

                    // Call login method in the provider
                    await context.read<LoginProvider>().login(url, username, password);

                    if (loginProvider.apiKey != null) {
                      print("loginpage ${loginProvider.apiKey}");
                      _saveApiKey(loginProvider.apiKey!);
                      _goToUserList();
                    } else {
                      // Show error if login fails
                      _showSnackBar(message: "Error al iniciar sesión: ${loginProvider.errorMessage}");
                    }
                  },
              );
            },
          ),
        ),
      ],
    );
  }
}
