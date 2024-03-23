import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_project_textbox_scanner_infrared/component/scan_barcode_component.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/color_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/dialog_manager.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/font_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/widget_styles.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:soundpool/soundpool.dart';

///
/// Created by Handy on 23/03/24
/// Macbook Air M2 - 2022
/// it.handy@borwita.co.id / it.handy
///

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ScanBarcodeComponent(),
        ),
      ),
    );
  }

}

