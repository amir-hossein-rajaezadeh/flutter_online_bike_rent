import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../models.dart';
import '../utils/constants/my_colors.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
              currentIndex: 0,
              bikes: getBikeList(),
              dragPositionCheckout: 0.0,
              dragPositionApply: 0,
              offCodeApplaied: false,
              showLikeAnim: false,
              likedItemIndex: -1),
        );
  final TextEditingController textController = TextEditingController();
  void likeItem(int index) {
    final updatedBikes = List<BikeModel>.from(state.bikes);
    updatedBikes[index] = BikeModel(
      updatedBikes[index].name,
      updatedBikes[index].model,
      updatedBikes[index].images,
      updatedBikes[index].price,
      !updatedBikes[index].isLiked,
      updatedBikes[index].desc,
      updatedBikes[index].buyCount,
    );

    emit(
      state.copyWith(
          bikes: updatedBikes, showLikeAnim: true, likedItemIndex: index),
    );
  }

  void setShowLikeAnim(bool value) {
    emit(
      state.copyWith(showLikeAnim: value),
    );
  }

  void addToCart(bool isAdd, int index) {
    final updatedBikes = List<BikeModel>.from(state.bikes);
    updatedBikes[index] = BikeModel(
      updatedBikes[index].name,
      updatedBikes[index].model,
      updatedBikes[index].images,
      updatedBikes[index].price,
      !updatedBikes[index].isLiked,
      updatedBikes[index].desc,
      isAdd
          ? updatedBikes[index].buyCount + 1
          : !isAdd && updatedBikes[index].buyCount == 0
              ? 0
              : updatedBikes[index].buyCount - 1,
    );
    emit(state.copyWith(bikes: updatedBikes));
  }

  void onDragUpdate(DragUpdateDetails details, BuildContext context) {
    emit(state.copyWith(
      dragPositionCheckout: state.dragPositionCheckout + details.delta.dx,
    ));
    if (state.dragPositionCheckout < 0) {
      emit(state.copyWith(dragPositionCheckout: 0));
    }
    if (state.dragPositionCheckout > 174 - 50) {
      emit(state.copyWith(dragPositionCheckout: 174 - 50));
    }
  }

  Future<void> onDragUpdateApply(
      DragUpdateDetails details, BuildContext context) async {
    final deviceWidth = (MediaQuery.of(context).size.width) - 40;
    if (textController.value.text.isNotEmpty) {
      emit(state.copyWith(
        dragPositionApply: state.dragPositionApply - details.delta.dx,
      ));
    } else {}
    if (state.dragPositionApply < 0) {
      emit(state.copyWith(dragPositionApply: 0));
    }
    if (state.dragPositionApply > deviceWidth - 114) {
      emit(state.copyWith(dragPositionApply: deviceWidth - 114));
      textController.clear();
      //Apply Button Dragges Suucessfully
      await Future.delayed(
        const Duration(milliseconds: 600),
      );
      var snackBar = const SnackBar(
        content: Text(
          'Discount Applied Successfully🥳🎉',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      emit(
        state.copyWith(offCodeApplaied: true, dragPositionApply: 0),
      );
      await Future.delayed(
        const Duration(milliseconds: 4400),
      );
      emit(state.copyWith(offCodeApplaied: false));
    } else {
      print('testtttt ${textController.value.text.isEmpty}');
      if (textController.value.text.isEmpty &&
          state.dragPositionApply < deviceWidth - 114) {
        showSnackBarWithThrottle(context);
      }
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
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                  repeat: true,
                  onLoaded: (p0) {},
                ),
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.darkBlueColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Coninue Shopping',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onDragEnd(DragEndDetails details, BuildContext context) {
    if (state.dragPositionCheckout >= 174 - 50) {
      emit(
        state.copyWith(dragPositionCheckout: 0),
      );
      _showCenteredDialog(context);
      // GoRouter.of(context).push('/checkout');
      print('checkout');
    } else {
      emit(
        state.copyWith(dragPositionCheckout: 0.0),
      );
    }
  }

  Future<void> onDragEndApply() async {
    await Future.delayed(const Duration(milliseconds: 450));
    emit(state.copyWith(dragPositionApply: 0));
  }

  DateTime? _lastSnackBarTime;

  void showSnackBarWithThrottle(BuildContext context) {
    final now = DateTime.now();
    if (_lastSnackBarTime == null ||
        now.difference(_lastSnackBarTime!) > const Duration(seconds: 2)) {
      var snackBar = const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          'Enter Discount Code to apply!',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _lastSnackBarTime = now;
    }
  }
}
