import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/offers/controllers/offer_controller.dart';
import 'package:afran_provider/offers/widgets/products_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class AddOfferScreen extends StatelessWidget {
   AddOfferScreen({super.key});

   TextEditingController offerImageController = TextEditingController();

   DateTime? selectedDate;

   Future<void> _selectDate(BuildContext context,bool start) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: selectedDate ?? DateTime.now(),
       firstDate: DateTime(2000),
       lastDate: DateTime(2101),
       locale: const Locale('en', ''), // Change to 'ar' for Arabic, etc.
     );
     if (picked != null && picked != selectedDate) {
       if(start == false && picked.isBefore(DateTime.parse(controller.startTimeController.text))){
         const snackBar = SnackBar(
             backgroundColor: Colors.red,
             content: Text('يجب أن يكون تاريخ النهاية بعد البداية'));
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
       }else{
         String formatted = intl.DateFormat('yyyy-MM-dd').format(picked);
         if(start == true){
           controller.startTimeController.text = formatted;
         }else{

           controller.endTimeController.text = formatted;

         }
       }

     }
   }
   OfferController controller = Get.put(OfferController());
   final _formKey = GlobalKey<FormState>();


   @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MainAppBar(title: 'أضف عرض'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                        validator: (value) => FormValidators.validateRequired(value, fieldName: ''),
                        controller: controller.offerNameController,
                        fieldLabel: 'اسم العرض',
                        hintText: 'أدخل اسم العرض'),
                    SizedBox(height: 16,),
                    Text('صورة العرض',style: text70014,),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: offerImageController,
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              height: 44,width: 100,
                              child: MainAppButton(onPressed: () async{
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf']
                                );
                                if(result != null){
                                  // ibanController.text = result.files[0].name;

                                }
                              },
                                  icon: SvgPicture.asset(attach),

                                  title: 'إرفاق')),
                        ),
                        hintText: 'إرفق صورة العرض',
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
                    SizedBox(height: 4,),
                    Text('قم برفع صورة واضحة PNG أو JPG',style: text40012.copyWith(color: grey3),),
                    SizedBox(height: 16,),
                    AppTextField(
                      controller: controller.productController,
                        validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                        fieldLabel: 'المنتج',
                        onTap: (){
                          GetProductsBottomSheet().getProducts(context,controller);
                        },
                        hintText: 'اختر المنتج'),
                    SizedBox(height: 16,),
                    AppTextField(
                        controller: controller.offerPriceController,
                        validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

                        fieldLabel: 'سعر العرض',
                        hintText: 'أدخل سعر العرض'),
                    SizedBox(height: 16,),
                    AppTextField(
                        controller: controller.descriptionController,
                        validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

                        maxLines: 3,
                        minLines: 2,
                        height: 110,
                        fieldLabel: 'وصف العرض',
                        hintText: 'أدخل وصف العرض'),
                    Text('الوقت المتاح للعرض',style: text70014,),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: AppTextField(
                                controller: controller.startTimeController,
                                validator: (value) => FormValidators.validateRequired(value, fieldName: ''),
                                readOnly: true,
                                onTap: () => _selectDate(context,true),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(time),
                                ),
                                hintText: 'البداية'),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Container(
                            child: AppTextField(
                                controller: controller.endTimeController,
                                readOnly: true ,
                                validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

                                onTap: () {
                                  if(controller.startTimeController.text.trim().isNotEmpty){
                                    _selectDate(context,false);
                                  }else{
                                    const snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('اختر تاريخ البداية أولا'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(time),
                                ),
                                hintText: 'النهاية'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Obx((){
                      return controller.addOfferLoading.value?
                      Center(
                        child: Container(
                            height: 50,width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                            )),
                      )
                          :MainAppButton(onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          controller.addOffer(context);

                        }else{
                          const snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('يرجى إدخال البيانات المطلوبة'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }, title: 'أضف العرض');
                    })



                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

