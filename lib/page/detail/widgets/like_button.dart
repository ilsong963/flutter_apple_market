import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLike;
  final ValueChanged<bool> onLikeChanged;
  const LikeButton({super.key, required this.isLike, required this.onLikeChanged});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLike;
  @override
  void initState() {
    super.initState();
    _isLike = widget.isLike;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isLike = !_isLike;
          widget.onLikeChanged(_isLike);
        });
      },
      icon: Icon(_isLike ? Icons.favorite : Icons.favorite_border, color: _isLike ? Colors.red : Colors.grey),
    );
  }
}
