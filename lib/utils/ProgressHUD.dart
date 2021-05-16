import 'package:flutter/material.dart';

import 'ImageLoader.dart';

class ProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  ProgressHUD({
    required this.inAsyncCall,
    this.color = Colors.white,
    this.progressIndicator = indicator,
    this.offset,
    this.dismissible = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var _stackChild = <Widget>[];
    var _opacity = SizedBox(
      width: 100,
      height: 100,
      child: Opacity(
        child: ModalBarrier(dismissible: dismissible, color: color),
        opacity: 0.3,
      ),
    );
    _stackChild.add(_opacity);

    Widget layOutProgressIndicator;
    if (inAsyncCall) {
      if (offset == null)
        layOutProgressIndicator = Center(child: progressIndicator);
      else {
        layOutProgressIndicator = Positioned(
          child: progressIndicator,
          left: offset!.dx,
          top: offset!.dy,
        );
      }
      _stackChild.add(layOutProgressIndicator);
    }

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 1500),
      firstChild: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
      secondChild: Stack(
        children: _stackChild,
      ),
      crossFadeState:
          inAsyncCall ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
