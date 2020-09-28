import 'package:flutter/material.dart';

// class NoSplashFactory extends InteractiveInkFeatureFactory {
//   const NoSplashFactory();

//   InteractiveInkFeature create({
//     MaterialInkController controller,
//     RenderBox referenceBox,
//     Offset position,
//     Color color,
//     TextDirection textDirection,
//     bool containedInkWell = false,
//     Rect Function() rectCallback,
//     BorderRadius borderRadius,
//     ShapeBorder customBorder,
//     double radius,
//     VoidCallback onRemoved,
//   }) {
//     return NoSplashFeature(
//       controller: controller,
//       referenceBox: referenceBox,
//     );
//   }
// }

// class NoSplashFeature extends InteractiveInkFeature {
//   NoSplashFeature({
//     @required MaterialInkController controller,
//     @required RenderBox referenceBox,
//   })  : assert(controller != null),
//         assert(referenceBox != null),
//         super(
//           controller: controller,
//           referenceBox: referenceBox,
//         );

//   @override
//   void paintFeature(Canvas canvas, Matrix4 transform) {}
// }

class NoSplash extends StatelessWidget {
  NoSplash({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: child);
  }
}
