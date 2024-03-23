import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/color_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/dialog_manager.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/font_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/widget_styles.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:soundpool/soundpool.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textbox Barcode Scanner Infrared',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late MobileScannerController? _scannerController;

  final TextEditingController _textEditingController = TextEditingController();

  bool _isScanningDelayed = false;
  bool isScanCamera = true;
  late Soundpool _soundPool;
  late int _soundId;

  String? validationData;
  String? validationCaption;
  String action = 'Confirm';
  final FocusNode _focusNode = FocusNode();

  Timer? debounce;

  final Duration debounceDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionTimeoutMs: 500,
      detectionSpeed: DetectionSpeed.normal,
      torchEnabled: false,
    );
    Future.microtask(() async {
      _soundPool = Soundpool.fromOptions();
      final soundId = await rootBundle.load(
          'assets/sounds/qr_scanner_sound.mp3').then(
            (ByteData soundData) async => _soundPool.load(soundData),
      );
      _soundId = soundId;
    });

    validationCaption = 'Product Inward';
    validationData = '35;26;14;111';
  }

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
            children: [
              const SizedBox(height: 20),
              Expanded(
                flex: isScanCamera ? 2 : 0,
                child: _buildMobileScannerSection(context),
              ),
              const SizedBox(height: 33,),
              Expanded(
                  flex: 3,
                  child: _buildTextFieldResult(context)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileScannerSection(BuildContext context) {
    return Stack(
      children: [
        isScanCamera ? ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: MobileScanner(
            controller: _scannerController,
            onDetect: (capture) async {
              if (!_isScanningDelayed) {
                _isScanningDelayed = true;
                await _soundPool.play(_soundId);
                final barcode = capture.barcodes[0];
                if (barcode.rawValue == null) {
                  Fluttertoast.showToast(
                      msg: "Hasil scan barcode tidak ditemukan",
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                } else {
                  debugPrint('result_mobile_scanner: ${barcode.rawValue.toString()}');
                  _textEditingController.text = '';
                  _textEditingController.text = barcode.rawValue.toString();

                  // Cancel the previous timer
                  if (debounce != null) {
                    debounce!.cancel();
                  }

                  // Setup a new timer
                  debounce = Timer(debounceDuration, () {
                    checkValidationData(_textEditingController.text.toString());
                  });
                }
              }
            },
            errorBuilder: (context, exception, widget) {
              DialogManager(context).showCustomDialog(
                  title: "Terjadi Kesalahan",
                  message: 'Sepertinya kamera gagal memuat, silahkan coba lagi',
                  primaryText: "Tutup",
                  onPrimaryPressedMulti: () {
                    Navigator.pop(context);
                  });
              return widget ??
                  const Column(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.redAccent,
                        size: 48,
                      ),
                      SizedBox(height: 24),
                      Text('Coba lagi')
                    ],
                  );
            },
            placeholderBuilder: (context, widget) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            },
          ),
        ) : Image.asset(
          'assets/images/img_scan_barcode.png', width: double.maxFinite,
          height: 280,),
      ],
    );
  }

  Widget _buildTextFieldResult(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Scan Barcode',
            textAlign: TextAlign.center,
            style: kBodyRegular16.copyWith(
              color: kBlackColor,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            validationCaption ?? '-',
            textAlign: TextAlign.center,
            style: kBodyBold18.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: 30.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BarcodeKeyboardListener(
                  onBarcodeScanned: (barcode) {
                    _focusNode.requestFocus();
                    _textEditingController.text = '';
                    _textEditingController.text = barcode;
                  },
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                        focusNode: _focusNode,
                        autofocus: true,
                        controller: _textEditingController,
                        keyboardType: TextInputType.none,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          hintText: 'Result',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusCorner),
                            borderSide: const BorderSide(
                                color: kPrimary400, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusCorner),
                            borderSide: const BorderSide(
                                color: kGrayScale100, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusCorner),
                            borderSide: const BorderSide(
                                color: kGrayScale100, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusCorner),
                            borderSide: const BorderSide(
                                color: kDangerRed, width: 2.0),
                          ),
                        )
                    ),
                  )
              ),

              GestureDetector(
                onTap: () {
                  _focusNode.requestFocus();
                  _textEditingController.text = '';
                  setState(() {
                    isScanCamera = !isScanCamera;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kLineStroke),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/icon_scan.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkValidationData(String? result) {
    if (result != null) {
      List<String>? validationDataList = validationData?.split(';');
      bool isValidation = false;
      for (int index = 0; index < validationDataList!.length; index++) {
        if (validationDataList[index] == result) {
          isValidation = true;
        }
      }

      if (isValidation) {
        // _scannerController?.stop();
      } else {

      }
    }
  }
}
