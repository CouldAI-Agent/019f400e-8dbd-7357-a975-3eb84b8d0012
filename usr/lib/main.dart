import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const GoodImageApp());
}

class GoodImageApp extends StatelessWidget {
  const GoodImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DrawingScreen(),
      },
    );
  }
}

class DrawnLine {
  final List<Offset> path;
  final Color color;
  final double width;

  DrawnLine(this.path, this.color, this.width);
}

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<DrawnLine> lines = [];
  DrawnLine? currentLine;
  
  Color selectedColor = Colors.black;
  double selectedWidth = 5.0;

  final List<Color> colors = [
    Colors.black,
    Colors.grey,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
  ];

  void onPanStart(DragStartDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);
    // Adjust for app bar offset roughly or wrap just the drawing area in a Builder.
    // Better yet, use localPosition from details!
    setState(() {
      currentLine = DrawnLine([details.localPosition], selectedColor, selectedWidth);
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      List<Offset> path = List.from(currentLine!.path)..add(details.localPosition);
      currentLine = DrawnLine(path, selectedColor, selectedWidth);
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      if (currentLine != null) {
        lines.add(currentLine!);
        currentLine = null;
      }
    });
  }

  void clear() {
    setState(() {
      lines.clear();
      currentLine = null;
    });
  }

  void undo() {
    setState(() {
      if (lines.isNotEmpty) {
        lines.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Drawing Studio'),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: undo,
            tooltip: 'Undo',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: clear,
            tooltip: 'Clear',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Drawing Area
          Positioned.fill(
            child: GestureDetector(
              onPanStart: onPanStart,
              onPanUpdate: onPanUpdate,
              onPanEnd: onPanEnd,
              child: CustomPaint(
                painter: Sketcher(
                  lines: lines,
                  currentLine: currentLine,
                ),
                size: Size.infinite,
              ),
            ),
          ),
          // Toolbar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: buildToolbar(),
          ),
        ],
      ),
    );
  }

  Widget buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Color Palette
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colors.map((color) {
                bool isSelected = selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          // Brush Size Slider
          Row(
            children: [
              const Icon(Icons.brush, size: 20, color: Colors.grey),
              Expanded(
                child: Slider(
                  value: selectedWidth,
                  min: 1.0,
                  max: 20.0,
                  activeColor: selectedColor,
                  onChanged: (value) {
                    setState(() {
                      selectedWidth = value;
                    });
                  },
                ),
              ),
              Text(
                selectedWidth.toInt().toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Sketcher extends CustomPainter {
  final List<DrawnLine> lines;
  final DrawnLine? currentLine;

  Sketcher({required this.lines, this.currentLine});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < lines.length; ++i) {
      _drawLine(canvas, lines[i], paint);
    }

    if (currentLine != null) {
      _drawLine(canvas, currentLine!, paint);
    }
  }

  void _drawLine(Canvas canvas, DrawnLine line, Paint paint) {
    if (line.path.isEmpty) return;

    paint.color = line.color;
    paint.strokeWidth = line.width;

    if (line.path.length == 1) {
      // Draw a dot if it's just a single tap
      canvas.drawPoints(PointMode.points, line.path, paint);
    } else {
      Path path = Path();
      path.moveTo(line.path.first.dx, line.path.first.dy);
      for (int i = 1; i < line.path.length; ++i) {
        path.lineTo(line.path[i].dx, line.path[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true; // Simple approach, always repaint on updates
  }
}
