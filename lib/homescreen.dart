import 'package:codersstatus/components/colorscheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'drawer.dart';
import 'dart:math';
import 'components/colorscheme.dart';

void main() => runApp(MaterialApp(home: homescreen(),));

class homescreen extends StatefulWidget {
  const homescreen({Key key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image(image: AssetImage('images/appiconnoback.png'),),),);
  }
}