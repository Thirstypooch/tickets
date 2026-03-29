import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchParams {
  final String keyword;
  final String city;
  final String category;
  final String? startDate;

  const SearchParams({
    this.keyword = '',
    this.city = '',
    this.category = '',
    this.startDate,
  });

  SearchParams copyWith({
    String? keyword,
    String? city,
    String? category,
    String? startDate,
  }) {
    return SearchParams(
      keyword: keyword ?? this.keyword,
      city: city ?? this.city,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
    );
  }
}

final searchParamsProvider = StateProvider<SearchParams>((ref) {
  return const SearchParams();
});
