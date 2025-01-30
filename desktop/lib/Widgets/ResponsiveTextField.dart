import 'package:flutter/material.dart';

class ResponsiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool underLine;

  const ResponsiveTextField({
    Key? key,
     required this.controller,
     required this.text,
     required this.underLine,
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingHorizontal = constraints.maxWidth * 0.3;
        double verticalPadding = 25.0;

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: verticalPadding),
            child: TextField(
              controller: controller,
              decoration: underLine ? 
              InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5),
                ),
                labelText: text,
              )
              : InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.5),
                ),
                labelText: text,
              ),
            ),
          ),
        );
      },
    );
  }
}
