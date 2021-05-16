import 'package:flutter/material.dart';

class BodyPage extends StatelessWidget {
  static const String routeName = '/web/body';

  BodyPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

}
