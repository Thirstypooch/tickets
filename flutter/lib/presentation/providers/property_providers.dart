import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/property.dart';
import '../../data/repositories/property_repository.dart';
import '../../data/repositories/property_repository_impl.dart';
import 'filter_providers.dart';

final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  return MockPropertyRepository();
});

final propertiesProvider = FutureProvider<List<PropertySummary>>((ref) {
  return ref.watch(propertyRepositoryProvider).getProperties();
});

final featuredPropertiesProvider = FutureProvider<List<PropertySummary>>((ref) {
  return ref.watch(propertyRepositoryProvider).getFeaturedProperties();
});

final propertyDetailProvider =
    FutureProvider.family<PropertyDetail, String>((ref, id) {
  return ref.watch(propertyRepositoryProvider).getPropertyById(id);
});

final filteredPropertiesProvider = FutureProvider<List<PropertySummary>>((ref) async {
  final properties = await ref.watch(propertiesProvider.future);
  final filter = ref.watch(filterProvider);
  return ref
      .watch(propertyRepositoryProvider)
      .filterProperties(properties, filter);
});

final hostPropertiesProvider = FutureProvider<List<HostProperty>>((ref) {
  return ref.watch(propertyRepositoryProvider).getHostProperties();
});
