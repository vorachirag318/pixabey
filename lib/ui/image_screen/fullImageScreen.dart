import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:pixabay/ui/image_screen/imageListScreen.dart';

class FullImageScreen extends StatelessWidget {
  static const String routeName = "/fullImageScreen";
  @override
  Widget build(BuildContext context) {
    String image = Get.arguments;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: ZoomableWidget(child: networkImageShow(image)),
          ),
          Positioned(
            top: 30,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.keyboard_backspace),
            ),
          )
        ],
      ),
    );
  }
}

class ZoomableWidget extends StatefulWidget {
  final Widget child;

  const ZoomableWidget({Key? key, required this.child}) : super(key: key);
  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          matrix = zerada;
        });
      },
      child: MatrixGestureDetector(
        shouldRotate: false,
        onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
          setState(() {
            matrix = m;
          });
        },
        child: Transform(
          transform: matrix,
          child: widget.child,
        ),
      ),
    );
  }
}
