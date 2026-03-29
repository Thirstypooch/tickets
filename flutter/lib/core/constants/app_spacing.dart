/// Spacing scale matching Tailwind's 4px base unit.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;   // p-1
  static const double sm = 8.0;   // p-2
  static const double md = 12.0;  // p-3
  static const double lg = 16.0;  // p-4
  static const double xl = 20.0;  // p-5
  static const double xxl = 24.0; // p-6
  static const double xxxl = 32.0; // p-8
  static const double huge = 48.0; // p-12
  static const double massive = 64.0; // p-16
  static const double giant = 80.0; // p-20

  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;  // --radius: 0.5rem
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusFull = 9999.0;

  // Breakpoints (matching Tailwind)
  static const double breakpointSm = 640.0;
  static const double breakpointMd = 768.0;
  static const double breakpointLg = 1024.0;
  static const double breakpointXl = 1280.0;
}
