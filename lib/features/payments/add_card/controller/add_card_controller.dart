import 'dart:developer';

import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/features/payments/add_card/provider/add_card_provider.dart';

class AddCardController extends GetxController {
  AddCardProvider addCardProvider = AddCardProvider();
  var isShowLoader = false.obs;
  CardFormEditController cardFormEditController = CardFormEditController();
  CreditCardValidator ccValidator = CreditCardValidator();

  Rx<MaskedTextController> debitCardController =
      MaskedTextController(mask: CreditDebitMask.otherCreditDebitMask).obs;
  Rx<MaskedTextController> expiryController =
      MaskedTextController(mask: '00/00').obs;

  Rx<TextEditingController> cvvController = TextEditingController().obs;
  RxBool isCardValid = false.obs;

  RxBool isValidExpDate = false.obs;
  RxBool isCVVValid = false.obs;

  Rx<FocusNode> cvvNode = FocusNode().obs;
  Rx<FocusNode> cardNode = FocusNode().obs;
  Rx<FocusNode> expiryNode = FocusNode().obs;

  RxString cvvErrorMessage = "".obs;
  RxString cardErrorMessage = "".obs;
  RxString expiryErrorMessage = "".obs;

  Rx<CardFieldInputDetails> card =
      const CardFieldInputDetails(complete: false).obs;

  addFocusListeners() {
    cvvNode.value.addListener(() {
      cvvNode.refresh();
    });
    cardNode.value.addListener(() {
      cardNode.refresh();
    });
    expiryNode.value.addListener(() {
      expiryNode.refresh();
    });
  }

  disposeFocusListeners() {
    cvvNode.value.removeListener(() {});
    cardNode.value.removeListener(() {});
    expiryNode.value.removeListener(() {});
  }

  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  @override
  void onInit() {
    addFocusListeners();
    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  onChangeCardTextField({required String value}) {
    if (value.isNotEmpty && debitCardController.value.text.isEmail) {
      isCardValid.value = false;
    }

    if (debitCardController.value.text.length >= 2) {
      var firstLetter = debitCardController.value.text[0];
      var secondLetter = debitCardController.value.text[1];
      var mask = debitCardController.value.mask ?? "";

      if (firstLetter == "3" && (secondLetter == "4" || secondLetter == "7")) {
        if (mask != CreditDebitMask.americanExpressMask) {
          print("change mask");
          debitCardController.value.mask = CreditDebitMask.americanExpressMask;
        }
      } else if (firstLetter != "3") {
        if (mask != CreditDebitMask.otherCreditDebitMask) {
          print("change mask");
          debitCardController.value.mask = CreditDebitMask.otherCreditDebitMask;
        }
      }
      debitCardController.refresh();
    }

    // checkCardType(number);
    if (ccValidator.validateCCNum(debitCardController.value.text).isValid) {
      isCardValid.value = false;
    }
  }

  onChangeCVV({required String value}) {
    if (value.isNotEmpty && cvvController.value.text.isEmail) {
      isCVVValid.value = false;
    }

    if (cvvController.value.text.length < 3) {
      isCVVValid.value = false;
    }
    isCVVValid.refresh();
  }

  onChangeExpDate({required String value}) {
    if (value.isNotEmpty && expiryController.value.text.isEmail) {
      isValidExpDate.value = false;
    }

    if (ccValidator.validateExpDate(expiryController.value.text).isValid) {
      isValidExpDate.value = false;
    }
    isValidExpDate.refresh();
  }

  onTapADDButton() async {
    handleCreateTokenPress();
    // GetStripeToken(
    //     number: debitCardController.value.text,
    //     expirationMonth:
    //         int.parse(expiryController.value.text.substring(0, 2).toString()),
    //     expirationYear:
    //         int.parse(expiryController.value.text.substring(3, 5).toString()),
    //     // name: nameController.value.text,
    //     cvv: cvvController.value.text);
    // if (debitCardController.value.text.isEmpty &&
    //     cvvController.value.text.isEmpty &&
    //     expiryController.value.text.isEmpty) {
    //   isValidExpDate.value = true;
    //   isCVCValid.value = true;
    //   isDebitCardValid.value = true;
    // } else {
    //   if (debitCardController.value.isEmpty ||
    //       !ccValidator.validateCCNum(debitCardController.value).isValid) {
    //     isDebitCardValid.value = true;
    //   } else if (expiryController.value.text.isEmpty ||
    //       !ccValidator.validateExpDate(expiryController.value.text).isValid) {
    //     isValidExpDate.value = true;
    //   } else if (cvvController.text.isEmpty ||
    //       cvvController.value.text.length < 3) {
    //     isCVCValid.value = true;
    //   } else {
    //     if (Platform.isAndroid) {
    //       showLoaderAddAccount.value = true;
    //       GetStripeToken(
    //           number: debitCardController.value,
    //           expirationMonth: int.parse(
    //               expiryController.value.text.substring(0, 2).toString()),
    //           expirationYear: int.parse(
    //               expiryController.value.text.substring(3, 5).toString()),
    //           name: nameController.text,
    //           cvv: cvvController.value.text);
    //     } else if (Platform.isIOS) {
    //       // iOS-specific code
    //       showLoaderAddAccount.value = true;
    //       String? token = await getToken(
    //           platform: const MethodChannel('CFNG.app.share'),
    //           number: debitCardController.value,
    //           cvv: cvvController.value.text,
    //           year: int.parse(
    //               expiryController.value.text.substring(3, 5).toString()),
    //           month: int.parse(
    //               expiryController.value.text.substring(0, 2).toString()));
    //       if (token != "Failed") {
    //         var response = await addCardProvider
    //             .addCardMethod(stripeToken: token)
    //             .catchError((onError) {
    //           showLoaderAddAccount.value = false;
    //         });
    //         showLoaderAddAccount.value = false;
    //         if (response?.status == 1) {
    //           nameController.clear();
    //           debitCardController.clear();
    //           cvvController.clear();
    //           expiryController.clear();
    //           Get.back(result: [
    //             {"update": "update"}
    //           ]);
    //         } else {
    //           showLoaderAddAccount.value = false;
    //         }
    //       } else {
    //         showCommonAlertSingleButtonDialog(
    //             context: Get.context!,
    //             title: StringConstants.strError.tr,
    //             okPressed: () {
    //               Get.back();
    //             },
    //             subHeader: StringConstants.strSometingWentWrong.tr);
    //         showLoaderAddAccount.value = false;
    //       }
    //     }
    //   }
    // }
  }

  // Future GetStripeToken({
  //   String? number,
  //   String? cvv,
  //   String? name,
  //   int? expirationYear,
  //   int? expirationMonth,
  // }) async {
  //   print("genrate stripe token coming here ");

  //   // StripePayment.setOptions(StripeOptions(
  //   //     publishableKey: Stripe.publishableKey,
  //   //     merchantId: "production",
  //   //     androidPayMode: 'production'));
  //   StripePayment.setOptions(StripeOptions(
  //       publishableKey: Stripe.publishableKey,
  //       merchantId: "test",
  //       androidPayMode: 'test'));

  //   final CreditCard testCard = CreditCard(
  //       number: number,
  //       expMonth: expirationMonth,
  //       expYear: expirationYear,
  //       // name: "",
  //       cvc: cvv
  //       // addressLine1: 'Address 1',
  //       // addressLine2: 'Address 2',
  //       // addressCity: 'City',
  //       // addressState: 'CA',
  //       // addressZip: '1337',
  //       );
  //   setShowLoader(value: true);
  //   try {
  //     // PaymentMethod paymentMethod = PaymentMethod();
  //     Token token = await StripePayment.createTokenWithCard(testCard);

  //     print("token<<<<<< ${token.tokenId}");
  //     setShowLoader(value: false);
  //     // if (token.tokenId != null) {
  //     //   var body = json.encode({"card_element_token": token});

  //     //   var response =
  //     //       await addCardProvider.addCard(body: body).catchError((onError) {
  //     //     setShowLoader(value: false);

  //     //     snackbar(onError);
  //     //   });
  //     //   setShowLoader(value: false);
  //     //   if (response?.status == 1) {
  //     //     debitCardController.value.clear();
  //     //     cvvController.value.clear();
  //     //     expiryController.value.clear();
  //     //     Get.back(result: [
  //     //       {"update": "update"}
  //     //     ]);
  //     //   } else {
  //     //     setShowLoader(value: false);
  //     //     apiErrorDialog(
  //     //       message: response?.message ?? AppStrings.somethingWentWrong.tr,
  //     //       okButtonPressed: () {
  //     //         Get.back();
  //     //       },
  //     //     );
  //     //   }
  //     // } else {
  //     //   setShowLoader(value: false);
  //     // }
  //   } on PlatformException {}
  // }

  Future<void> handleCreateTokenPress() async {
    log("_handleCreateTokenPress ${card.value}");

    try {
      // 1. Gather customer billing information (ex. email)
      const address = Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ); // mocked data for tests

      // 2. Create payment method
      final tokenData = await Stripe.instance.createToken(
          const CreateTokenParams.card(
              params: CardTokenParams(address: address, currency: 'USD')));

      log("message  $tokenData");

      const SnackBar(
          content: Text("Success: The token was created successfully!"));

      return;
    } catch (e) {
      log("message $e");
      rethrow;
    }
  }
}
