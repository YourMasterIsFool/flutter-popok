import 'package:flutter/material.dart';

class WrapperLostFocuse extends StatefulWidget {
  const WrapperLostFocuse({super.key, required this.child});
  final Widget child;

  @override
  State<WrapperLostFocuse> createState() => _WrapperLostFocuseState();
}

class _WrapperLostFocuseState extends State<WrapperLostFocuse> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: widget.child,
    );
  }
}
