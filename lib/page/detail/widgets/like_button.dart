import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isLike = !isLike;
        });
      },
      icon: Icon(isLike ? Icons.favorite : Icons.favorite_border, color: isLike ? Colors.red : Colors.grey),
    );
  }
}
