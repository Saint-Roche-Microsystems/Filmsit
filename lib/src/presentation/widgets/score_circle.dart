import 'package:flutter/material.dart';

class ScoreCircle extends StatelessWidget {
  final double score;
  final double size;

  const ScoreCircle({
    super.key,
    required this.score,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black87,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Anillo de color basado en el score
          Center(
            child: SizedBox(
              width: size - 4,
              height: size - 4,
              child: CircularProgressIndicator(
                value: score / 10,
                strokeWidth: 3,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getScoreColor(score),
                ),
              ),
            ),
          ),

          Center(
            child: Text(
              score.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 7.0) {
      return Colors.green;
    } else if (score >= 5.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
