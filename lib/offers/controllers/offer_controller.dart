import 'dart:convert';

import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;


class OfferController extends GetxController{

  RxInt selectedId = (-1).obs;
  TextEditingController productController = TextEditingController();
  TextEditingController offerNameController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  RxBool addOfferLoading = false.obs;
  // RxInt selectedProduct = (-1).obs;

  addOffer(BuildContext context) async{
    // print(productNameController.text);
    // print(descriptionController.text);
    // print(durationController.text);
    // print(durationTypeController.text);
    // print(durationType);
    // print(selectedProductStatus.value);

    addOfferLoading.value = true;
    dio.FormData formData = dio.FormData.fromMap({
      'name': offerNameController.text,
      'description': descriptionController.text,
      'start_date': startTimeController.text,
      'end_date': endTimeController.text,
      'product_ids[]': selectedId.value.toString(),
      // 'product_ids[]': '8',
      'is_active': '1',
      'discount': offerPriceController.text

    });


    await DioClient().postAPI(
        addOfferApi,
        formData

    ).then((result) async{
      addOfferLoading.value = false;
      print(result.toString());
      // if(result != null && result['status'] == true){
        const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('تم إضافة العرض بنجاح'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.delete<OfferController>();
        final secureStorage = SecureStorageService();
        String? userData = await secureStorage.read(user);
        UserModel userModel = UserModel.fromJson(jsonDecode(userData!));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: userModel,)),
        );

      // }else {
      //   const snackBar = SnackBar(
      //       backgroundColor: Colors.red,
      //       content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى'));
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //
      // }
    }).catchError((error){
      addOfferLoading.value = false;
    });

    ///////////////////////////////////
    // final secureStorage = SecureStorageService();
    //
    // String? accessToken = await secureStorage.read(userToken);
    // String? u = await secureStorage.read(user);
    // print('6666666666${accessToken}');
    //
    //
    //////////////////////////////////

  }



}