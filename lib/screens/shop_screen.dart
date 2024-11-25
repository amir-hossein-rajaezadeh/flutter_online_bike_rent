import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:online_bike_shopping/cubit/app_cubit.dart';
import 'package:online_bike_shopping/models.dart';
import 'package:online_bike_shopping/screens/shared_widgets/appbar_widget.dart';
import 'package:online_bike_shopping/utils/constants/my_colors.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              buidAppBarWidget(false, 'My Shopping Cart', context),
              SizedBox(
                height: 450,
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 28),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    height: 0.2,
                    color: Colors.white.withOpacity(0.5),
                    width: double.infinity,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: getBikeList().length,
                  itemBuilder: (context, index) {
                    final bikeItem = getBikeList()[index];

                    return Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [
                                  MyColors.mediumGreyColor,
                                  MyColors.lightGreyColor
                                ],
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Image.asset(bikeItem.images.first),
                            ),
                          ),
                          Container(
                            height: 90,
                            margin: const EdgeInsets.only(left: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    bikeItem.model,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Text.rich(
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.mediumBlueColor),
                                          TextSpan(
                                            text: '\$ ',
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: bikeItem.price.toString(),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: MyColors
                                                        .mediumBlueColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _buildAddBtn(true, index, context),
                                          BlocBuilder<AppCubit, AppState>(
                                            builder: (context, state) {
                                              return Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  state.bikes[index].buyCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                      fontSize: 17),
                                                ),
                                              );
                                            },
                                          ),
                                          _buildAddBtn(false, index, context),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 0.2,
                color: Colors.white.withOpacity(0.5),
                width: double.infinity,
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Text(
                  "Your cart qualifies for free shipping",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20, top: 14),
                child: Column(
                  children: [
                    applyDragWidget(
                        const Text(
                          "Apply",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        'Bike 30',
                        context),
                    infoAndPaymentsWIdget()
                  ],
                ),
              ),
              checkoutDragWidget(
                const Icon(Icons.arrow_forward, color: Colors.white),
                "CheckOut",
                (details) =>
                    context.read<AppCubit>().onDragEnd(details, context),
              ),
            ],
          ),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 45),
                    alignment: Alignment.center,
                    child: state.offCodeApplaied
                        ? Lottie.asset(
                            'assets/animations/congrats.json',
                            alignment: Alignment.center,
                          )
                        : null),
              );
            },
          )
        ],
      ),
    );
  }

  Stack applyDragWidget(
      Widget centerWidget, String text, BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 62,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: -4,
              ),
              const BoxShadow(
                color: Color(0xFF242C3B),
                spreadRadius: -5.0,
                offset: Offset(0, 3),
                blurRadius: 20.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 12),
            child: TextFormField(
              controller: context.read<AppCubit>().textController,
              style: const TextStyle(
                color: Colors.grey,
              ),
              decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                  hintText: 'Bike 30',
                  contentPadding: EdgeInsets.only(left: 12, bottom: 8),
                  enabledBorder: InputBorder.none),
            ),
          ),
        ),
        BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Positioned(
              right: state.dragPositionApply,
              child: GestureDetector(
                onHorizontalDragEnd: (details) =>
                    context.read<AppCubit>().onDragEndApply(),
                onHorizontalDragUpdate: (details) => context
                    .read<AppCubit>()
                    .onDragUpdateApply(details, context),
                // onHorizontalDragStart: (details) => dragStart,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 50,
                    width: 114,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          MyColors.lightBlueColor,
                          MyColors.darkBlueColor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: centerWidget)),
              ),
            );
          },
        ),
      ],
    );
  }

  Stack checkoutDragWidget(
      Widget centerWidget, String text, GestureDragEndCallback dragEnd) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 62,
          width: 174,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: -4,
              ),
              const BoxShadow(
                color: Color(0xFF242C3B),
                spreadRadius: -5.0,
                offset: Offset(0, 4),
                blurRadius: 20.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6), fontSize: 16),
              ),
            ),
          ),
        ),
        BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Positioned(
              left: state.dragPositionCheckout,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  context.read<AppCubit>().onDragUpdate(details, context);
                },
                onHorizontalDragEnd: dragEnd,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          MyColors.lightBlueColor,
                          MyColors.darkBlueColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: centerWidget),
              ),
            );
          },
        ),
      ],
    );
  }

  Column infoAndPaymentsWIdget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\$6119.99',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6), fontSize: 15),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Fee:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\$0',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6), fontSize: 15),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discount:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '30%',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6), fontSize: 15),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\$4,283.99',
                style: TextStyle(
                    fontSize: 17,
                    color: MyColors.lightBlueColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddBtn(bool isAdd, int index, BuildContext context) {
    List<Color> addButtonGradiunt = [
      MyColors.darkBlueColor,
      MyColors.lightBlueColor,
    ];
    List<Color> minusButtonGradiunt = [
      Colors.white.withOpacity(0.2),
      Colors.white.withOpacity(0.2)
    ];

    return GestureDetector(
      onTap: () {
        context.read<AppCubit>().addToCart(isAdd, index);

        print('called');
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: isAdd ? addButtonGradiunt : minusButtonGradiunt),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Icon(
            isAdd ? Icons.add : CupertinoIcons.minus,
            size: 22,
            color: isAdd ? Colors.white : Colors.white.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

void _showCenteredDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: MyColors.backgroundColor, // Use your app's color
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Order Confirmation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(height: 10),
              Text(
                'Your order has been successfully placed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // Lottie animation for success
              Lottie.asset(
                  'assets/animations/checkout.json', // Make sure you have this animation
                  width: 200,
                  height: 200,
                  onLoaded: (p0) {},
                  repeat: true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      MyColors.lightBlueColor, // Use your app's button color
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
