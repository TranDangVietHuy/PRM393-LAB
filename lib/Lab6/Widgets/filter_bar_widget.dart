import 'package:flutter/material.dart';
import 'package:prj/Lab6/ViewModel/movie_view_model.dart';

const _accent       = Color(0xFF534AB7);
const _accentLight  = Color(0xFFEEEDFE);
const _border       = Color(0xFFE5E3DC);
const _textSec      = Color(0xFF888780);

class FilterBarWidget extends StatelessWidget {
  final MovieViewModel viewModel;
  final VoidCallback onFilterTap;

  const FilterBarWidget({
    super.key,
    required this.viewModel,
    required this.onFilterTap,
  });

  String get _sortLabel {
    switch (viewModel.sortMode) {
      case SortMode.az:
        return 'A–Z';
      case SortMode.za:
        return 'Z–A';
      case SortMode.year:
        return 'Year';
      case SortMode.rating:
        return 'Rating';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      child: Row(
        children: [
          // Scrollable genre chips
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 6,
                children: viewModel.genres.map((g) {
                  final on = viewModel.isGenreSelected(g.id);
                  return _GenreChip(
                    label: g.name,
                    active: on,
                    onTap: () => viewModel.toggleGenre(g.id),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Sort button
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _border, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sort_rounded, size: 14, color: _textSec),
                  const SizedBox(width: 4),
                  Text(_sortLabel, style: const TextStyle(fontSize: 12, color: _textSec)),
                  const SizedBox(width: 2),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: _textSec),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _GenreChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: active ? _accent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? _accent : _border,
            width: active ? 1.5 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: active ? _accentLight : _textSec,
          ),
        ),
      ),
    );
  }
}