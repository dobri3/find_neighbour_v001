import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CriteriaCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CriteriaCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<CriteriaCard> createState() => _CriteriaCardState();
  
}

class _CriteriaCardState extends State<CriteriaCard> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true), 
      onExit: (_) => setState(() => _isHovered = false), 
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), 
        
      width: _isHovered ? 421 : 411,
      // height: _isHovered ? 156 : 146,
      height: 146,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF32658D).withOpacity(0.20),
            const Color(0xFF131718).withOpacity(0.80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: _isHovered ? Colors.tealAccent : AppColors.teal,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иконка
          Container(
            padding: const EdgeInsets.all(14),
            // height: context,
            decoration: BoxDecoration(
              color: AppColors.teal,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              widget.icon,
              color: const Color.fromARGB(255, 255, 255, 255),
              size: 56,
            ),
          ),

          const SizedBox(width: 20),

          // Текст
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    fontFamily: "Inter",
                    color: Colors.white.withOpacity(0.80),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
