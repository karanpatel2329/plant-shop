import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thence/core/colors.dart';
import 'package:thence/features/products/bloc/product_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int? productIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer(
          bloc: context.read<ProductBloc>()..add(FetchProducts()),
          builder: (context, state) {
            if (state is ProductLoading) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                          child: Text("Loading...."),
                          baseColor: AppColor.pink,
                          highlightColor: AppColor.lightBlue),
                    ],
                  ));
            }
            if (state is ProductLoaded &&
                productIndex != null &&
                (productIndex ?? -1) >= 0) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Image(
                        image: NetworkImage(
                            state.products[productIndex ?? 0].imageUrl ?? ""),
                        width: double.infinity,
                        height: 375.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 26.sp, horizontal: 24.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  state.products[productIndex ?? 0].name ?? "",
                                  style: TextStyle(
                                      color: AppColor.primary,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                                Text(
                                  "${state.products[productIndex ?? 0].price} ${state.products[productIndex ?? 0].priceUnit}",
                                  style: TextStyle(
                                      color: AppColor.primary,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColor.yellow,
                                  size: 16.sp,
                                ),
                                Text(
                                  state.products[productIndex ?? 0].rating
                                      .toString(),
                                  style: TextStyle(
                                      color: AppColor.yellow,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text(
                              "Choose size",
                              style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 30.sp,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.products[productIndex ?? 0]
                                        .availableSize?.length ??
                                    0,
                                itemBuilder: ((context, index) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<ProductBloc>(context)
                                              .add(SelectCategory(
                                                  categoryId: index));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: index == 0 ? 0.sp : 12.sp),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.sp,
                                              vertical: 8.sp),
                                          decoration: BoxDecoration(
                                              color: state.selectedCategoryId ==
                                                      index
                                                  ? AppColor.pink
                                                  : AppColor.lightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10.sp)),
                                          child: Text(
                                            "${state.products[productIndex ?? 0].availableSize?[index] ?? ""} ${state.products[productIndex ?? 0].unit ?? ""}",
                                            style: TextStyle(
                                                color:
                                                    state.selectedCategoryId ==
                                                            index
                                                        ? AppColor.white
                                                        : AppColor.primary
                                                            .withOpacity(0.4),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                            Text(
                              state.products[productIndex ?? 0].description ??
                                  "",
                              style: TextStyle(
                                  color: AppColor.primary.withOpacity(0.4),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 5,
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(14.sp),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGrey,
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: AppColor.primary,
                                    size: 18.sp,
                                  ),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColor.pink),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.sp))),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(260.sp, 54.sp))),
                                    onPressed: () {},
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              );
            }
            return SizedBox();
          },
          listener: (context, state) {
            
            // Here we are checking if the product is not found then we are redirecting to the not found page
            if (state is ProductLoaded) {
              try {
                productIndex = state.products.indexWhere((element) =>
                    (element.id ?? "").toString() == widget.productId);
                if ((productIndex ?? -1) < 0) {
                  context.go('/not-found');
                }
              } catch (e) {}
            }
          },
        ));
  }
}
