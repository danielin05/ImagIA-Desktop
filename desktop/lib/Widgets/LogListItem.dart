import 'package:flutter/material.dart';

class LogListItem extends StatelessWidget {
  final String message;
  final String tag;
  final DateTime time;

  const LogListItem({
    super.key,
    required this.message,
    required this.tag,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                ),
                const SizedBox(height: 4),
                Text(
                  "Tag: $tag",
                ),
              ],
            ),
          ),
          Text(
            _formatTime(time),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return time.toString().substring(0, 16);
  }
}