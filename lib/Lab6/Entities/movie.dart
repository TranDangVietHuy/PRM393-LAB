// lib/models/movie.dart

class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final List<int> genreIds;
  final double rating;
  final int releaseYear;

  const Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genreIds,
    required this.rating,
    required this.releaseYear,
  });

  Movie copyTo({
    String? title,
    String? imageUrl,
    List<int>? genreIds,
    double? rating,
    int? releaseYear,
  }) {
    Movie newMovie = Movie(
      id: id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      genreIds: genreIds ?? this.genreIds,
      rating: rating ?? this.rating,
      releaseYear: releaseYear ?? this.releaseYear,
    );

    return newMovie;
  }
}
