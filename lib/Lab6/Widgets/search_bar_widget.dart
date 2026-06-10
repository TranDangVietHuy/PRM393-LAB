import 'package:flutter/material.dart';

const _accent    = Color(0xFF534AB7);
const _surface   = Color(0xFFF5F4F0);
const _border    = Color(0xFFE5E3DC);
const _textPri   = Color(0xFF1A1A1A);
const _textTer   = Color(0xFFB4B2A9);

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: _textPri),
        decoration: InputDecoration(
          hintText: 'Search title or keyword…',
          hintStyle: const TextStyle(fontSize: 13, color: _textTer),
          prefixIcon: const Icon(Icons.search_rounded, size: 18, color: _textTer),
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged('');
                  },
                  child: const Icon(Icons.close_rounded, size: 16, color: _textTer),
                )
              : null,
          filled: true,
          fillColor: _surface,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _border, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _border, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _accent, width: 1.5),
          ),
        ),
      ),
    );
  }
}


