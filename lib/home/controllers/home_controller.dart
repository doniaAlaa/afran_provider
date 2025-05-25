import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxBool loading = false.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;

  getProducts() async{
    loading.value = true;
    await DioClient().getAPI(
        '${baseUrl}/products?lat=29.786005&long=31.306943',

    ).then((result) async {
      if(result['status'] == true){
        products.clear();
        List<dynamic> data = result['data'];
        print('nnnnnnnnnnnn${data.length}');

        try{
            data.forEach((e){
              products.add(ProductModel.fromJson(e));
            });
            print('object');
          }catch(e){
            print(',,,,,,,,,,,,,${e}');
          }



      }
      loading.value = false;
    }).catchError((err){
      loading.value = false;

    });
  }

  deleteProductItem(int productId,BuildContext context) async{
    // loading.value = true;
    await DioClient().deleteAPI(
        '${baseUrl}/products/$productId',

    ).then((result) async {
      if(result['status'] == true){
        const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('تم حذف المنتج بنجاح'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        getProducts();

      }
      // loading.value = false;
    }).catchError((err){
      // loading.value = false;

    });
  }

}