import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_project_textbox_scanner_infrared/component/bottom_sheet_component.dart';
import 'package:mini_project_textbox_scanner_infrared/component/scan_barcode_component.dart';
import 'package:mini_project_textbox_scanner_infrared/page/home_page.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/widget_styles.dart';

///
/// Created by Handy on 23/03/24
/// Macbook Air M2 - 2022
/// it.handy@borwita.co.id / it.handy
///

class MainPage extends StatefulWidget {

  final String title ;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MediumButton(
                title: 'Scan Barcode [Single Page]',
                onPressed: () async {
                  // Menunggu hasil dari aktivitas kedua
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'Validasi Scan'),
                    ),
                  );

                  if (result != null) {
                    Fluttertoast.showToast(
                        msg: "Result - Scan Barcode [Single Page] : $result}",
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
              ),

              const SizedBox(height: 15),

              MediumButton(
                title: 'Scan Barcode [Bottom Sheet / Modal]',
                onPressed: () async {
                  String? result = await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusCorner),
                    ),
                    backgroundColor: Colors.white,
                    builder: (context) => const BottomSheetComponent(
                        title: 'Validasi Scan',
                        content: ScanBarcodeComponent()
                    ),
                  );

                  if (result != null) {
                    Fluttertoast.showToast(
                        msg: "Result - Scan Barcode [Bottom Sheet / Modal] : $result",
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}
