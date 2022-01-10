import 'dart:io';
import 'dart:math';

import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MemeCreatorScreen extends StatefulWidget {
  const MemeCreatorScreen({Key? key}) : super(key: key);

  @override
  _MemeCreatorScreenState createState() => _MemeCreatorScreenState();
}

class _MemeCreatorScreenState extends State<MemeCreatorScreen> {

  final random = Random();
  List<TextGestureWidget> textGestureWidgetList = [];
  TextEditingController myController = TextEditingController();
  Offset offset = Offset.zero;
  List<Color> backgroundColor = [Colors.redAccent, Colors.pinkAccent];

  List<List<Color>> colorsArray = [
    [Colors.redAccent, Colors.pinkAccent],
    [Colors.blue, Colors.lightBlueAccent],
    [Colors.yellowAccent, Colors.yellow],
    [Colors.green, Colors.lightGreen],
    [Colors.tealAccent, Colors.teal]
  ];
  File? image;

  List<Color> getRandomColor() {
    return colorsArray[random.nextInt(colorsArray.length)];
  }

  void setRandomLinearGradientColor() {
    setState(() {
      backgroundColor = getRandomColor();
    });
  }

  void onAddTextClicked() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              width: double.maxFinite,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: myController,
                style: const TextStyle(
                  fontSize: 40.0,
                ),
                decoration: const InputDecoration(
                  hintText: "type here",
                  border: InputBorder.none,
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: addTextOnCanvas,
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  void addTextOnCanvas() {
    textGestureWidgetList
        .add(TextGestureWidget(text: myController.text, image: File("")));
    setState(() {});
    myController.clear();
    Navigator.pop(context, 'OK');
  }

  void showBottomModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0x00ffffff),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: Column(
                  children:
                  const [
                    Text(Emojis.man),
                  ],
                )),
          );
        });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 100,
          maxWidth: 100,
          imageQuality: 100);
      if (image == null) return;
      final imageTemp = File(image.path);
      textGestureWidgetList
          .add(TextGestureWidget(text: myController.text, image: imageTemp));
      setState(() {});
    } on PlatformException {
      // print("failed to pick image: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    List<Emoji> emList = Emoji.all();
    List<Text> textEmojiList = [];
    Iterable emojiIterable = emList.map((e) => print(e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meme Lord",
      home: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: backgroundColor)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onAddTextClicked,
                        tooltip: "text",
                        icon: const Icon(Icons.text_format_outlined,
                            color: Colors.white),
                        iconSize: 32.0,
                      ),
                      IconButton(
                        onPressed: showBottomModal,
                        tooltip: "emoji",
                        icon: const Icon(Icons.emoji_emotions, color: Colors.white),
                        iconSize: 30.0,
                      ),
                      const IconButton(
                        onPressed: null,
                        tooltip: "draw",
                        icon: Icon(Icons.edit, color: Colors.white),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.maxFinite,
                    height: (MediaQuery.of(context).size.height - 124),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: backgroundColor)),
                    child: Center(
                      child: Stack(
                        children: textGestureWidgetList,
                        // children: [
                        //   image == null
                        //       ? const FlutterLogo(size: 150)
                        //       : Image.file(image!)
                        // ],
                      ),
                    )),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: backgroundColor)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: setRandomLinearGradientColor,
                        tooltip: "change background color",
                        icon: const Icon(Icons.palette, color: Colors.white),
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: pickImage,
                        tooltip: "import image",
                        icon: const Icon(Icons.image_rounded, color: Colors.white),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class TextGestureWidget extends StatefulWidget {
  final String text;
  final File image;

  const TextGestureWidget({Key? key, required this.text, required this.image})
      : super(key: key);

  @override
  _TextGestureWidgetState createState() => _TextGestureWidgetState();
}

// https://stackoverflow.com/questions/57971875/how-to-add-a-draggable-textfield-to-add-text-over-images-in-flutter

class _TextGestureWidgetState extends State<TextGestureWidget> {
  double _scaleFactor = 1;
  double _baseScaleFactor = 2;

  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _sessionOffset = Offset.zero;

  double _angle = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: (_offset + _sessionOffset).dx,
        top: (_offset + _sessionOffset).dy,
        child: GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            _baseScaleFactor = _scaleFactor;
            _initialFocalPoint = details.focalPoint;
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              _scaleFactor = _baseScaleFactor * details.scale;
              _sessionOffset = details.focalPoint - _initialFocalPoint;
              _angle = details.rotation;
            });
            // print("Scale Factor: $_scaleFactor");
          },
          onScaleEnd: (details) {
            setState(() {
              _offset += _sessionOffset;
              _sessionOffset = Offset.zero;
            });
          },
          child: Transform.rotate(
              angle: _angle,
              child: widget.image.path == ""
                  ? Text(
                widget.text,
                textScaleFactor: _scaleFactor,
                style: const TextStyle(color: Colors.white),
              )
                  : Image.file(widget.image)),
        ));
  }
}