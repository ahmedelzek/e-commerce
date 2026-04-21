import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/app_colors.dart';

class CustomizedTextField extends StatefulWidget {
  final String? hintText;
  final String? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const CustomizedTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.onTap,
    this.isPassword = false,
  });

  @override
  State<CustomizedTextField> createState() => _CustomizedTextFieldState();
}

class _CustomizedTextFieldState extends State<CustomizedTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      validator: widget.validator,
      onTap: widget.onTap,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        prefixIcon:
            widget.prefixIcon != null
                ? Padding(
                  padding: EdgeInsets.all(16),
                  child: SvgPicture.asset(widget.prefixIcon!),
                )
                : null,
        suffixIcon:
            widget.isPassword
                ? InkWell(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child:
                      _obscureText
                          ? Icon(Icons.visibility, color: AppColors.grey,)
                          : Icon(Icons.visibility_off, color: AppColors.grey,),
                )
                : null,
        hintText: widget.hintText,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      ),
    );
  }
}
