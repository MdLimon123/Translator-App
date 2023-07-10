import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TranslateController extends GetxController {
  TextEditingController controller = TextEditingController(text: 'How are you');
  final formKey = GlobalKey<FormState>();
  final translator = GoogleTranslator();
  var isLoading = false.obs;
  String from = 'en';
  String to = 'bn';
  String data = 'কেমন আছেন?';
  var selectedValue = "English".obs;
  var selecedValue2 = "Bangla".obs;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  translate(context) async {
    try {
      if (formKey.currentState!.validate()) {
        await translator
            .translate(controller.text, from: from, to: to)
            .then((value) {
          data = value.text;
          isLoading.value = false;
        });
      }
    } on SocketMessage catch (_) {
      isLoading.value = true;
      SnackBar snackBar = const SnackBar(
        content: Text('Internet not Connceted'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
