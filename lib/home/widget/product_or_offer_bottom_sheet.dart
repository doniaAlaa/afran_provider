import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/offers/screens/add_offer_screen.dart';
import 'package:afran_provider/products/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductOrOfferBottomSheet{

  int selectedType = -1;
  chooseProductOffer(BuildContext context){

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {

        return StatefulBuilder(
          builder: (context,setState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: Colors.white,

                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 30),
                          child:  Container(
                            // height: 400,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() => selectedType = 0);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  AddProductScreen()),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 56,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: selectedType == 0 ?darkPurple:Colors.white,
                                      border: Border.all(color: grey,width: 2)
                                    ),child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('أضافة منتجات',style: text50014.copyWith(color: selectedType == 0 ?Colors.white: Colors.black),),
                                          Icon(Icons.add,color: selectedType == 0 ?Colors.white:darkPurple)
                                        ],
                                      ),
                                    ),),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                InkWell(
                                  onTap: (){
                                    setState(() => selectedType = 1);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  AddOfferScreen()),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 56,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: selectedType == 1 ?darkPurple:Colors.white,
                                        border: Border.all(color: grey,width: 2)
                                    ),child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('أضافة عروض',style: text50014.copyWith(color:  selectedType == 1 ?Colors.white: Colors.black),),
                                          Icon(Icons.add,color: selectedType == 1 ?Colors.white:darkPurple,)
                                        ],
                                      ),
                                    ),),
                                  ),
                                ),


                              ],
                            )
                          )
                      )

                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );

  }
}