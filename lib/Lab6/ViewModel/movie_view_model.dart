import 'package:flutter/foundation.dart';
import 'package:prj/Lab6/Entities/genre.dart';
import 'package:prj/Lab6/Entities/movie.dart';
import 'package:prj/Lab6/Repositories/movie_dao.dart';

enum SortMode { az, za, rating, year }

class MovieViewModel extends ChangeNotifier {
  final MovieDao movieDao = MovieDao();
  final Set<int> _selectedGenreIds = {};
  String _searchQuery = '';
  SortMode _sortMode = SortMode.rating;

  Set<int> get selectedGenreIds => _selectedGenreIds;
  List<Genre> get genres => movieDao.getAllGenres();
  
  String get searchQuery => _searchQuery;
  set searchQuery(String val) {
    if (_searchQuery != val) {
      _searchQuery = val;
      notifyListeners();
    }
  }

  SortMode get sortMode => _sortMode;
  set sortMode(SortMode val) {
    if (_sortMode != val) {
      _sortMode = val;
      notifyListeners();
    }
  }

  List<Movie> get movies {
    var list = movieDao.getAllMovie();

    // 1. Filter by Search Query
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      list = list.where((m) => m.title.toLowerCase().contains(q)).toList();
    }

    // 2. Filter by Genre (if any selected, otherwise show all matching search)
    if (_selectedGenreIds.isNotEmpty) {
      list = list
          .where((m) => m.genreIds.any((id) => _selectedGenreIds.contains(id)))
          .toList();
    }

    // 3. Sort
    final sortedList = List<Movie>.from(list);
    switch (_sortMode) {
      case SortMode.az:
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortMode.za:
        sortedList.sort((a, b) => b.title.compareTo(a.title));
        break;
      case SortMode.year:
        sortedList.sort((a, b) => b.releaseYear.compareTo(a.releaseYear));
        break;
      case SortMode.rating:
        sortedList.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return sortedList;
  }

  bool isGenreSelected(int id) {
    return _selectedGenreIds.contains(id);
  }

  void toggleGenre(int id) {
    if (_selectedGenreIds.contains(id)) {
      _selectedGenreIds.remove(id);
    } else {
      _selectedGenreIds.add(id);
    }
    notifyListeners();
  }

  void clearGenres() {
    _selectedGenreIds.clear();
    notifyListeners();
  }

  void clearAllFilters() {
    _selectedGenreIds.clear();
    _searchQuery = '';
    notifyListeners();
  }
}

