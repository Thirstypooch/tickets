/// Matches NestJS EventFilterInput.
class EventFilter {
  final String keyword;
  final String city;
  final String category;
  final double? priceMin;
  final double? priceMax;
  final String? startDate;
  final String? endDate;
  final String sort;
  final int page;
  final int size;

  const EventFilter({
    this.keyword = '',
    this.city = '',
    this.category = '',
    this.priceMin,
    this.priceMax,
    this.startDate,
    this.endDate,
    this.sort = 'date,asc',
    this.page = 0,
    this.size = 20,
  });

  EventFilter copyWith({
    String? keyword,
    String? city,
    String? category,
    double? priceMin,
    double? priceMax,
    String? startDate,
    String? endDate,
    String? sort,
    int? page,
    int? size,
  }) {
    return EventFilter(
      keyword: keyword ?? this.keyword,
      city: city ?? this.city,
      category: category ?? this.category,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      sort: sort ?? this.sort,
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (keyword.isNotEmpty) params['keyword'] = keyword;
    if (city.isNotEmpty) params['city'] = city;
    if (category.isNotEmpty) params['category'] = category;
    if (priceMin != null) params['priceMin'] = priceMin.toString();
    if (priceMax != null) params['priceMax'] = priceMax.toString();
    if (startDate != null) params['startDate'] = startDate!;
    if (endDate != null) params['endDate'] = endDate!;
    params['sort'] = sort;
    params['page'] = page.toString();
    params['size'] = size.toString();
    return params;
  }

  static const List<({String value, String label})> categoryOptions = [
    (value: '', label: 'All Categories'),
    (value: 'Music', label: 'Music'),
    (value: 'Sports', label: 'Sports'),
    (value: 'Arts & Theatre', label: 'Arts & Theatre'),
    (value: 'Film', label: 'Film'),
    (value: 'Miscellaneous', label: 'Miscellaneous'),
  ];
}
