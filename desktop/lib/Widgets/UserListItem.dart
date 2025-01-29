import 'package:desktop/model/userModel.dart';
import 'package:flutter/material.dart';

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
              onPressed: selectedPlan != null ? () {
                // Handle saving the selected plan
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),  // Padding inside the tile
      title: Container(
        padding: const EdgeInsets.all(8),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,  // Background color for the container
          borderRadius: BorderRadius.circular(8),  // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2), // Shadow direction
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Space between elements
          children: [
            SizedBox (
              width: 30,
              child: Text(
                user.id.toString(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(
                user.nickname,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 350,
              child: Text(
                "Email: ${user.email}",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () => _changePlan(context, user),
              child: const Text(
                'Edit Plan',
                style: TextStyle(color: Colors.blueAccent),  // Text color for the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
