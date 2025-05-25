import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/products/controllers/add_product_controller.dart';
import 'package:afran_provider/products/widgets/product_status_bottom_sheet.dart';
import 'package:afran_provider/products/widgets/sizes_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class AddProductScreen extends StatelessWidget {
   AddProductScreen({super.key});

  List<String> options = ['دقائق','ساعات','أيام'];

   // AddProductController addProductController = Get.put(AddProductController(),permanent: true);
   final _formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
     AddProductController addProductController = Get.put(AddProductController(),);

     return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'أضف منتج'),

        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                      controller: addProductController.productNameController,
                      fieldLabel: 'أضف المنتج',
                      hintText: 'أدخل اسم المنتج',
                    validator: (value) => FormValidators.validateRequired(value, fieldName: ''),
                  ),
                  SizedBox(height: 16,),
                  Text('صورة المنتج',style: text70014,),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: addProductController.productImageController,
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            height: 44,width: 100,
                            child: MainAppButton(onPressed: () async{
                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg']
                              );
                              if(result != null){
                                addProductController.productImageController.text = result.files[0].name;
                                addProductController.filePickerResult = result;

                              }
                            },
                                icon: SvgPicture.asset(attach),

                                title: 'إرفاق')),
                      ),
                      hintText: 'صورة المنتج .JPG',
                      hintStyle: text50014.copyWith(color: grey3),
                      // prefixIcon: prefixIcon,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey2,width: 1.5), //
                        borderRadius: BorderRadius.circular(12),

                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color:grey2,width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkPurple,width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ///////////////////////////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0,bottom: 8),
                    child: Text('السعر و الاحجام المتاحة',style: text70014,),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container(child: AppTextField(
                        readOnly: true,
                        height: 56,
                        controller: addProductController.selectedSize,
                        onTap: (){
                           addProductController.getSizes();
                          SizesBottomSheet().openSizesSheet(context,addProductController,true);
                        },
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)
                          ,hintText: 'أدخل الجحم'))),
                      SizedBox(width: 8,),
                      Expanded(child: Container(child: AppTextField(
                          height: 56,

                          keyboardType: TextInputType.number,
                          inputFormatters:
                          [FilteringTextInputFormatter.digitsOnly],
                          controller: addProductController.enteredPrice,
                          hintText: 'أدخل سعر المنتج'))),
                      SizedBox(width: 8,),

                      InkWell(
                        onTap: (){
                          addProductController.addSize(context);
                        },
                        child: Container(
                          width: 63,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: darkPurple,

                          ),
                          child: Center(child: Text('أضف',style: text50014.copyWith(color: Colors.white),)),

                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 16,),
                  Obx((){
                    return  addProductController.addedSizes.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                        itemCount:addProductController.addedSizes.length ,
                        itemBuilder: (context,index){
                          return   Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              child: DecoratedBox(decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(16)
                              ),child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(addProductController.addedSizes[index]['name'],style: text50016,),
                                    Row(
                                      children: [
                                        Text(addProductController.addedSizes[index]['price']+' '+'ر.س',style: text70014.copyWith(color: darkPurple2),),
                                        SizedBox(width: 8,),
                                        InkWell(
                                          onTap: (){
                                            addProductController.addedSizes.removeAt(index);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: grey2,
                                              borderRadius: BorderRadius.circular(12),

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                                              child: Text('حذف',style: text50014.copyWith(color: grey3),),
                                            ),

                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),),

                            ),
                          );

                        }):SizedBox();
                  }),

                  SizedBox(height: 16,),
                  /////////////////////////////////DURATION/////////////////////////////
                  AppTextField(
                      validator: (value) => FormValidators.validateRequired(value, fieldName: ''),
                      keyboardType: TextInputType.number,
                      inputFormatters:
                      [FilteringTextInputFormatter.digitsOnly],
                      // onTap: (){
                      // addProductController.selectTime(context);
                      // },
                      controller: addProductController.durationController,
                      suffixIcon: Container(
                        width: 110,

                        child: DropdownButtonFormField<String>(
                          value: 'دقائق',
                          dropdownColor: Colors.white,
                          // itemHeight: 60,
                          icon: Icon(Icons.keyboard_arrow_down),
                          style: text70014.copyWith(color: grey3,fontFamily: 'Cairo'),
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            // filled: true,
                            // fillColor:grey2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: options.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(

                                  child: Text(value)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            addProductController.durationTypeController.text = newValue == 'أيام'?'day' :
                            newValue == 'دقائق'?'minute':"hour";
                           addProductController.durationType = newValue == 'أيام'?'day' :
                               newValue == 'دقائق'?'minute':"hour";
                          },
                        ),
                      ),

                      fieldLabel: 'وقت تحضير الطلب',
                      hintText: 'أدخل وقت تحضير الطلب'),
                  SizedBox(height: 16,),
                  AppTextField(
                      maxLines: 3,
                      minLines: 2,
                      height: 100,
                      validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

                      controller: addProductController.descriptionController,
                      fieldLabel: 'وصف المنتج',
                      hintText: 'أدخل وصف المنتج'),
                  SizedBox(height: 16,),
                  AppTextField(
                      readOnly: true,
                      controller: addProductController.statusController,
                      onTap: (){
                        ProductStatusBottomSheet().chooseProductStatus(context, addProductController,true);
                      },
                      validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

                      suffixIcon: Icon(Icons.keyboard_arrow_down,color: grey3,),
                      fieldLabel: 'حالة المنتج',
                      hintText: 'اختر حالة المنتج'),
                  SizedBox(height: 16,),
                  Text('خصص طلبك حسب رغبتك',style: text70016,),
                  SizedBox(height: 8,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container(child: AppTextField(
                        controller: addProductController.addonsNameController,
                          hintText: 'أدخل اسم المكون'))),
                      SizedBox(width: 8,),
                      Expanded(child: Container(child: AppTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters:
                          [FilteringTextInputFormatter.digitsOnly],
                          controller: addProductController.addonsPriceController,
                          hintText: 'أدخل سعر المنتج'))),
                      SizedBox(width: 8,),

                      InkWell(
                        onTap: (){
                          addProductController.addAddons(context);
                        },
                        child: Container(
                          width: 63,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: darkPurple,

                          ),
                          child: Center(child: Text('أضف',style: text50014.copyWith(color: Colors.white),)),

                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 16,),
                  Obx((){
                    return addProductController.addonsList.isNotEmpty? ListView.builder(
                      shrinkWrap: true,
                        itemCount:addProductController.addonsList.length ,
                        itemBuilder: (context,index){
                          List<dynamic>  addons =  addProductController.addonsList;
                      return SizedBox(
                        child: DecoratedBox(decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(16)
                        ),child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(addons[index]['name'],style: text50016,),
                              Row(
                                children: [
                                  Text('${addons[index]['price']}'+' '+'ر.س',style: text70014.copyWith(color: darkPurple2),),
                                  SizedBox(width: 8,),
                                  InkWell(
                                    onTap: (){
                                      addProductController.addonsList.removeAt(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: grey2,
                                        borderRadius: BorderRadius.circular(12),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                                        child: Text('حذف',style: text50014.copyWith(color: grey3),),
                                      ),

                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),),

                      );
                    }):SizedBox();
                  }),

                  SizedBox(height: 24,),
                  Obx((){
                    return addProductController.addProductLoading.value?Center(
                      child: Container(
                        height: 50,width: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                        )),
                    ) : MainAppButton(onPressed: () async{
                      final secureStorage = SecureStorageService();

                      String? hh = await secureStorage.read(userToken);
                      String? u = await secureStorage.read(user);
                      print('iiiiiiiii${hh}');
                      print('mmmmmmmmm${u}');
                      if (_formKey.currentState!.validate()) {
                        addProductController.addProduct(context);

                      }else{
                        const snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('يرجى إدخال البيانات المطلوبة'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    }, title: 'أضف المنتج');
                  })



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

