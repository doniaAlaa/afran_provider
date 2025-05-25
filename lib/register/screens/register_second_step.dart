import 'dart:io';

import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/register/controllers/register_controller.dart';
import 'package:afran_provider/register/screens/select_location_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterSecondStep extends StatelessWidget {
  final  Function()? onPressed;

  RegisterSecondStep({super.key,this.onPressed});

  bool agreeToTerms = false;

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32,),
          Text('الوثائق المطلوبة',style: text70016.copyWith(color: darkPurple2),),
          SizedBox(height: 16,),
          Doucuments(registerController: registerController,),
          //////////////////////////////
          SizedBox(height: 16,),
          // Agree to Terms
          Row(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  checkboxTheme: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), //
                    ),
                  ),),
                child: Checkbox(
                  value: agreeToTerms,
                  onChanged: (value) {
                    // setState(() {
                    //   agreeToTerms = value!;
                    // });
                  },
                  activeColor: Color(0xFFB46EB4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //
                  visualDensity: VisualDensity.compact,
                  side: BorderSide(color: grey3),
      
                ),
              ),
              Row(
                children: [
                  Text(
                    "أوافق على ",
                    style: text50012,
                  ),
                  Text(
                    "الشروط والأحكام",
                    style: text50012.copyWith(color: darkPurple,decoration:TextDecoration.underline ),
                  ),
                  Text(
                    " و ",
                    style: text50012,
                  ),
                  Text(
                    "سياسة الخصوصية",
                    style: text50012.copyWith(color: darkPurple,decoration:TextDecoration.underline ),
                  ),
      
                ],
              ),

            ],
          ),
          SizedBox(height: 32,),
          Column(
            children: [
              MainAppButton(onPressed: (){
                onPressed!();
              }, title: 'أكمل بياناتك'),
              // SizedBox(height: 16,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //         "لديك حساب بالفعل؟",
              //         style: text50014
              //     ),
              //     InkWell(
              //       onTap: (){
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => LoginPage()),
              //         );
              //
              //       },
              //       child: Text(
              //           "تسجيل الدخول",
              //           style: text50014.copyWith(color: darkPurple,decoration: TextDecoration.underline)
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 32,)

      
        ],
      ),
    );
  }
}

class Doucuments extends StatelessWidget {
  final RegisterController registerController;
   Doucuments({super.key,required this.registerController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
            fieldLabel: 'الهوية الوطنية *',
            hintText: 'أدخل رقم الهوية الوطنية'),
        SizedBox(height: 8,),
        TextFormField(
          controller: registerController.nationalController,
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
                      registerController.nationalController.text = result.files[0].name;

                    }
                  },
                      icon: SvgPicture.asset(attach),

                      title: 'إرفاق')),
            ),
            hintText: 'الهوية الوطنية',
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
        Text('قم برفع مستند PDF أو صورة واضحة',style: text40012.copyWith(color: grey3),),
        //////////////////////////////////////////
        SizedBox(height: 16,),
        AppTextField(
            fieldLabel: 'رقم السجل التجاري *',
            hintText: 'أدخل رقم السجل التجاري'),
        SizedBox(height: 8,),
        TextFormField(
          controller: registerController.commercialController,
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
                      registerController.commercialController.text = result.files[0].name;

                    }
                  },
                      icon: SvgPicture.asset(attach),

                      title: 'إرفاق')),
            ),
            hintText: 'السجل التجاري أو شهادة العمل الحر',
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
        Text('قم برفع مستند PDF أو صورة واضحة',style: text40012.copyWith(color: grey3),),
        //////////////////////////////////////////////
        SizedBox(height: 16,),
        AppTextField(
            readOnly:true,
            controller: registerController.locationController,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectLocationFromMap()),
              );

            },
            fieldLabel: 'العنوان الوطني *',
            hintText: 'أدخل العنوان الوطني'),
        SizedBox(height: 8,),
        TextFormField(
          controller: registerController.addressController,
          keyboardType: TextInputType.phone,
          readOnly: true,

          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 44,width: 100,
                    child: MainAppButton(onPressed: () async{
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['pdf']
                      );
                      if(result != null){
                        registerController.addressController.text = result.files[0].name;

                      }
                    },
                        icon: SvgPicture.asset(attach),

                        title: 'إرفاق')),
              ),
            ),
            hintText: 'إرفق العنوان الوطني',
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
        Text('قم برفع مستند PDF أو صورة واضحة',style: text40012.copyWith(color: grey3),),
        ///////////////////////////////////////////////
        SizedBox(height: 16,),
        AppTextField(
            fieldLabel: 'رقم الحساب المصرفي الدولي (ايبان) *',
            hintText: 'أدخل رقم الايبان'),
        SizedBox(height: 8,),
        TextFormField(
          controller: registerController.ibanController,
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
                      registerController.ibanController.text = result.files[0].name;

                    }
                  },
                      icon: SvgPicture.asset(attach),

                      title: 'إرفاق')),
            ),
            hintText: 'إرفق رقم الايبان',
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
        Text('قم برفع مستند PDF أو صورة واضحة',style: text40012.copyWith(color: grey3),),
        ///////////////////////////////////////////////
        SizedBox(height: 16,),
        AppTextField(
            fieldLabel: 'الشهادة الضربية',
            hintText: 'أدخل رقم الضريبي'),
        SizedBox(height: 8,),
        TextFormField(
          controller: registerController.taxCertificateController,
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
                      registerController.taxCertificateController.text = result.files[0].name;

                    }
                  },
                      icon: SvgPicture.asset(attach),

                      title: 'إرفاق')),
            ),
            hintText: 'الشهادة الضربية',
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
        Text('قم برفع مستند PDF أو صورة واضحة',style: text40012.copyWith(color: grey3),),
      ],
    );
  }
}
