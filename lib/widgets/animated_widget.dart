// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// class AdvancedAnimatedWidget extends StatefulWidget {
//   const AdvancedAnimatedWidget({Key? key}) : super(key: key);

//   @override
//   _AdvancedAnimatedWidgetState createState() => _AdvancedAnimatedWidgetState();
// }

// class _AdvancedAnimatedWidgetState extends State<AdvancedAnimatedWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )..repeat();

//     _rotationAnimation = Tween<double>(
//       begin: 0,
//       end: 2 * math.pi,
//     ).animate(_controller);

//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 1.5,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       height: double.infinity,
//       color: Colors.blue[200],
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _scaleAnimation.value,
//             child: CustomPaint(
//               painter: CustomShapePainter(_rotationAnimation.value),
//               child: const Center(
//                 child: Text(
//                   'WhatsApp Poll',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CustomShapePainter extends CustomPainter {
//   final double angle;

//   CustomShapePainter(this.angle);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.blue[400]!
//       ..style = PaintingStyle.fill;

//     final double radius = size.width / 2;

//     final Path path = Path();
//     const double angleStep = 2 * math.pi / 6;
//     for (int i = 0; i < 6; i++) {
//       double x = radius * math.cos(i * angleStep + angle);
//       double y = radius * math.sin(i * angleStep + angle);
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();

//     canvas.translate(size.width / 2, size.height / 2);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
