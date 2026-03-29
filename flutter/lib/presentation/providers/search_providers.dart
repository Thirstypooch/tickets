import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchParams {
  final String location;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int guests;

  const SearchParams({
    this.location = '',
    this.checkIn,
    this.checkOut,
    this.guests = 1,
  });

  SearchParams copyWith({
    String? location,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
  }) {
    return SearchParams(
      location: location ?? this.location,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      guests: guests ?? this.guests,
    );
  }
}

final searchParamsProvider = StateProvider<SearchParams>((ref) {
  return const SearchParams();
});
