import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/my_colors.dart';
import '../../utils/constants/my_strings.dart';

Container buidAppBarWidget(
    bool isOnMainPage, String text, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 40),
    child: isOnMainPage
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  MyStrings.chooseBike,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 44,
                width: 44,
                margin: const EdgeInsets.only(top: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [MyColors.lightBlueColor, MyColors.darkBlueColor],
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 26,
                ),
              )
            ],
          )
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: Container(
                    height: 44,
                    width: 44,
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
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 50),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
  );
}
