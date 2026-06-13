import 'package:flutter/material.dart';
import 'package:prj/Lab6/Entities/genre.dart';
import 'package:prj/Lab6/ViewModel/movie_view_model.dart';

const _accent       = Color(0xFF534AB7);
const _accentLight  = Color(0xFFEEEDFE);
const _border       = Color(0xFFE5E3DC);
const _textPri      = Color(0xFF1A1A1A);
const _textSec      = Color(0xFF888780);
const _textTer      = Color(0xFFB4B2A9);

class FilterResult {
  final Set<int> genreIds;
  final SortMode sortMode;
  FilterResult({required this.genreIds, required this.sortMode});
}

class FilterSortSheet extends StatefulWidget {
  final Set<int> selectedGenreIds;
  final SortMode sortMode;
  final List<Genre> genres;

  const FilterSortSheet({
    super.key,
    required this.selectedGenreIds,
    required this.sortMode,
    required this.genres,
  });

  @override
  State<FilterSortSheet> createState() => _FilterSortSheetState();
}

class _FilterSortSheetState extends State<FilterSortSheet> {
  late Set<int> _genreIds;
  late SortMode _sort;

  @override
  void initState() {
    super.initState();
    _genreIds = Set.from(widget.selectedGenreIds);
    _sort = widget.sortMode;
  }

  static const _sortLabels = {
    SortMode.az: 'A–Z',
    SortMode.za: 'Z–A',
    SortMode.rating: 'Rating',
    SortMode.year: 'Year',
  };

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            // Handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title + close
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
              child: Row(
                children: [
                  const Text(
                    'Sort & filter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _textPri,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close_rounded, size: 20, color: _textSec),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5, color: _border),

            // Sort section
            const _SheetSectionLabel('Sort by'),
            ..._sortLabels.entries.map((e) => _SortOption(
                  label: e.value,
                  selected: _sort == e.key,
                  onTap: () => setState(() => _sort = e.key),
                )),

            const Divider(height: 1, thickness: 0.5, color: _border),

            // Genre section
            const _SheetSectionLabel('Genres'),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 4),
              child: Wrap(
                spacing: 7,
                runSpacing: 7,
                children: widget.genres.map((g) {
                  final on = _genreIds.contains(g.id);
                  return GestureDetector(
                    onTap: () => setState(() => on ? _genreIds.remove(g.id) : _genreIds.add(g.id)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 130),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: on ? _accent : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: on ? _accent : _border,
                          width: on ? 1.5 : 0.5,
                        ),
                      ),
                      child: Text(
                        g.name,
                        style: TextStyle(
                          fontSize: 13,
                          color: on ? _accentLight : _textSec,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Apply button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GestureDetector(
                onTap: () => Navigator.pop(
                  context,
                  FilterResult(genreIds: _genreIds, sortMode: _sort),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Apply filters',
                    style: TextStyle(
                      color: _accentLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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

class _SheetSectionLabel extends StatelessWidget {
  final String text;
  const _SheetSectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w600,
          color: _textTer,
        ),
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SortOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: selected ? _accent : _textPri,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? _accent : Colors.transparent,
                border: Border.all(color: selected ? _accent : _border, width: 1.5),
              ),
              child: selected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

