import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'language_switch.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
        child: Row(
          children: [
            Text(tr.language,),
            Spacer(),
            LanguageSwitch()
          ],
        ),
      ),
    );
  }
}