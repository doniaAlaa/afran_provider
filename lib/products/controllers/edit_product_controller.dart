import 'dart:convert';
import 'dart:io';

import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/products/models/size_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class EditProductController extends GetxController{

  RxBool sizeLoading = false.obs;
  RxBool addProductLoading = false.obs;
  RxList<SizeModel> sizes  = <SizeModel>[].obs;
  RxList<SizesAndAddons> addedSizes = <SizesAndAddons>[].obs;
  RxList<SizesAndAddons> addonsList = <SizesAndAddons>[].obs;
  // RxList<dynamic> addonsList = <dynamic>[].obs;


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
  }
  @override
  void onClose() {
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

  editProduct(BuildContext context,int productId) async{
    print(productNameController.text);
    print(descriptionController.text);
    print(durationController.text);
    print(durationTypeController.text);
    print(durationType);
    print(selectedProductStatus.value);
    String durationEngType = durationType == 'أيام'?'day' :
    durationType == 'دقائق'?'minute':"hour";
    // addProductLoading.value = true;
    dio.FormData formData = dio.FormData.fromMap({
      "name":productNameController.text,
      "description":descriptionController.text,
      "duration":durationController.text,
      "duration_type": durationEngType,
      "is_active":selectedProductStatus.value,
      '_method': 'PUT',
      // "image": await MultipartFile.fromFile(filePath, filename: fileName),

    });

    for (int i = 0; i < addedSizes.length; i++) {
      formData.fields.add(MapEntry("sizes[$i][id]", addedSizes[i].id.toString()));
      formData.fields.add(MapEntry("sizes[$i][price]", addedSizes[i].price.toString()));
    };
    for (int i = 0; i < addonsList.length; i++) {
      print(',,,,,,,,,,,,,,,,${addonsList[i].name}');
      formData.fields.add(MapEntry("addons[$i][name]", addonsList[i].name.toString()));
      formData.fields.add(MapEntry("addons[$i][price]", addonsList[i].price.toString()));
    };

    await DioClient().postAPI(
        '${baseUrl}/products/$productId',
        formData

    ).then((result) async{
      addProductLoading.value = false;
      if(result != null && result['status'] == true){
        const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('تم تعديل المنتج بنجاح'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.delete<EditProductController>();
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
  }


  addSize(BuildContext context){
    if(selectedSizeId == -1 || enteredPrice.text.trim().isEmpty){
      const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('يرجى إدخال الحجم والسعر معا'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else{

      addedSizes.add(SizesAndAddons(
        id: selectedSizeId.value,
        price: enteredPrice.text,
        name: selectedSize.text
      ));
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

      addonsList.add(SizesAndAddons(
          // id: se.value,
          name: addonsNameController.text,
          price: addonsPriceController.text,

      ));
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