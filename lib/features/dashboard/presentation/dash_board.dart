import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hallo World", style: TextStyle(fontSize: 40, color: Colors.black, decoration: TextDecoration.none),),
    );
  }
}
