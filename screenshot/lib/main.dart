import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _screenshotController = ScreenshotController();
  bool lightTheme = true;
  // Color currentColor = Colors.limeAccent;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];
  // void changeColor(Color color) => setState(() => currentColor = color);
  // void changeColors(List<Color> colors) => setState(() => currentColors = colors);

// create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

// raise the [showDialog] widget
  addsubTopicDialog(context) {
    return showDialog(
        context: context,
        child: AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            // child: ColorPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            //   colorPickerWidth: 300.0,
            //   pickerAreaHeightPercent: 0.7,
            //   enableAlpha: true,
            //   displayThumbColor: true,
            //   showLabel: true,
            //   paletteType: PaletteType.hsv,
            //   pickerAreaBorderRadius: const BorderRadius.only(
            //     topLeft: const Radius.circular(2.0),
            //     topRight: const Radius.circular(2.0),
            //   ),
            // ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Screenshot(
            controller: _screenshotController,
            child: Card(
                // color: currentColor,
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  RaisedButton(
                    elevation: 3.0,
                    onPressed: () {
                      addsubTopicDialog(context);

                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       titlePadding: const EdgeInsets.all(0.0),
                      //       contentPadding: const EdgeInsets.all(0.0),
                      //       content: SingleChildScrollView(
                      //         child: ColorPicker(
                      //           pickerColor: currentColor,
                      //           onColorChanged: changeColor,
                      //           colorPickerWidth: 300.0,
                      //           pickerAreaHeightPercent: 0.7,
                      //           enableAlpha: true,
                      //           displayThumbColor: true,
                      //           showLabel: true,
                      //           paletteType: PaletteType.hsv,
                      //           pickerAreaBorderRadius: const BorderRadius.only(
                      //             topLeft: const Radius.circular(2.0),
                      //             topRight: const Radius.circular(2.0),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    child: const Text('Change color'),
                    color: currentColor,
                    textColor: useWhiteForeground(currentColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                  ),
                  Text(
                    'Code Passionatelyvdhdhvfukiufbugus',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ),
          TextButton(
            child: Text('Take Screenshot and Share'),
            onPressed: _takeScreenshot,
          )
        ]))));
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from #SexyFlutterApp");
  }

  void _saveScreenshot() async {
    final imageFile = await _screenshotController.capture();
    // Share.shareFiles([imageFile.path], text: "Shared from #SexyFlutterApp");
    ImageGallerySaver.saveFile(imageFile.path);
  }
}
