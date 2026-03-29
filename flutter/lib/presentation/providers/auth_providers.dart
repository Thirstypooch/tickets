import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mock auth state — mirrors the `isAuthenticated` useState in header.tsx.
final isAuthenticatedProvider = StateProvider<bool>((ref) => false);
