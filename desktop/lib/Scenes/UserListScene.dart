import 'package:desktop/Providers/UserProvider.dart';
import 'package:desktop/Scenes/LogSearchScene.dart';
import 'package:flutter/material.dart';
import 'package:desktop/model/userModel.dart';
import 'package:provider/provider.dart';
import 'package:desktop/Widgets/UserListItem.dart';
import 'package:desktop/Scenes/RequestsGraphScene.dart';


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

  void _goToLogSearchScene() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogSearchScene()),
    );
  }

  void _goToRequestsGraphScene() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestsGraphScene()),
    );
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
      bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
        color: Colors.blueAccent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  SizedBox(
                    width: constraints.maxWidth > 900 ? constraints.maxWidth / 3 - 32 : 280,
                    child: TextButton.icon(
                      icon: const Icon(Icons.refresh, size: 50, color: Colors.white),
                      label: const Text(
                        "Recargar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () => Provider.of<UserProvider>(context, listen: false).loadUsers(),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth > 900 ? constraints.maxWidth / 3 - 32 : 280,
                    child: TextButton.icon(
                      icon: const Icon(Icons.filter_list, size: 50, color: Colors.white),
                      label: const Text(
                        "Buscar Logs",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        _goToLogSearchScene();
                      },
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth > 900 ? constraints.maxWidth / 3 - 32 : 280,
                    child: TextButton.icon(
                      icon: const Icon(Icons.table_chart, size: 50, color: Colors.white),
                      label: const Text(
                        "Peticiones esta hora",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        _goToRequestsGraphScene();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}