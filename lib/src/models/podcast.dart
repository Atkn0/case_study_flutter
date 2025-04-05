class Podcast {
  final String id;
  final String title;
  final String author;
  final String coverImageUrl;
  bool isFavorite;
  final String category;

  Podcast({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImageUrl,
    this.isFavorite = false,
    required this.category,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
