import 'dart:async';

import 'package:flutter/material.dart';

class SosMarker extends StatefulWidget {
  const SosMarker({Key? key}) : super(key: key);

  @override
  _SosMarkerState createState() => _SosMarkerState();
}

class _SosMarkerState extends State<SosMarker> {
  double _circleWidth = 30;
  double _circleHeight = 30;

  Timer? timer;
  Duration growingDuration = const Duration(seconds: 3);

  @override
  void initState() {
    timer = Timer.periodic(growingDuration, (Timer t) => growCircle());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void growCircle() {
    setState(() {
      _circleWidth = 30;
      _circleHeight = 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: growingDuration,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.red, width: 1),
        shape: BoxShape.circle,
      ),
      constraints:
          BoxConstraints.expand(width: _circleWidth, height: _circleHeight),
      // child: Container(
      //   decoration: const BoxDecoration(
      //     color: Colors.red,
      //     shape: BoxShape.circle,
      //   ),
      //   constraints: const BoxConstraints.expand(width: 10, height: 10),
      // )
    );
  }
}
