import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/customized_widgets/customized_product_item.dart';
import 'package:e_commerce/core/customized_widgets/customized_search_text_field.dart';
import 'package:e_commerce/core/di/injector.dart';
import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (_) => sl<SearchCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: CustomizedAppBar(title: tr.search, context: context),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  SearchTextField(
                    hintText: tr.search_text,
                    controller: _controller,
                    clickAple: true,
                    onChanged: cubit.onQueryChanged,
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchInitialState) {
                          return Center(child: Text(tr.search_text));
                        }

                        if (state is SearchLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (state is SearchErrorState) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(state.error),
                                SizedBox(height: 12.h),
                                CustomizedButton(
                                  title: tr.retry,
                                  horizontalMargin: 50.w,
                                  onTap: () => cubit.search(_controller.text),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state is SearchSuccessState) {
                          if (cubit.products.isEmpty) {
                            return Center(child: Image.asset(
                              AppImages.emptyOrder, width: 200.w,
                              height: 200.h,),);
                          }
                          return GridView.builder(
                            itemCount: cubit.products.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 12.h,
                              mainAxisExtent: 310.h,
                            ),
                            itemBuilder: (context, index) {
                              final product = cubit.products[index];
                              return CustomizedProductItem(
                                productName: product.name,
                                description: product.description,
                                imagePath: product.imagePath,
                                price: product.price,
                                rate: product.rating,
                                reviewCount: product.price,
                                onTap: () =>
                                    context.push(
                                      AppRouterKeys.product,
                                      extra: product,
                                    ),
                              );
                            },
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}