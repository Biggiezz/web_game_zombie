import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedHintTextField extends StatefulWidget {
  final double fontSize;
  final Function(String)? onChanged;
  final Function(String)? onUploadPressed;

  const AnimatedHintTextField({
    super.key,
    required this.fontSize,
    this.onChanged,
    this.onUploadPressed,
  });

  @override
  State<AnimatedHintTextField> createState() => _AnimatedHintTextFieldState();
}

class _AnimatedHintTextFieldState extends State<AnimatedHintTextField> {
  final _controller = TextEditingController();
  final List<String> _hintTexts = [
    'What game would you like to make?',
    'Make a racing game...',
    'Tìm kiếm các clip hay...',
    'Nhập tên game ở đây...',
  ];
  int _currentHintIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentHintIndex = (_currentHintIndex + 1) % _hintTexts.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFBEF264), width: 2),
        ),
        hintText: _hintTexts[_currentHintIndex],
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: widget.fontSize,
          height: 1.5,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(Icons.upload, color: Colors.black),
              onPressed: () {
                widget.onUploadPressed?.call(_controller.text);
                _controller.clear();
              },
            ),
          ),
        ),
      ),
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: widget.fontSize,
        color: Colors.white,
        height: 1.5,
      ),
    );
  }
}
