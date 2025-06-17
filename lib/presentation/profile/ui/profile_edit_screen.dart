import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50.r)),
              child: Container(
                width: 80.w,
                height: 80.w,
                color: ColorName.purple,
                child: FadeInImage(
                    image: AssetImage(Assets.images.picture.penguin.path),
                    placeholder:
                    AssetImage(Assets.images.picture.penguin.path),
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                    alignment: Alignment.center,
                    fadeInDuration: const Duration(milliseconds: 100),
                    imageErrorBuilder: (context, error, stackTrace) {
                      if (error is Exception) {
                        return const SizedBox();
                      }
                      return const SizedBox();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
