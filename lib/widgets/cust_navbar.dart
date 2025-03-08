import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yolo_app/utils/constant.dart';

class CurvedNavigationBar extends StatelessWidget {
  const CurvedNavigationBar({
    super.key,
    required this.items,
    this.onTap,
    this.unselectedColor = YAppColors.whiteColor,
    this.selectedColor = YAppColors.whiteColor,
    this.currentIndex = 0,
  }) : assert(
          items.length == 2,
          'This widget requires exactly 2 items.',
        );

  final List<CurvedNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final Color unselectedColor;
  final Color selectedColor;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        //last layer white gradient background
        ClipPath(
          clipper: _CurvedClipper(),
          child: Container(
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  YAppColors.backgroundColor,
                  // YAppColors.whiteColor.withOpacity(0.01),
                  YAppColors.whiteColor.withOpacity(0.5),
                  // YAppColors.whiteColor.withOpacity(0.01),
                  YAppColors.backgroundColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
        ),
        //middle
        ClipPath(
          clipper: _CurvedClipper(),
          child: Container(
            height: 108,
            color: YAppColors.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = index == currentIndex;
                  return GestureDetector(
                    onTap: () => onTap?.call(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: YAppColors.backgroundColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.inner,
                                color: Colors.white.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, -1),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            item.iconData,
                            color: isSelected
                                ? selectedColor
                                : unselectedColor.withOpacity(0.3),
                            size: isSelected ? 28 : 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: GoogleFonts.poppins(
                            color: isSelected
                                ? selectedColor
                                : unselectedColor.withOpacity(0.3),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),

        //top
        Positioned(
          bottom: 20,
          // This makes the middle button float
          child: GestureDetector(
            onTap: () => onTap?.call(1), // Select middle item
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: YAppColors.backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.inner,
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, -1),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                    color: YAppColors.whiteColor,
                    shadows: [
                      BoxShadow(
                        blurStyle: BlurStyle.inner,
                        color: selectedColor.withOpacity(0.7),
                        blurRadius: 15,
                        offset: const Offset(0, -1),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'yolo pay',
                  style: GoogleFonts.poppins(
                    color: YAppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CurvedNavigationBarItem {
  const CurvedNavigationBarItem({
    required this.iconData,
    required this.label,
  });

  final IconData iconData;
  final String label;
}

class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double h = size.height;
    // double w = size.width;

    // Path path = Path();

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.0000330, size.height * 0.3717442);
    path_1.cubicTo(
        size.width * 0.2809384,
        size.height * -0.1239050,
        size.width * 0.7221850,
        size.height * -0.1200608,
        size.width * 1.0030331,
        size.height * 0.3717442);
    path_1.quadraticBezierTo(size.width * 1.0030331, size.height * 0.5288053,
        size.width * 1.0030331, size.height * 0.9999888);
    path_1.lineTo(size.width * -0.0000330, size.height * 0.9999888);
    path_1.quadraticBezierTo(size.width * -0.0000330, size.height * 0.8429276,
        size.width * -0.0000330, size.height * 0.3717442);
    path_1.close();

    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
