import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final String? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onClear;
  final bool showClear;
  final clickAple;

  const SearchTextField({
    super.key,
    this.hintText = 'Search any Product..',
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.onClear,
    this.showClear = false,
    this.clickAple = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: clickAple,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        prefixIcon: prefixIcon != null
            ? Padding(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(prefixIcon!),
        )
            : const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.search_rounded, color: AppColors.grey),
        ),
        suffixIcon: showClear
            ? InkWell(
          onTap: onClear,
          child: const Icon(Icons.cancel_rounded, color: AppColors.grey),
        )
            : null,
        hintText: hintText,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
      ),
    );
  }
}