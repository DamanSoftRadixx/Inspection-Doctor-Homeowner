import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var isShowLoader = false.obs;
  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  Future<void> displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet(
          options: const stripe.PaymentSheetPresentOptions(timeout: 1200000));

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Payment successfully completed'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

  Future<void> initPaymentSheet() async {
    try {
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: const stripe.SetupPaymentSheetParameters(
          customFlow: true,
          merchantDisplayName: 'Flutter Stripe Demo',
          paymentIntentClientSecret: "",
          customerEphemeralKeySecret: "",
          customerId: "",
          setupIntentClientSecret: "",
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }
}
