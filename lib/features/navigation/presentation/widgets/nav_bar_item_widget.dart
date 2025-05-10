import 'package:flutter/material.dart';

class NavBarItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final AnimationController animationController;

  const NavBarItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final colorScheme = Theme.of(context).colorScheme;

    final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 60, // Fixed height container to better manage space
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with animated indication
            SizedBox(
              height: 40, // Fixed height for icon area
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background indicator
                  if (isSelected)
                    AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: animation.value,
                          child: Container(
                            width: 36, // Smaller background
                            height: 36, // Smaller background
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.3),
                                  secondaryColor.withOpacity(0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  // Icon
                  Icon(
                    icon,
                    color: isSelected
                        ? primaryColor
                        : colorScheme.onSurface.withOpacity(0.6),
                    size: isSelected ? 22 : 20, // Smaller icons
                  ),
                ],
              ),
            ),

            // Label with fixed height
            SizedBox(
              height: 16, // Fixed height for text to prevent overflow
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: 10, // Same size for both states
                  height: 1.0, // Tighter line height
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? primaryColor
                      : colorScheme.onSurface.withOpacity(0.6),
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
