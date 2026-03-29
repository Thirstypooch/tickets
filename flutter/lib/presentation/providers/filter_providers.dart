import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/property_filter.dart';

final filterProvider = StateProvider<PropertyFilter>((ref) {
  return const PropertyFilter();
});
