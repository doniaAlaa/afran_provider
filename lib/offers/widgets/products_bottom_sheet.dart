import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/home/controllers/home_controller.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/offers/controllers/offer_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetProductsBottomSheet{

  getProducts(BuildContext context,OfferController offerController){
    HomeController controller = Get.put(HomeController());
    controller.getProducts();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("اختر المنتج",style: text70016,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
                    child: Obx((){
                      return controller.loading.value? CircularProgressIndicator(color: darkPurple,strokeWidth: 1.6,):

                      Container(
                        height: 180,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            itemBuilder: (context,index){
                              List<ProductModel> categories = controller.products;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                    onTap: (){
                                      // controller.se.value = categories[index].id??-1;
                                      offerController.selectedId.value = controller.products[index].id??-1;
                                      offerController.productController.text = controller.products[index].name??'';
                                    },
                                    child: Obx((){
                                      return Row(
                                        children: [
                                          Container(
                                            height: 20,width: 20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: darkPurple)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                height: 15,width: 15,

                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:offerController.selectedId.value == controller.products[index].id? darkPurple:null
                                                ),),
                                            ),
                                          ),
                                          SizedBox(width: 16,),
                                          Text(categories[index].name??''),
                                        ],
                                      );
                                    })
                                ),
                              );
                            }),
                      );
                    }),
                  )

                ],
              ),
            ),
          ),
        );
      },
    );

  }

}