import 'package:flutter/material.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget homeBuildOptionCard(
    BuildContext context, {
      required IconData icon,
      required String title,
      required Color color,
      required VoidCallback onTap,
    }) {
  return Card(
    elevation: 4,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(responsiveWidth(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: responsiveHeight(10),
          children: [
            Container(
              padding: EdgeInsets.all(responsiveWidth(12)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: responsiveFont(30),
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}