import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/cache/cache_helper.dart';
import 'package:e_commerce/core/cache/cache_keys.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_page_view.dart';
import 'onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late final List<OnBoardingModel> onBoardingList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tr = LocalizationService.instance.tr(context);
    onBoardingList = [
      OnBoardingModel(
        image: AppIcons.onboarding1,
        title: tr.onboarding_1,
        desc: tr.onboarding_disc_1,
      ),
      OnBoardingModel(
        image: AppIcons.onboarding1,
        title: tr.onboarding_1,
        desc: tr.onboarding_disc_1,
      ),
      OnBoardingModel(
        image: AppIcons.onboarding1,
        title: tr.onboarding_1,
        desc: tr.onboarding_disc_1,
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNextPage() async {
    if (_currentPage == onBoardingList.length - 1) {
      await CacheHelper.setValue(CacheKeys.onboardingSeen, true);
      if (mounted) context.go(AppRouterKeys.authKey);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onPreviousPage() {
    if (_currentPage == 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onSkip() async {
    await CacheHelper.setValue(CacheKeys.onboardingSeen, true);
    if (mounted) context.go(AppRouterKeys.authKey);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomPageView(
          controller: _controller,
          pageCount: onBoardingList.length,
          pages: onBoardingList,
          currentPage: _currentPage,
          onPageChanged: (index) => setState(() => _currentPage = index),
          onNext: _onNextPage,
          onPrevious: _onPreviousPage,
          onSkip: _onSkip,
          isLastPage: _currentPage == onBoardingList.length - 1,
          isFirstPage: _currentPage == 0,
        ),
      ),
    );
  }
}