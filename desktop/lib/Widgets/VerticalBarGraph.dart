import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:desktop/model/BarGraphData.dart';
  
class VerticalBarGraph extends StatelessWidget {
  final BarGraphData data;
  final String xAxisName;
  final String yAxisName;
  final Color barColor;
  final double barWidth;
  final double padding;

  const VerticalBarGraph({
    Key? key,
    required this.data,
    required this.xAxisName,
    required this.yAxisName,
    this.barColor = Colors.blue,
    this.barWidth = 40,
    this.padding = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: EdgeInsets.all(padding),
          child: CustomPaint(
            painter: BarGraphPainter(
              data: data,
              xAxisName: xAxisName,
              yAxisName: yAxisName,
              barColor: barColor,
              barWidth: barWidth,
            ),
            size: Size(constraints.maxWidth, constraints.maxHeight),
          ),
        );
      },
    );
  }
}

class BarGraphPainter extends CustomPainter {
  final BarGraphData data;
  final String xAxisName;
  final String yAxisName;
  final Color barColor;
  final double barWidth;

  BarGraphPainter({
    required this.data,
    required this.xAxisName,
    required this.yAxisName,
    required this.barColor,
    required this.barWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    final axisPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw axes
    canvas.drawLine(
      Offset(40, size.height - 40),
      Offset(40, 20),
      axisPaint,
    ); // Y-axis
    canvas.drawLine(
      Offset(40, size.height - 40),
      Offset(size.width - 20, size.height - 40),
      axisPaint,
    ); // X-axis

    // Draw axis names
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // X-axis name
    textPainter.text = TextSpan(
      text: xAxisName,
      style: const TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width / 2, size.height - 20),
    );

    // Y-axis name
    canvas.save();
    canvas.translate(20, size.height / 2);
    canvas.rotate(-pi / 2);
    textPainter.text = TextSpan(
      text: yAxisName,
      style: const TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, 0),
    );
    canvas.restore();

    // Draw bars and labels
    final availableWidth = size.width - 60;
    final availableHeight = size.height - 60;
    final barSpacing = availableWidth / (data.values.length + 1);

    for (var i = 0; i < data.values.length; i++) {
      final x = 40 + barSpacing * (i + 1) - barWidth / 2;
      final barHeight = (data.values[i] / data.maxValue) * availableHeight;
      final y = size.height - 40 - barHeight;

      // Draw bar
      canvas.drawRect(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        paint,
      );

      // Draw value label
      textPainter.text = TextSpan(
        text: data.values[i].toString(),
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, y - 20),
      );

      // Draw x-axis label
      textPainter.text = TextSpan(
        text: data.labels[i],
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, size.height - 35),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
