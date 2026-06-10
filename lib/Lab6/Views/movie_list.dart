import 'package:flutter/material.dart';
import 'package:prj/Lab6/Entities/movie.dart';
import 'package:prj/Lab6/Entities/genre.dart';
import 'package:prj/Lab6/ViewModel/movie_view_model.dart';
import 'package:prj/Lab6/Widgets/filter_bar_widget.dart';
import 'package:prj/Lab6/Widgets/filter_sort_sheet.dart';
import 'package:prj/Lab6/Widgets/search_bar_widget.dart';
import 'package:prj/Lab6/Widgets/top_bar_widget.dart';

const _accent       = Color(0xFF534AB7);
const _accentLight  = Color(0xFFEEEDFE);
const _accentDeep   = Color(0xFF3C3489);
const _surface      = Color(0xFFF5F4F0);
const _border       = Color(0xFFE5E3DC);
const _textPri      = Color(0xFF1A1A1A);
const _textSec      = Color(0xFF888780);
const _textTer      = Color(0xFFB4B2A9);
const _starColor    = Color(0xFFEF9F27);

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late final MovieViewModel _viewModel;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = MovieViewModel();
    _viewModel.addListener(_onViewModelChange);
  }

  void _onViewModelChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _openFilterSheet() async {
    final result = await showModalBottomSheet<FilterResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterSortSheet(
        selectedGenreIds: Set.from(_viewModel.selectedGenreIds),
        sortMode: _viewModel.sortMode,
        genres: _viewModel.genres,
      ),
    );
    if (result != null && mounted) {
      _viewModel.selectedGenreIds
        ..clear()
        ..addAll(result.genreIds);
      _viewModel.sortMode = result.sortMode;
    }
  }

  void _clearFilters() {
    _searchCtrl.clear();
    _viewModel.clearAllFilters();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChange);
    _viewModel.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movies = _viewModel.movies;
    final hasFilters = _viewModel.selectedGenreIds.isNotEmpty || _viewModel.searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: _surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            const TopBarWidget(),

            // Search Bar
            SearchBarWidget(
              controller: _searchCtrl,
              onChanged: (v) => _viewModel.searchQuery = v,
            ),

            // Filter Bar (Genre chips + Sort button)
            FilterBarWidget(
              viewModel: _viewModel,
              onFilterTap: _openFilterSheet,
            ),

            // Results Header
            _ResultsHeader(
              count: movies.length,
              selectedCount: _viewModel.selectedGenreIds.length,
              hasFilters: hasFilters,
              onClear: _clearFilters,
            ),

            // Movie list / grid / empty state
            Expanded(
              child: movies.isEmpty
                  ? _EmptyState(onClear: _clearFilters)
                  : _MovieListOrGrid(
                      movies: movies,
                      viewModel: _viewModel,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: ResultsHeader
// ─────────────────────────────────────────────────────────────────────────────
class _ResultsHeader extends StatelessWidget {
  final int count;
  final int selectedCount;
  final bool hasFilters;
  final VoidCallback onClear;

  const _ResultsHeader({
    required this.count,
    required this.selectedCount,
    required this.hasFilters,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _surface,
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 6),
      child: Row(
        children: [
          Text(
            '$count ${count == 1 ? 'movie' : 'movies'}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _textSec,
            ),
          ),
          if (selectedCount > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$selectedCount',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _accentLight,
                ),
              ),
            ),
          ],
          if (hasFilters) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _accentLight,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFAFA9EC), width: 0.5),
                ),
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 12,
                    color: _accentDeep,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: MovieListOrGrid (Responsive Container)
// ─────────────────────────────────────────────────────────────────────────────
class _MovieListOrGrid extends StatelessWidget {
  final List<Movie> movies;
  final MovieViewModel viewModel;

  const _MovieListOrGrid({
    required this.movies,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;

        if (isWide) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4.5,
            padding: const EdgeInsets.all(12),
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            children: movies
                .map(
                  (m) => _MovieCard(
                    movie: m,
                    viewModel: viewModel,
                    posterHeight: 90,
                  ),
                )
                .toList(),
          );
        } else {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, i) => _MovieCard(
              movie: movies[i],
              viewModel: viewModel,
              posterHeight: 78,
            ),
          );
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: MovieCard
// ─────────────────────────────────────────────────────────────────────────────
class _MovieCard extends StatelessWidget {
  final Movie movie;
  final MovieViewModel viewModel;
  final double posterHeight;

  const _MovieCard({
    required this.movie,
    required this.viewModel,
    required this.posterHeight,
  });

  @override
  Widget build(BuildContext context) {
    final posterWidth = posterHeight * 0.69;
    final genreNames = movie.genreIds
        .map((id) => viewModel.genres.firstWhere((g) => g.id == id, orElse: () => Genre(id: id, name: '')).name)
        .where((name) => name.isNotEmpty)
        .toList();

    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: posterHeight * 0.13,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            _PosterImage(
              url: movie.imageUrl,
              width: posterWidth,
              height: posterHeight,
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _textPri,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${movie.releaseYear}',
                    style: const TextStyle(fontSize: 12, color: _textTer),
                  ),
                  const SizedBox(height: 5),
                  // Genre tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: genreNames.map((g) => _GenreTag(label: g)).toList(),
                  ),
                  const SizedBox(height: 4),
                  // Star rating
                  _StarRating(rating: movie.rating),
                ],
              ),
            ),

            // Chevron
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: _textTer,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: PosterImage
// ─────────────────────────────────────────────────────────────────────────────
class _PosterImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const _PosterImage({
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) => progress == null
              ? child
              : Container(
                  color: _accentLight,
                  child: const Center(
                    child: Icon(Icons.movie_outlined, color: _accent, size: 20),
                  ),
                ),
          errorBuilder: (context, error, stackTrace) => Container(
            color: _accentLight,
            child: const Center(
              child: Icon(Icons.movie_outlined, color: _accent, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: GenreTag
// ─────────────────────────────────────────────────────────────────────────────
class _GenreTag extends StatelessWidget {
  final String label;
  const _GenreTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _border, width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, color: _textSec),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: StarRating
// ─────────────────────────────────────────────────────────────────────────────
class _StarRating extends StatelessWidget {
  final double rating;
  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    // scale 10 rating to 5 star rating (since ratings in movie_dao are e.g. 9.0, 8.7, 8.4, 7.4)
    // Actually, in the sample data rating ranges from 0 to 10. Let's convert to 5 stars!
    final starRating = rating / 2.0;

    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < starRating.floor()) {
            return const Icon(Icons.star_rounded, size: 12, color: _starColor);
          }
          if (i < starRating && starRating - i >= 0.25) {
            return const Icon(
              Icons.star_half_rounded,
              size: 12,
              color: _starColor,
            );
          }
          return const Icon(
            Icons.star_outline_rounded,
            size: 12,
            color: _starColor,
          );
        }),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 11, color: _textTer),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Component: Empty State
// ─────────────────────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final VoidCallback onClear;
  const _EmptyState({required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _border, width: 0.5),
              ),
              child: const Icon(
                Icons.movie_filter_outlined,
                size: 28,
                color: _textTer,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No movies found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _textPri,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Try a different keyword or remove some genre filters to see more results.',
              style: TextStyle(fontSize: 13, color: _textSec, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: _accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Clear all filters',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _accentLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}