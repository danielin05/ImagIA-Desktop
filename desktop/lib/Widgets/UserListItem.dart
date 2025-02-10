import 'package:desktop/Utils/ServerUtils.dart';
import 'package:desktop/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desktop/Providers/UserProvider.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;
  final List<String> planList = ['Free', 'Premium'];

  UserListItem({
    required this.user,
    super.key
  });

  // Displays a dialog with a select to change the plan, buttons: Cancel, Save
  void _changePlan(BuildContext context, UserModel user) {
    String? selectedPlan = user.plan;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Plan'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container (
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      value: selectedPlan,
                      hint: Text('Select a plan'),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPlan = newValue;
                        });
                      },
                      items: planList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: selectedPlan != null ? () async {
                // Handle saving the selected plan
                print('Selected plan: $selectedPlan');
                final result = await ServerUtils.changePlan(user.id, selectedPlan!);
                if (result.$1) {
                  print('Plan changed successfully');
                  Provider.of<UserProvider>(context, listen: false).loadUsers();
                } else {
                  print('Error changing plan: ${result.$2}');
                }
                // TODO: Save the selected plan
                Navigator.pop(context, selectedPlan);
              } : null,
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Displays a dialog with a TextField to change the plan, buttons: Cancel, Save
void _changeQuota(BuildContext context, UserModel user) {
  // Ensure the initial quota value is an integer (or null if it's not valid)
  TextEditingController controlador = TextEditingController(text: user.quota?.toString() ?? '');

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change Quota'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controlador,
                    keyboardType: TextInputType.number,  // Restrict input to numbers
                    decoration: InputDecoration(
                      labelText: 'Enter a Quota',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            onPressed: controlador.text != null
                ? () async {
                    // Handle saving the selected quota
                    print('Selected quota: ${controlador.text}');
                    final result = await ServerUtils.changeQuota(user.id, controlador.text!);
                    if (result.$1) {
                      print('Quota changed successfully');
                      Provider.of<UserProvider>(context, listen: false).loadUsers();
                    } else {
                      print('Error changing quota: ${result.$2}');
                    }
                    // TODO: Save the selected quota
                    Navigator.pop(context, controlador.text);
                  }
                : null,
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      title: Container(
        padding: const EdgeInsets.all(8),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        // Wrap the Row in a SingleChildScrollView
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 48, // Account for padding
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Text(
                        user.id.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 200,
                      child: Text(
                        user.nickname,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 350,
                      child: Text(
                        "Email: ${user.email}",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 350,
                      child: Text(
                        "Plan: ${user.plan}",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () => _changePlan(context, user),
                  child: const Text(
                    'Edit Plan',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                TextButton(
                  onPressed: () => _changeQuota(context, user),
                  child: const Text(
                    'Edit Quota',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
