import 'package:flutter/material.dart';
import '../core/utils/app_colors.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    const Color verdeEscuro = Color(0xFF356B33);

    return AppBar(
      backgroundColor: AppColors.primaryGreen,
      elevation: 0,
      // 1. REMOVE A SETA DE VOLTAR
      automaticallyImplyLeading: false, 
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFBF0),
                border: Border.all(color: verdeEscuro, width: 1.5), 
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.eco, 
                    size: 18, 
                    color: verdeEscuro,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Égua da Feira",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: verdeEscuro,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}