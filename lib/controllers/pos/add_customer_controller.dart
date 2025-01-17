import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddCustomerController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taxIDController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    taxIDController.dispose();
    phoneNumberController.dispose();
  }
}
