import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yolo_app/utils/card_utils.dart';
import 'package:yolo_app/utils/constant.dart';
import 'package:yolo_app/widgets/cust_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFrozen = false;
  bool isCvvVisible = false;

  late String cardNum1;
  late String cardNum2;
  late String cardNum3;
  late String cardNum4;
  late String cardNumber;

  late String cardHolder;
  late String expiryDate;

  @override
  void initState() {
    super.initState();
    generateCardDetails();
  }

  void generateCardDetails() {
    final cardDetails = CardUtils.generateCardDetails();
    setState(() {
      cardNum1 = cardDetails['cardNum1']!;
      cardNum2 = cardDetails['cardNum2']!;
      cardNum3 = cardDetails['cardNum3']!;
      cardNum4 = cardDetails['cardNum4']!;
      cardNumber = cardDetails['cardNumber']!;
      cardHolder = cardDetails['cardHolder']!;
      expiryDate = cardDetails['expiryDate']!;
    });
  }

  Future<void> toggleFreeze() async {
    log('toggling freeze');
    await Future.delayed(const Duration(milliseconds: 300));
    log('delay ended');
    setState(() {
      isFrozen = !isFrozen;
    });
  }

  void toggleCvvVisibility() {
    setState(() {
      isCvvVisible = !isCvvVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YAppColors.backgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          CurvedNavigationBarItem(iconData: Icons.home, label: "home"),
          CurvedNavigationBarItem(iconData: Icons.settings, label: "ginie"),
        ],
        currentIndex: 2,
        onTap: (index) {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "select payment mode",
                style: GoogleFonts.poppins(
                  color: YAppColors.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.17,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "choose your preferred payment method to make payment.",
                style: GoogleFonts.poppins(
                  color: YAppColors.textColor.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: -0.17,
                ),
              ),
              const SizedBox(height: 24),
              payButtonRow(),
              const SizedBox(height: 48),
              Text(
                "YOUR DIGITAL DEBIT CARD",
                style: GoogleFonts.poppins(
                  color: YAppColors.whiteColor.withOpacity(0.3),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.17,
                ),
              ),
              const SizedBox(height: 16),
              //freezing and unfreezing card
              Row(
                children: [
                  GestureDetector(
                    onTap: toggleFreeze,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),

                      //
                      onEnd: () {
                        if (isFrozen) {}
                      },
                      //
                      curve: Curves.easeInOut,
                      width: 186,
                      height: 296,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(
                            isFrozen
                                ? 'assets/images/card_images/bg_normal1.png'
                                : 'assets/images/card_images/bg_frozen1.png',
                          ),
                          fit: BoxFit.fill,
                          colorFilter: isFrozen
                              ? ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken,
                                )
                              : ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.difference,
                                ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: isFrozen
                          ? Container(
                              width: 186,
                              height: 296,
                              padding: const EdgeInsets.fromLTRB(
                                14,
                                14,
                                10,
                                18,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: const Alignment(0, -1),
                                  end: const Alignment(0, 0.32),
                                  colors: [
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.9),
                                  ],
                                ),
                                border: Border.all(
                                  strokeAlign: BorderSide.strokeAlignInside,
                                  color:
                                      YAppColors.whiteColor.withOpacity(0.25),
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 0,
                                    color: YAppColors.cardBorderGradient
                                        .withOpacity(0.7),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/card_images/Yolo_logo.png',
                                        width: 50,
                                        height: 16,
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/images/card_images/yes_bank_logo.png',
                                        width: 50,
                                        height: 21,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 42),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // left column

                                        Column(
                                          children: [
                                            custCardText(cardNum1),
                                            const SizedBox(height: 5),
                                            custCardText(cardNum2),
                                            const SizedBox(height: 5),
                                            custCardText(cardNum3),
                                            const SizedBox(height: 5),
                                            custCardText(cardNum4),
                                          ],
                                        ),
                                        // right column
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'expiry',
                                              style: GoogleFonts.poppins(
                                                color: YAppColors.whiteColor
                                                    .withOpacity(0.5),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.17,
                                              ),
                                            ),
                                            Text(
                                              expiryDate,
                                              style: GoogleFonts.poppins(
                                                color: YAppColors.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.17,
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'CVV',
                                                  style: GoogleFonts.poppins(
                                                    color: YAppColors.whiteColor
                                                        .withOpacity(0.5),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: -0.17,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      isCvvVisible
                                                          ? '123'
                                                          : '***',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: isCvvVisible
                                                            ? YAppColors
                                                                .whiteColor
                                                            : YAppColors
                                                                .whiteColor
                                                                .withOpacity(
                                                                    0.3),
                                                        fontSize: isCvvVisible
                                                            ? 18
                                                            : 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.17,
                                                      ),
                                                    ),
                                                    //eye icon for hiding and unhiding cvv
                                                    GestureDetector(
                                                      onTap:
                                                          toggleCvvVisibility,
                                                      child: Icon(
                                                        isCvvVisible
                                                            ? Iconsax.eye_slash
                                                            : Iconsax.eye,
                                                        size: 24,
                                                        color: YAppColors
                                                            .mainRedColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        //empty container for spacing
                                        Container(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      const Icon(
                                        Iconsax.document_copy,
                                        color: YAppColors.mainRedColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'copy details',
                                        style: GoogleFonts.poppins(
                                          color: YAppColors.mainRedColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  //Rupay logo
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        'assets/images/card_images/Rupay.png',
                                        width: 72,
                                        height: 34,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [],
                            ),
                    ),
                  ),
                  //
                  const SizedBox(width: 12),
                  //freeze and unfreeze Button
                  GestureDetector(
                    onTap: toggleFreeze,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: YAppColors.backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.inner,
                                spreadRadius: 0.6,
                                color: isFrozen
                                    ? YAppColors.whiteColor.withOpacity(0.35)
                                    : YAppColors.mainRedColor.withOpacity(0.7),
                                offset: const Offset(0, -1),
                                blurRadius: 0.5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.ac_unit,
                            size: 20,
                            color: isFrozen
                                ? YAppColors.whiteColor
                                : YAppColors.mainRedColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          isFrozen ? "freeze" : "unfreeze",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.17,
                            color: isFrozen
                                ? YAppColors.whiteColor
                                : YAppColors.mainRedColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row payButtonRow() {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: YAppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(
                strokeAlign: BorderSide.strokeAlignInside,
                width: 1.5,
                color: YAppColors.whiteColor.withOpacity(0.2),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            "pay",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.17,
              color: YAppColors.whiteColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: YAppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(
                strokeAlign: BorderSide.strokeAlignInside,
                width: 1.5,
                color: YAppColors.mainRedColor.withOpacity(0.2),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            "card",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.17,
              color: YAppColors.mainRedColor,
            ),
          ),
        ),
      ],
    );
  }

  Text custCardText(String cardNum) {
    return Text(
      cardNum,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Kredit',
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
