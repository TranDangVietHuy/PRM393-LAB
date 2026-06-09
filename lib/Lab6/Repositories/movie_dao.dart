import 'package:prj/Lab6/Entities/genre.dart';
import 'package:prj/Lab6/Entities/movie.dart';

class MovieDao {
  final List<Genre> genres = const [
    Genre(id: 1, name: 'Action'),
    Genre(id: 2, name: 'Sci-Fi'),
    Genre(id: 3, name: 'Superhero'),
    Genre(id: 4, name: 'Drama'),
    Genre(id: 5, name: 'Thriller'),
    Genre(id: 6, name: 'Animation'),
  ];

  final List<Movie> movies = [
    const Movie(
      id: 1,
      title: 'The Dark Knight',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      genreIds: [1, 3, 4],
      rating: 9.0,
      releaseYear: 2008,
    ),
    const Movie(
      id: 2,
      title: 'Interstellar',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      genreIds: [2, 4],
      rating: 8.7,
      releaseYear: 2014,
    ),
    const Movie(
      id: 3,
      title: 'Inception',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
      genreIds: [1, 2, 5],
      rating: 8.8,
      releaseYear: 2010,
    ),
    const Movie(
      id: 4,
      title: 'Avengers: Endgame',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
      genreIds: [1, 2, 3],
      rating: 8.4,
      releaseYear: 2019,
    ),
    const Movie(
      id: 5,
      title: 'Spider-Man: No Way Home',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/5weKu49pzJCt06OPpjvT80efnQj.jpg',
      genreIds: [1, 2, 3],
      rating: 8.2,
      releaseYear: 2021,
    ),
    const Movie(
      id: 6,
      title: 'Joker',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
      genreIds: [4, 5],
      rating: 8.4,
      releaseYear: 2019,
    ),
    const Movie(
      id: 7,
      title: 'Parasite',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
      genreIds: [4, 5],
      rating: 8.5,
      releaseYear: 2019,
    ),
    const Movie(
      id: 8,
      title: 'Coco',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/gGEsBPAijhVUFoiNpgZXqRVWJt2.jpg',
      genreIds: [6, 4],
      rating: 8.4,
      releaseYear: 2017,
    ),
    const Movie(
      id: 9,
      title: 'Toy Story',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg',
      genreIds: [6],
      rating: 8.3,
      releaseYear: 1995,
    ),
    const Movie(
      id: 10,
      title: 'John Wick',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
      genreIds: [1, 5],
      rating: 7.4,
      releaseYear: 2014,
    ),
    const Movie(
      id: 11,
      title: 'Dune',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
      genreIds: [1, 2, 4],
      rating: 8.0,
      releaseYear: 2021,
    ),
    const Movie(
      id: 12,
      title: 'The Batman',
      imageUrl:
          'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
      genreIds: [1, 4, 5],
      rating: 7.8,
      releaseYear: 2022,
    ),
  ];

  List<Movie> getAllMovie() {
    return movies;
  }

  List<Genre> getAllGenres() {
    return genres;
  }

  Movie? findById(int id) {
    try {
      return movies.firstWhere((movie) => movie.id == id);
    } catch (_) {
      return null;
    }
  }

  Movie? findByName(String title) {
    final keyword = title.toLowerCase().trim();

    try {
      return movies.firstWhere((movie) => movie.title.toLowerCase() == keyword);
    } catch (_) {
      return null;
    }
  }

  Genre? findGenreById(int id) {
    try {
      return genres.firstWhere((genre) => genre.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Genre> getGenresByMovie(Movie movie) {
    return genres
        .where((genre) => movie.genreIds.contains(genre.id))
        .toList(growable: false);
  }

  List<Movie> findByGenreId(int genreId) {
    return movies
        .where((movie) => movie.genreIds.contains(genreId))
        .toList(growable: false);
  }

  List<Movie> searchByTitle(String title) {
    final keyword = title.toLowerCase().trim();

    if (keyword.isEmpty) {
      return getAllMovie();
    }

    return movies
        .where((movie) => movie.title.toLowerCase().contains(keyword))
        .toList(growable: false);
  }

  int autoId() {
    var id = movies.isNotEmpty ? movies.last.id : 0;

    do {
      id++;
    } while (movies.indexWhere((movie) => movie.id == id) != -1);

    return id;
  }

  void addMovie({
    String title = '',
    List<int> genreIds = const [],
    String imageUrl = '',
    double rating = 0,
    int releaseYear = 0,
  }) {
    movies.add(
      Movie(
        id: autoId(),
        title: title,
        genreIds: genreIds,
        imageUrl: imageUrl,
        rating: rating,
        releaseYear: releaseYear,
      ),
    );
  }

  void updateMovie({
    required int id,
    String? title,
    List<int>? genreIds,
    String? imageUrl,
    double? rating,
    int? releaseYear,
  }) {
    final index = movies.indexWhere((movie) => movie.id == id);

    if (index == -1) {
      return;
    }

    movies[index] = movies[index].copyTo(
      title: title,
      genreIds: genreIds,
      imageUrl: imageUrl,
      rating: rating,
      releaseYear: releaseYear,
    );
  }

  bool deleteMovie(int id) {
    final index = movies.indexWhere((movie) => movie.id == id);

    if (index == -1) {
      return false;
    }

    movies.removeAt(index);
    return true;
  }
}
