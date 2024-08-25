import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thence/core/colors.dart';
import 'package:thence/features/products/bloc/product_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "All",
    "Succulents",
    "Foliage",
    "Flowering",
    "Cactus"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.sp, horizontal: 0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All plants",
                      style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    const InkWell(
                      child: Icon(Icons.search),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 28.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.sp),
                child: Text(
                  'Houseplants',
                  style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 28.sp,
              ),
              HomeCategoryWidget(categories: categories),
              ProductListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocConsumer(
          bloc: BlocProvider.of<ProductBloc>(context),
          builder: (context, state) {
            if (state is ProductLoaded) {
              return ListView.builder(
                  itemCount: state.products.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.push('/product/${state.products[index].id}');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 12.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: 80.sp,
                                      width: 112.sp,
                                      decoration: BoxDecoration(
                                          color: index % 2 == 0
                                              ? AppColor.lightBlue
                                              : AppColor.lightPink,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                    ),
                                  ),
                                  Image.network(
                                    state.products[index].imageUrl ?? "",
                                    width: 112.sp,
                                    height: 112.sp,
                                  ),
                                  Positioned(
                                    bottom: 6.sp,
                                    right: 6.sp,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.sp, vertical: 4.sp),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius:
                                            BorderRadius.circular(6.sp),
                                      ),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: AppColor.mediumGrey,
                                        size: 16.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.sp,
                            ),
                            SizedBox(
                              height: 78.sp,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        114.sp -
                                        48.sp -
                                        16.sp,
                                    child: Row(
                                      children: [
                                        Text(
                                          state.products[index].name ?? "",
                                          style: TextStyle(
                                              color: AppColor.primary,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.star,
                                          color: AppColor.yellow,
                                          size: 16.sp,
                                        ),
                                        Text(
                                          state.products[index].rating
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColor.yellow,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${state.products[index].displaySize} ${state.products[index].unit}",
                                    style: TextStyle(
                                        color:
                                            AppColor.primary.withOpacity(0.4),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${state.products[index].price} ${state.products[index].priceUnit}",
                                    style: TextStyle(
                                        color: AppColor.primary,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            if (state is ProductLoading) {
              return Shimmer.fromColors(
                baseColor: AppColor.lightGrey,
                highlightColor: AppColor.white,
                enabled: true,
                child: ListView.builder(
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 12.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 80.sp,
                              width: 112.sp,
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? AppColor.lightBlue
                                      : AppColor.lightPink,
                                  borderRadius: BorderRadius.circular(10.sp)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16.sp),
                              width: MediaQuery.of(context).size.width -
                                  114.sp -
                                  48.sp -
                                  16.sp,
                              height: 78.sp,
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? AppColor.lightBlue
                                      : AppColor.lightPink,
                                  borderRadius: BorderRadius.circular(10.sp)),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }
            return const SizedBox.shrink();
          },
          listener: (c, s) {}),
    );
  }
}

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: BlocProvider.of<ProductBloc>(context)..add(FetchProducts()),
        builder: (context, state) {
          if (state is ProductLoaded) {
            return SizedBox(
              width: double.infinity,
              height: 60.sp,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(SelectCategory(categoryId: index));
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: index == 0 ? 20.sp : 12.sp),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.sp, vertical: 8.sp),
                          decoration: BoxDecoration(
                              color: state.selectedCategoryId == index
                                  ? AppColor.pink
                                  : AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                color: state.selectedCategoryId == index
                                    ? AppColor.white
                                    : AppColor.primary.withOpacity(0.4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          }
          if (state is ProductError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is ProductLoading) {
            return SizedBox(
              height: 60.sp,
              width: double.infinity,
              child: Shimmer.fromColors(
                baseColor: AppColor.lightGrey,
                highlightColor: AppColor.white,
                enabled: true,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<ProductBloc>(context)
                                .add(SelectCategory(categoryId: index));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 20.sp : 12.sp),
                            decoration: BoxDecoration(
                                color: AppColor.lightGrey,
                                borderRadius: BorderRadius.circular(10.sp)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.sp, vertical: 8.sp),
                            width: 100.sp,
                            height: 30.sp,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {});
  }
}
