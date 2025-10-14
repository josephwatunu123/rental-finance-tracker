import 'package:flutter/cupertino.dart';
import 'package:rental_finance_tracker/services/snackbar_service.dart';

import 'functions.dart';

mixin FormFieldsMixin{
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final paymentRefController = TextEditingController();
  final notesController = TextEditingController();
  final reminderController = TextEditingController();

  void clearControllers() {
    nameController.clear();
    amountController.clear();
    paymentRefController.clear();
    notesController.clear();
    reminderController.clear();
  }

  void disposeControllers() {
    nameController.dispose();
    amountController.dispose();
    paymentRefController.dispose();
    notesController.dispose();
    reminderController.dispose();
  }

  Map<String, String?> validateCommonFields({required String? paymentMethod}) {
    return {
      'nameErr': textFormValidator(nameController.text),
      'amountErr': intValidator(amountController.text),
      'paymentRefErr': nonNullTextValidator(paymentRefController.text),
      'paymentMethodErr':
      paymentMethod == null ? 'Select payment method' : null,
    };
  }

  void showErrorSnack(String title) {
    SnackBarService.show(
      message: 'Please fill all the fields',
      title: title,
      snackBarType: SnackBarType.error,
    );
  }

}