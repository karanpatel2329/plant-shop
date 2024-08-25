import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thence/core/colors.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Product not found'),
            SizedBox(
              height: 20.sp,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.pink),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.sp))),
                    fixedSize: MaterialStateProperty.all(Size(260.sp, 54.sp))),
                onPressed: () {
                  context.go('/');
                },
                child: Text(
                  "Go to home",
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }
}
