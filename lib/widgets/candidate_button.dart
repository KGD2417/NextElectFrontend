import 'package:flutter/material.dart';

class CandidateButton extends StatelessWidget {
  final String candidate;
  final VoidCallback onPressed;

  const CandidateButton({
    super.key,
    required this.candidate,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed, // Directly use the callback without async
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: const Color(0xffbeff4f8), // Fixed color code (8 digits)
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                        candidate,
                        style: const TextStyle(fontSize: 16)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}