import 'package:flutter/Material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';
import 'line.dart';

class LoadData extends StatelessWidget {
  const LoadData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect( 
          borderRadius: BorderRadius.circular(100),
          child: Shimmer(
            color: ColorManager.black,
            direction: const ShimmerDirection.fromLeftToRight(),
            child: const CircleAvatar(
              radius: AppSizes.s100,
              backgroundColor: ColorManager.white,
            ),
          ),
        ),
        const Line(),
        const Skeleton(height: AppSizes.s60),
         const SizedBox(
            height: AppSizes.s20
        ),
        const Skeleton(height: AppSizes.s60),
        const SizedBox(
            height: AppSizes.s20
        ),
        const Skeleton(height: AppSizes.s60),
        const SizedBox(
            height: AppSizes.s20
        ),
        const Skeleton(height: AppSizes.s60),
      ],
    );
  }
}

class DrawerLoading extends StatelessWidget {
  const DrawerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppSizes.s250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorManager.lightGrey,
                  radius: AppSizes.s50,
                ),
                SizedBox(width: AppSizes.s16,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(height: AppSizes.s15,width: AppSizes.s50,),
                    Skeleton(height: AppSizes.s10,width: AppSizes.s100,),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizes.s10,
          ),

        ],
      ),
    );
  }
}


class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  const Skeleton({Key? key, required this.height, this.width = double.infinity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect( 
        borderRadius: BorderRadius.circular(10),
        child: Shimmer(
            color: ColorManager.black,
            enabled: true,
            child: Container(height: height, width: width,)),
      ),
    );
  }
}