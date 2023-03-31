import 'package:flutter/material.dart';

// ["483123","D9DFD0","785B47","FADFA9","F5CE9C"]
Color darkColor = const Color(0xFF482123);
Color lightColor = const Color(0xFFD9DFD0);
Color semiDarkColor = const Color(0xFF785B47);
Color accentLightColor = const Color(0xFFFADFA9);
// Color accentColor = const Color(0xFFF5CE9C);
Color accentColor = const Color(0xFFffb703);

Future goToPage(BuildContext context, Widget destination,
    {bool clearStack = false}) {
  if (clearStack) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination), (route) => false);
  }
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

getHeight(context) => MediaQuery.of(context).size.height;
getWidth(context) => MediaQuery.of(context).size.width;
