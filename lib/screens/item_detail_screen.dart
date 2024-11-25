import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_bike_shopping/models.dart';
import 'package:online_bike_shopping/screens/shared_widgets/appbar_widget.dart';
import 'package:online_bike_shopping/utils/constants/my_colors.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.bikeItem});
  final BikeModel bikeItem;

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[MyColors.lightBlueTextColor, MyColors.darkBlueTextColor],
    ).createShader(
      const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
    );
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 290),
            alignment: Alignment.bottomRight,
            child: Image.asset('assets/images/backgr2.png'),
          ),
          Column(
            children: [
              buidAppBarWidget(false, bikeItem.model, context),
              Container(
                width: double.infinity,
                height: 190,
                margin: const EdgeInsets.only(top: 80, right: 22, left: 22),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1200),
                    height: 200.0,
                    autoPlay: true,
                    viewportFraction: 0.66,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {},
                  ),
                  items: bikeItem.images.map((bikeImage) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            bikeImage,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height / 1.8,
                child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [MyColors.lightBlack, MyColors.mediumBlack]),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      border: Border.all(
                        width: 1.3,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, top: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColors.bottomDarkColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 1.2,
                                      offset: const Offset(2, 4),
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 0.2,
                                      offset: const Offset(-1, -1),
                                      color: Colors.white.withOpacity(0.1),
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 2,
                                        offset: const Offset(2, 2),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.bottomDarkColor),
                                margin: const EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(
                                        "Specification",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 29, left: 20),
                          alignment: Alignment.topLeft,
                          child: Text(
                            bikeItem.model,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6, left: 20),
                          alignment: Alignment.topLeft,
                          child: Text(
                            bikeItem.desc,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 5, right: 3, left: 3),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 35, left: 35, top: 30, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '\$',
                                      style: TextStyle(
                                          color: MyColors.mediumBlueColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      bikeItem.price.toString(),
                                      style: const TextStyle(
                                          color: MyColors.mediumBlueColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.push(
                                      '/shop',
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          MyColors.lightBlueColor,
                                          MyColors.darkBlueColor
                                        ],
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 40),
                                      child: Center(
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
