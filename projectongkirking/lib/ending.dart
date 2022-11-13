import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ending extends StatefulWidget {
  const Ending({super.key});

  static const RouteName = "/jokowi";

  @override
  State<Ending> createState() => _EndingState();
}

class _EndingState extends State<Ending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Ending'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Puji Tuhan Tugasnya Selesai :)"),
      ),
    );
  }
}
