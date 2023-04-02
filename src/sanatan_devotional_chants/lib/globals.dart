import 'package:flutter/material.dart';

// Color darkColor = const Color(0xFF020202);
// Color lightColor = const Color(0xFF0d2818);
// Color semiDarkColor = const Color(0xFF04471c);
// Color accentLightColor = const Color(0xFF058c42);
// Color accentColor = const Color(0xFF16db65);


Color darkColor = const Color(0xFF370617);
Color lightColor = const Color(0xFF9d0208);
Color semiDarkColor = const Color(0xFF6a040f);
Color accentLightColor = const Color(0xFFd00000);
Color accentColor = const Color(0xFFf9a03f);

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
