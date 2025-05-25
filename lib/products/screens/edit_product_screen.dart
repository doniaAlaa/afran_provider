import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/products/controllers/edit_product_controller.dart';
import 'package:afran_provider/products/widgets/product_status_bottom_sheet.dart';
import 'package:afran_provider/products/widgets/sizes_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  EditProductScreen( {super.key,required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  List<String> options = ['دقائق','ساعات','أيام'];
  String optionsInitialVal = 'دقائق';

  // AddProductController addProductController = Get.put(AddProductController(),permanent: true);
  final _formKey = GlobalKey<FormState>();
  EditProductController editProductController = Get.put(EditProductController(),);


  @override
  void initState() {
    super.initState();
    editProductController.productNameController.text = widget.product.name??'';
    editProductController.durationController.text = widget.product.duration.toString()??'';
    print('............${widget.product.duration_type??''}');
    optionsInitialVal = widget.product.duration_type == 'hour'? 'ساعات':widget.product.duration_type == 'minute'?'دقائق':"أيام" ;
    editProductController.durationTypeController.text = widget.product.duration_type??'';
    editProductController.statusController.text = widget.product.is_active == 1?'متاح':"غير متاح" ;
    editProductController.descriptionController.text = widget.product.description??'';
    editProductController.durationType = widget.product.duration_type == 'hour'? 'ساعات':widget.product.duration_type == 'minute'?'دقائق':"أيام" ;
    editProductController.selectedProductStatus.value = widget.product.is_active ==true?1:0 ;
    if(widget.product.sizes != null && widget.product.sizes!.isNotEmpty){
      editProductController.addedSizes.clear();
      widget.product.sizes!.forEach((e){
        editProductController.addedSizes.add(e);
      });

    }
    if(widget.product.addons != null && widget.product.addons!.isNotEmpty){
      editProductController.addonsList.clear();
      widget.product.addons!.forEach((e){
        editProductController.addonsList.add(e);
      });

    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // executes after build
    //
    //
    // });
  }
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'تعديل المنتج'),

        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: editProductController.productNameController,
                    fieldLabel: 'أضف المنتج',
                    hintText: 'أدخل اسم المنتج',
                    validator: (value) => FormValidators.validateRequired(value, fieldName: ''),
                  ),
                  SizedBox(height: 16,),
                  Text('صورة المنتج',style: text70014,),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: editProductController.productImageController,
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
                                editProductController.productImageController.text = result.files[0].name;
                                editProductController.filePickerResult = result;

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
                          controller: editProductController.selectedSize,
                          onTap: (){
                            editProductController.getSizes();
                            SizesBottomSheet().openSizesSheet(context,editProductController,false);
                          },
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)
                          ,hintText: 'أدخل الجحم'))),
                      SizedBox(width: 8,),
                      Expanded(child: Container(child: AppTextField(
                          height: 56,

                          keyboardType: TextInputType.number,
                          inputFormatters:
                          [FilteringTextInputFormatter.digitsOnly],
                          controller: editProductController.enteredPrice,
                          hintText: 'أدخل سعر المنتج'))),
                      SizedBox(width: 8,),

                      InkWell(
                        onTap: (){
                          editProductController.addSize(context);
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
                    return  editProductController.addedSizes.isNotEmpty?
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:editProductController.addedSizes.length ,
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
                                    Text(editProductController.addedSizes[index].name??'',style: text50016,),
                                    Row(
                                      children: [
                                        Text(editProductController.addedSizes[index].price??''+' '+'ر.س',style: text70014.copyWith(color: darkPurple2),),
                                        SizedBox(width: 8,),
                                        InkWell(
                                          onTap: (){
                                            editProductController.addedSizes.removeAt(index);
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
                      controller: editProductController.durationController,
                      suffixIcon: Container(
                        width: 110,

                        child: DropdownButtonFormField<String>(
                          value: optionsInitialVal,
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
                            editProductController.durationTypeController.text = newValue == 'أيام'?'day' :
                            newValue == 'دقائق'?'minute':"hour";
                            editProductController.durationType = newValue == 'أيام'?'day' :
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

                      controller: editProductController.descriptionController,
                      fieldLabel: 'وصف المنتج',
                      hintText: 'أدخل وصف المنتج'),
                  SizedBox(height: 16,),
                  AppTextField(
                      readOnly: true,
                      controller: editProductController.statusController,
                      onTap: (){
                        ProductStatusBottomSheet().chooseProductStatus(context, editProductController,false);
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
                          controller: editProductController.addonsNameController,
                          hintText: 'أدخل اسم المكون'))),
                      SizedBox(width: 8,),
                      Expanded(child: Container(child: AppTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters:
                          [FilteringTextInputFormatter.digitsOnly],
                          controller: editProductController.addonsPriceController,
                          hintText: 'أدخل سعر المنتج'))),
                      SizedBox(width: 8,),

                      InkWell(
                        onTap: (){
                          editProductController.addAddons(context);
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
                    return editProductController.addonsList.isNotEmpty? ListView.builder(
                        shrinkWrap: true,
                        itemCount:editProductController.addonsList.length ,
                        itemBuilder: (context,index){
                          List<dynamic>  addons =  editProductController.addonsList;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: SizedBox(
                              child: DecoratedBox(decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(16)
                              ),child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(editProductController.addonsList[index].name??"",style: text50016,),
                                    Row(
                                      children: [
                                        Text('${editProductController.addonsList[index].price}'+' '+'ر.س',style: text70014.copyWith(color: darkPurple2),),
                                        SizedBox(width: 8,),
                                        InkWell(
                                          onTap: (){
                                            editProductController.addonsList.removeAt(index);
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

                  SizedBox(height: 24,),
                  Obx((){
                    return editProductController.addProductLoading.value?Center(
                      child: Container(
                          height: 50,width: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                          )),
                    ) : MainAppButton(onPressed: () async{

                      if (_formKey.currentState!.validate()) {
                        editProductController.editProduct(context,widget.product.id??-1);

                      }else{
                        const snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('يرجى إدخال البيانات المطلوبة'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    }, title: 'تعديل المنتج');
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

