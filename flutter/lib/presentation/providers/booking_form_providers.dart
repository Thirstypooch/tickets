import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkInProvider = StateProvider<DateTime?>((ref) => null);
final checkOutProvider = StateProvider<DateTime?>((ref) => null);
final guestsProvider = StateProvider<int>((ref) => 1);
