class FilterModel {
  final String region;
  final String? category;
  final double? minRating;
  final SortOption sortOption;

  const FilterModel({
    required this.region,
    this.category,
    this.minRating,
    this.sortOption = SortOption.none,
  });

  FilterModel copyWith({
    String? region,
    String? category,
    double? minRating,
    SortOption? sortOption,
    bool clearCategory = false,
    bool clearMinRating = false,
  }) {
    return FilterModel(
      region: region ?? this.region,
      category: clearCategory ? null : (category ?? this.category),
      minRating: clearMinRating ? null : (minRating ?? this.minRating),
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

enum SortOption {
  none,
  nameAsc,
  nameDesc,
  ratingHigh,
  ratingLow,
}