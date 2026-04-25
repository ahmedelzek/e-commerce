import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final int min;
  final int max;
  final ValueChanged<int>? onChanged;

  const QuantitySelector({
    super.key,
    this.initialValue = 1,
    this.min = 1,
    this.max = 10,
    this.onChanged,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelector();
}

class _QuantitySelector extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    if (_quantity < widget.max) {
      setState(() => _quantity++);
      widget.onChanged?.call(_quantity);
    }
  }

  void _decrement() {
    if (_quantity > widget.min) {
      setState(() => _quantity--);
      widget.onChanged?.call(_quantity);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _buildButton(
        icon: Icons.remove,
        onTap: _decrement,
        isEnabled: _quantity > widget.min,
      ),

      Container(
        width: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          '$_quantity',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),

      // Plus Button
      _buildButton(
        icon: Icons.add,
        onTap: _increment,
        isEnabled: _quantity < widget.max,
      ),
    ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: isEnabled
              ? AppColors.red
              :  AppColors.pink,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 10.r,
          color:AppColors.white
        ),
      ),
    );
  }
}
