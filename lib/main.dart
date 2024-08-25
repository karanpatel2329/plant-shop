import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thence/features/products/bloc/product_bloc.dart';
import 'package:thence/features/products/repositories/product_repository.dart';
import 'package:thence/features/products/screens/home.dart';
import 'package:thence/features/products/screens/not_found.dart';
import 'package:thence/features/products/screens/product_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, index) => BlocProvider(
        create: (context) => ProductBloc(ProductRepository()),
        child: MaterialApp.router(
          title: 'Flutter Assignment',
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) => const HomeScreen(),
              ),
              GoRoute(
                path: '/flutter/assignment/product/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id'];
                  return ProductDetailScreen(productId: id!);
                },
              ),
              GoRoute(
                path: "/product/:id",
                builder: (context, state) => ProductDetailScreen(
                  productId: state.pathParameters['id'] ?? '1',
                ),
              ),
              GoRoute(
                  path: '/not-found',
                  builder: (context, state) => NotFoundScreen())
            ],
            errorBuilder: (context, state) => const NotFoundScreen(),
          ),
        ),
      ),
    );
  }
}
