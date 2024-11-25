import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bike_shopping/models.dart';
import 'package:online_bike_shopping/screens/shared_widgets/appbar_widget.dart';
import 'package:online_bike_shopping/utils/constants/my_colors.dart';
import 'package:online_bike_shopping/utils/constants/my_strings.dart';
import '../cubit/app_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 60, left: 20),
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/images/backgr_img.png'),
              ),
              Column(
                children: [
                  buidAppBarWidget(true, '', context),
                  ClipPath(
                    clipper: CustomShapeClipperBanner(),
                    child: Container(
                      height: 230,
                      margin: const EdgeInsets.only(top: 30),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 14,
                            sigmaY: 14,
                          ),
                          child: _buildBannerWidget(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 48),
                      child: BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.71,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: state.bikes.length,
                            itemBuilder: (context, index) {
                              final bikeItem = state.bikes[index];
                              return bikeItemWidget(bikeItem, index, context);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildCategotyFilterItem(0),
                    _buildCategotyFilterItem(1),
                    _buildCategotyFilterItem(2),
                    _buildCategotyFilterItem(3),
                    _buildCategotyFilterItem(4),
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 100,
            color: MyColors.bottomDarkColor,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            height: 90,
            child: Container(
              margin: const EdgeInsets.only(left: 34, bottom: 10),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ClipPath(
                      clipper: CustomShapeClipperItem(),
                      child: Container(
                        width: 55,
                        height: 50,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.darkBlueColor,
                              MyColors.lightBlueColor,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset('assets/icons/bicycle.svg'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 34),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: MyStrings.bottomNavIconList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(right: 55),
                                child: SvgPicture.asset(
                                  MyStrings.bottomNavIconList[index],
                                  height: 22,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bikeItemWidget(BikeModel bikeItem, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/item_detail', extra: bikeItem);
      },
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShapeClipper(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              color: Colors.transparent.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 8, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            context.read<AppCubit>().likeItem(index);
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 13, top: 12),
                                child: Icon(
                                  bikeItem.isLiked
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: Colors.white,
                                ),
                              ),
                              if (state.showLikeAnim &&
                                  bikeItem.isLiked &&
                                  state.likedItemIndex == index)
                                Lottie.asset(
                                    'assets/animations/like_white_heart.json',
                                    onLoaded: (p0) async {
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                  );
                                  context
                                      .read<AppCubit>()
                                      .setShowLikeAnim(false);
                                },
                                    repeat: false,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover)
                              else
                                const SizedBox(
                                  width: 50,
                                  height: 50,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Image.asset(
                        bikeItem.images.first,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 14,
                      left: 18,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      bikeItem.name,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4, left: 18),
                    child: Text(
                      bikeItem.model,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 18, top: 4),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${bikeItem.price.round()}\$',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerWidget() {
    return SizedBox(
      width: 400,
      child: Center(
        child: ClipPath(
          clipper: CustomShapeClipperBanner(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.1),
              border: Border.all(
                  color: Colors.grey.withOpacity(
                    0.5,
                  ),
                  width: 0.2),
            ),
            width: 400,
            height: 260,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 18),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/bike_banner.png',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 0, left: 16),
                      child: Text(
                        '30% off',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildCategotyFilterItem(int index) {
    return Container(
      margin: EdgeInsets.only(
          right: 26,
          top: index == 4
              ? 0
              : index == 3
                  ? 20
                  : index == 2
                      ? 40
                      : index == 1
                          ? 60
                          : 80),
      width: 57,
      height: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.4),
          )
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: index == 0
                ? MyColors.selectedItemColorGradiunt
                : MyColors.unSelectedItemkColorGradiunt),
      ),
      child: Center(
        child: index == 0
            ? const Text(
                'All',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              )
            : Image.asset(
                MyStrings.iconList[index],
              ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 20.0;

    path.moveTo(0, 24.6); // Start with top-left rounded corner
    path.lineTo(0, size.height - radius); // Left side
    path.arcToPoint(
      Offset(radius, size.height),
      radius: const Radius.circular(radius),
      clockwise: false,
    ); // path.lineTo(0, size.height - radius); // Left side

    path.lineTo(size.width - radius, 245); // Right side shorter height
    path.arcToPoint(
      Offset(size.width, 230),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width, radius);
    path.arcToPoint(
      Offset(size.width - radius, 0),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.moveTo(radius + 7,
        22); // Start slightly to the right, creating space for the arc
    path.arcToPoint(const Offset(-1, 29),
        radius: const Radius.circular(radius),
        clockwise: false); // Top-left corner ar

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomShapeClipperItem extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 6.0;

    path.moveTo(0, 16); // Start with top-left rounded corner
    path.lineTo(0, size.height); // Left side
    path.arcToPoint(
      Offset(radius, size.height),
      radius: const Radius.circular(radius),
      clockwise: false,
    ); // path.lineTo(0, size.height - radius); // Left side

    path.lineTo(size.width - radius, 40); // Right side shorter height
    path.arcToPoint(
      Offset(size.width, 34),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width, radius);
    path.arcToPoint(
      Offset(size.width - radius, 5),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.moveTo(radius + 8,
        26); // Start slightly to the right, creating space for the arc
    path.arcToPoint(const Offset(-1, 32),
        radius: const Radius.circular(radius + 7),
        clockwise: false); // Top-left corner ar

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomShapeClipperBanner extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 16.0;

    path.moveTo(0, radius); // Start with top-left rounded corner
    path.lineTo(0, size.height - radius); // Left side
    path.arcToPoint(
      Offset(radius, size.height),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width - radius, 218); // Right side shorter height
    path.arcToPoint(
      Offset(size.width, 200),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width, radius);
    path.arcToPoint(
      Offset(size.width - radius, 0),
      radius: const Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(radius, 0);
    path.arcToPoint(
      const Offset(0, radius),
      radius: const Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
