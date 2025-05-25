import 'dart:convert';
import 'dart:io';

import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/products/models/size_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AddProductController extends GetxController{

  RxBool sizeLoading = false.obs;
  RxBool addProductLoading = false.obs;
  RxList<SizeModel> sizes  = <SizeModel>[].obs;
  RxList<dynamic> addedSizes = <dynamic>[].obs;
  RxList<dynamic> addonsList = <dynamic>[].obs;


  TextEditingController productNameController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController addonsPriceController = TextEditingController();
  TextEditingController addonsNameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController durationTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  String durationType = 'minute';
  RxInt selectedSizeId =(-1).obs;
  RxInt selectedProductStatus = (-1).obs;
  // String selected = 'minute';

  TextEditingController selectedSize= TextEditingController();
  TextEditingController enteredPrice = TextEditingController();
  FilePickerResult? filePickerResult;

  @override
  void onInit() {
    super.onInit();

    // Your initialization logic here
    print("Controller initialized");
  }
  @override
  void onClose() {
    print('Controller is being disposed!');
    super.onClose();
  }
  getSizes() async{
    sizeLoading.value = true;

    await DioClient().getAPI(
        sizesApi,


    ).then((result) async{
      sizeLoading.value = false;
      if(result != null && result['status'] == true){
       List<dynamic> data = result['data'];
       sizes.clear();
       data.forEach((e){
         sizes.add(SizeModel.fromJson(e));
       });

      }else {}
    }).catchError((error){
      sizeLoading.value = false;
    });
  }

  addProduct(BuildContext context) async{
    // print(productNameController.text);
    // print(descriptionController.text);
    // print(durationController.text);
    // print(durationTypeController.text);
    // print(durationType);
    // print(selectedProductStatus.value);
    addProductLoading.value = true;
    dio.FormData formData = dio.FormData.fromMap({
      "name":productNameController.text,
      "description":descriptionController.text,
      "sizes":addedSizes,
      "addons":addonsList,
      "duration":durationController.text,
      "duration_type":durationType,
      "is_active":selectedProductStatus.value,
      // "image": await MultipartFile.fromFile(filePath, filename: fileName),

    });


    await DioClient().postAPI(
        addProductApi,
        formData

    ).then((result) async{
      addProductLoading.value = false;
      if(result != null && result['status'] == true){
        const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('تم إضافة المنتج بنجاح'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.delete<AddProductController>();
        final secureStorage = SecureStorageService();
        String? userData = await secureStorage.read(user);
        UserModel userModel = UserModel.fromJson(jsonDecode(userData!));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: userModel,)),
        );

      }else {
        const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    }).catchError((error){
      addProductLoading.value = false;
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


  addSize(BuildContext context){
    if(selectedSizeId == -1 || enteredPrice.text.trim().isEmpty){
      const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('يرجى إدخال الحجم والسعر معا'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else{
      addedSizes.add({
        "id":selectedSizeId.value,
        "price":enteredPrice.text,
        "name":selectedSize.text
      });
      selectedSize.clear();
      enteredPrice.clear();
      selectedSizeId.value = -1.obs;
    }

  }

  addAddons(BuildContext context){
    if(addonsPriceController.text.trim().isEmpty || addonsNameController.text.trim().isEmpty){
      const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('يرجى إدخال اسم المكون والسعر معا'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else{
      addonsList.add({
        "name":addonsNameController.text,
        "price":addonsPriceController.text,
      });
      addonsPriceController.clear();
      addonsNameController.clear();
    }

  }


  ///////////////////////////////////////////////////////////////
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      durationController.text = picked.format(context);
      // setState(() {
      //   _selectedTime = picked;
      // });
    }
  }

  /////////////////////////////PRODUCT STATUS/////////////////////////////////

  selectProductStatus(int index){
    selectedProductStatus.value = index;
    statusController.text = index == 1? 'متاح':"غير متاح";
  }


}