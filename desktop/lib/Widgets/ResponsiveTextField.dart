import 'package:flutter/material.dart';

class ResponsiveTextField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool underLine;
  final bool hidable;

  const ResponsiveTextField({
    Key? key,
    required this.controller,
    required this.text,
    required this.underLine,
    this.hidable = false,
  }) : super(key: key);

  @override
  State<ResponsiveTextField> createState() => _ResponsiveTextFieldState();
}

class _ResponsiveTextFieldState extends State<ResponsiveTextField> {
  bool obscureText = false; 

  void _toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingHorizontal = constraints.maxWidth * 0.3;
        double verticalPadding = 25.0;

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: verticalPadding),
            child: TextFormField(
              controller: widget.controller,
              decoration: widget.underLine ?
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
                labelText: widget.text,
                suffixIcon: widget.hidable ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: _toggleVisibility,
                ) : null,
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
                labelText: widget.text,
                suffixIcon: widget.hidable ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: _toggleVisibility,
                ) : null,
              ),
              obscureText: obscureText,
            ),
          ),
        );
      },
    );
  }
}
