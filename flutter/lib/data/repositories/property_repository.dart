import '../models/property.dart';
import '../models/property_filter.dart';

abstract class PropertyRepository {
  Future<List<PropertySummary>> getProperties();
  Future<List<PropertySummary>> getFeaturedProperties();
  Future<PropertyDetail> getPropertyById(String id);
  Future<List<PropertySummary>> filterProperties(
    List<PropertySummary> properties,
    PropertyFilter filter,
  );
  Future<List<HostProperty>> getHostProperties();
}
