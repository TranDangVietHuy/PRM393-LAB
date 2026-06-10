import 'package:flutter/material.dart';
import 'package:prj/Lab6/theme.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Find a movie',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: kTextPri,
              ),
            ),
          ),
          _IconBtn(icon: Icons.notifications_none_rounded, onTap: () {}),
          const SizedBox(width: 8),
          _IconBtn(icon: Icons.person_outline_rounded, onTap: () {}),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kSurface,
          border: Border.all(color: kBorder, width: 0.5),
        ),
        child: Icon(icon, size: 18, color: kTextSec),
      ),
    );
  }
}

