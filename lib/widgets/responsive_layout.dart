import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Container(
            color: Colors.grey.shade100,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                // Clip behavior ensures the child scaffold doesn't bleed out of rounded corners if we add them later
                child: ClipRect(
                  child: child,
                ),
              ),
            ),
          );
        }

        return child;
      },
    );
  }
}
