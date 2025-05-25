import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:afran_provider/profile/controllers/my_orders_controller.dart';
import 'package:afran_provider/profile/widgets/orders/order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
   OrdersScreen({super.key});

  MyOrdersController myOrdersController = Get.put(MyOrdersController());
  @override
  Widget build(BuildContext context) {
    myOrdersController.getMyOrders();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'الطلبات'),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
          child: Obx((){
            return myOrdersController.loading.value? Center(
              child: Container(
                  height: 50,width: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                  )),
            ): ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: OrderItem(),
                  );
                });
          }),
        ),
      ),
    );
  }
}

