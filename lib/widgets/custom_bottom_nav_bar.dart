import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/widgets/bottom_nav_bar_item.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      'assets/icons/search_map.svg',
      'assets/icons/message.svg',
      'assets/icons/home.svg',
      'assets/icons/heart.svg',
      'assets/icons/user.svg',
    ];

    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.only(
            right: 40.rw(context),
            left: 40.rw(context),
            bottom: 30.rh(context)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55.rh(context),
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? const Color.fromARGB(255, 54, 54, 54).withOpacity(0.8)
                    : const Color.fromARGB(177, 0, 0, 0),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(icons.length, (index) {
                  final isSelected = selectedIndex == index;

                  return CustomNavBarItem(
                    onTap: () => onItemTapped(index),
                    icon: icons[index],
                    isSelected: isSelected,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
