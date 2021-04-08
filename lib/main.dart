import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_drawing_app/drawing_board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter drawing app', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum Tool { pencil, eraser, line, rectangle }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Color pickerColor;
  Color currentColor;
  AnimationController _animationController;
  Animation<double> _animation;
  Tool selectedTool = Tool.pencil;

  final _bubbleTextStyle = TextStyle(fontSize: 16, color: Colors.white);

  @override
  void initState() {
    pickerColor = Colors.black;
    currentColor = Colors.black;

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 260));
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter drawing app'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.palette,
              color: currentColor,
              size: 30,
            ),
            onPressed: _presentColorPicker,
          )
        ],
      ),
      body: DrawingBoard(currentColor, selectedTool),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
                title: "Pencil",
                titleStyle: _bubbleTextStyle,
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.mode_edit,
                onPress: () {
                  _animationController.reverse();
                  setState(() {
                    selectedTool = Tool.pencil;
                  });
                }),
            Bubble(
                title: "Eraser",
                titleStyle: _bubbleTextStyle,
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.format_paint,
                onPress: () {
                  _animationController.reverse();
                  setState(() {
                    selectedTool = Tool.eraser;
                  });
                }),
            Bubble(
                title: "Line",
                titleStyle: _bubbleTextStyle,
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.border_color,
                onPress: () {
                  _animationController.reverse();
                  setState(() {
                    selectedTool = Tool.line;
                  });
                }),
            Bubble(
                title: "Rectangle",
                titleStyle: _bubbleTextStyle,
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.crop_16_9,
                onPress: () {
                  _animationController.reverse();
                  setState(() {
                    selectedTool = Tool.rectangle;
                  });
                }),
          ],
          onPress: _animationController.isCompleted
              ? _animationController.reverse
              : _animationController.forward,
          iconColor: Colors.blue,
          backGroundColor: Colors.white,
          animation: _animation,
          iconData: _iconDataForTool(selectedTool)),
    );
  }

  IconData _iconDataForTool(Tool tool) {
    switch (tool) {
      case Tool.pencil:
        return Icons.mode_edit;
      case Tool.eraser:
        return Icons.format_paint;
      case Tool.line:
        return Icons.border_color;
      case Tool.rectangle:
        return Icons.crop_16_9;
      default:
        return Icons.list;
    }
  }

  void _presentColorPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text('Pick a color'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: _pickColor,
                    showLabel: true,
                    pickerAreaHeightPercent: 0.8,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Done'),
                      onPressed: () {
                        setState(() => currentColor = pickerColor);
                        Navigator.of(context).pop();
                      })
                ]));
  }

  void _pickColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }
}
