import 'package:flutter/material.dart';

class SegmentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isActive;
  const SegmentButton({super.key, required this.title, required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          decoration: isActive ? BoxDecoration(
            border: Border.all(color: Colors.black87.withOpacity(0.5)),
            color: const Color.fromARGB(188, 192, 213, 195),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ) : null,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: isActive ? Colors.black : Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
