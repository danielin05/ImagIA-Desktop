import 'package:desktop/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:desktop/model/userModel.dart';
import 'package:provider/provider.dart';
import 'package:desktop/Widgets/UserListItem.dart';
import 'package:desktop/Providers/LoginProvider.dart';

class UserListScene extends StatefulWidget {
  @override
  _UserListSceneState createState() => _UserListSceneState();
}

class _UserListSceneState extends State<UserListScene> {

  List<UserModel> users = [];
  late final String apiKey;

  @override
  void initState() {
    super.initState();
    // Carga los usuarios cuando la pantalla se inicia
    Provider.of<UserProvider>(context, listen: false).loadUsers();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Lista de Usuarios"),
    ),
    body: Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: userProvider.users.length,
          itemBuilder: (context, index) {
            return UserListItem(user: userProvider.users[index]);
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Provider.of<UserProvider>(context, listen: false).loadUsers(),
      child: const Icon(Icons.refresh, size: 36),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
  );
}
}