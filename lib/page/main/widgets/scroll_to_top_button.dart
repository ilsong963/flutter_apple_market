import 'package:flutter/material.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController controller;

  const ScrollToTopButton({super.key, required this.controller});

  @override
  _ScrollToTopButtonState createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> with SingleTickerProviderStateMixin {
  bool _showFab = false;
  bool _isPressed = false;
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final isTop = widget.controller.offset <= 0;
      if (_showFab == isTop) {
        setState(() {
          _showFab = !isTop;
        });
      }
    });
  }

  void _scrollToTop() {
    widget.controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => _isPressed = true),
      onPointerUp: (_) => setState(() => _isPressed = false),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _showFab ? 1.0 : 0.0,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
          child: FloatingActionButton(
            backgroundColor: _isPressed ? Colors.blue : Colors.white,
            elevation: 0,
            shape: const CircleBorder(side: BorderSide(color: Colors.grey, width: 2)),
            onPressed: _scrollToTop,

            child: Icon(Icons.vertical_align_top, color: _isPressed ? Colors.white : Colors.grey),
          ),
        ),
      ),
    );
  }
}
