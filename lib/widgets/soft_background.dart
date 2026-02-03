import 'package:flutter/material.dart';
import 'package:gestacao/commons/theme.dart';

/// Soft gradient background with subtle decorative blobs
class SoftBackground extends StatelessWidget {
  final Widget child;
  final bool showTopBlob;
  final bool showBottomBlob;

  const SoftBackground({
    super.key,
    required this.child,
    this.showTopBlob = true,
    this.showBottomBlob = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kSurface, Color(0xFFFFF0F3)],
            ),
          ),
        ),
        // Top decorative blob
        if (showTopBlob)
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: kPrimaryLight.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        if (showTopBlob)
          Positioned(
            top: 40,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: kAccent.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
            ),
          ),
        // Bottom decorative blob
        if (showBottomBlob)
          Positioned(
            bottom: -50,
            left: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: kPrimaryLight.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
        if (showBottomBlob)
          Positioned(
            bottom: 30,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: kAccent.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
        // Content
        child,
      ],
    );
  }
}
