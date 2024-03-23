import 'package:flutter/material.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/color_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/font_styles.dart';
import 'package:mini_project_textbox_scanner_infrared/styles/widget_styles.dart';

class DialogManager {
  DialogManager._privateConstructor();

  static final DialogManager _instance = DialogManager._privateConstructor();

  static BuildContext? _context;

  factory DialogManager(BuildContext context) {
    _context = context;
    return _instance;
  }

  AlertDialog createAlertDialog(
      {required Widget content, required List<Widget> actions}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: content,
      actions: actions,
    );
  }

  Future<void> showLoadingPopup(String message) async {
    await showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (context) => LoadingPopup(message: message),
    );
  }

  void hideLoadingPopup() async {
    Navigator.pop(_context!);
  }

  Future<void> showCustomDialog({
    required String title,
    required String message,
    required String primaryText,
    String? image,
    Widget? descriptionWidget,
    bool isMultiButton = false,
    String secondaryText = '-',
    VoidCallback? onPrimaryPressedMulti,
    VoidCallback? onSecondaryPressedMulti,
    bool isBarrierDisable = false,
  }) {
    return showDialog(
      context: _context!,
      barrierDismissible: isBarrierDisable,
      builder: (context) =>
          CustomDialogBox(
            title: title,
            description: message,
            primaryText: primaryText,
            secondaryText: secondaryText,
            img: image,
            descriptionWidget: descriptionWidget,
            isMultiButton: onSecondaryPressedMulti != null ? true : false,
            onPrimaryPressedMulti: onPrimaryPressedMulti,
            onSecondaryPressedMulti: onSecondaryPressedMulti,
          ),
    );
  }

  Future<void> serverAccessUnavailableDialog({Function()? onPrimaryClick}) {
    return showCustomDialog(
      title: "Status Server",
      message: 'Gagal terhubung dengan web SFA KAI. Silakan coba lagi',
      primaryText: "Coba Lagi",
      secondaryText: "Tutup",
      onPrimaryPressedMulti: onPrimaryClick,
      onSecondaryPressedMulti: () async {
        Navigator.pop(_context!);
      },
    );
  }
}

class CustomDialogBox extends StatefulWidget {
  final String title, description, primaryText;
  final VoidCallback? onPrimaryPressedMulti;
  final VoidCallback? onSecondaryPressedMulti;
  final String? img;
  final Widget? descriptionWidget;
  final bool isMultiButton;
  final String secondaryText;

  const CustomDialogBox({Key? key,
    required this.title,
    required this.description,
    required this.primaryText,
    required this.img,
    this.isMultiButton = false,
    this.secondaryText = '-',
    this.onPrimaryPressedMulti,
    this.descriptionWidget,
    this.onSecondaryPressedMulti})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.only(
          left: 5, top: widget.img != null ? 65 : 20, right: 5, bottom: 20),
      margin: const EdgeInsets.only(top: 45),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.title,
              style: kBodyRegular14.copyWith(
                fontSize: 18,
                letterSpacing: 0.25,
                color: Colors.black,
              )),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: widget.descriptionWidget ?? Text(
              widget.description,
              textAlign: TextAlign.center,
              style: kBodyRegular14.copyWith(
                letterSpacing: 0.15,
              ),
            ),
          ),
          const SizedBox(height: 26),
          widget.isMultiButton
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: MediumOutlineButton(
                  title: widget.secondaryText,
                  onPressed: widget.onSecondaryPressedMulti,
                  width: 120,
                ),
              ),
              const SizedBox(
                width: 7.5,
              ),
              Align(
                alignment: Alignment.center,
                child: MediumButton(
                  title: widget.primaryText,
                  onPressed: widget.onPrimaryPressedMulti,
                  width: 120,
                ),
              ),
            ],
          )
              : Align(
            alignment: Alignment.center,
            child: MediumButton(
              title: widget.primaryText,
              onPressed: widget.onPrimaryPressedMulti,
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingPopup extends StatefulWidget {
  final String message;

  const LoadingPopup({super.key, required this.message});

  @override
  _LoadingPopupState createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: kBlueDark,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                widget.message,
                style: kBodyRegular12.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicRichText extends StatelessWidget {
  final String prefix;
  final String boldText;
  final String suffix;

  const DynamicRichText(this.prefix, this.boldText, this.suffix);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kBodyBold16.copyWith(
          letterSpacing: 0.15,
        ),
        children: <TextSpan>[
          TextSpan(
              text: prefix
          ),
          TextSpan(
            text: boldText,
            style: kBodyBold14.copyWith(color: kBlackColor),
          ),
          TextSpan(
              text: suffix
          ),
        ],
      ),
    );
  }
}
