enum SortOption {
  dateNewest(label: 'Date (Newest)'),
  dateOldest(label: 'Date (Oldest)'),
  titleAZ(label: 'Title (A-Z)'),
  titleZA(label: 'Title (Z-A)');

  final String label;
  const SortOption({required this.label});
}