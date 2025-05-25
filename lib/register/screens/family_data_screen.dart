import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/login/screen/login_screen.dart';
import 'package:afran_provider/register/controllers/register_controller.dart';
import 'package:afran_provider/register/widgets/product_categories_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FamilyDataScreen extends StatelessWidget {
  final  Function()? onPressed;

  FamilyDataScreen({super.key,
    this.onPressed,

  });

   bool passwordVisible = false;

  RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32,),
            Text('أكمل بياناتك',style: text70016.copyWith(color: darkPurple2),),
            SizedBox(height: 8,),
            Text('أكمل ملفك الشخصي واستمتع بخدمتنا كأسرة منتجة.',style: text50014.copyWith(color: grey3),),
            SizedBox(height: 16,),
            // Full Name
            AppTextField(
              controller: registerController.familyNameController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(store,width: 16,height: 16,),

              ),

              validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

              fieldLabel:"اسم الأسرة المنتجة",
              hintText:  "أدخل اسم الأسرة المنتجة",

            ),
            SizedBox(height: 16,),
            // Full Name
            AppTextField(
              controller: registerController.ownerNameController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(person,width: 16,height: 16,),

              ),

              validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

              fieldLabel:"اسم المسؤول",
              hintText:  "أدخل اسم المسؤول",

            ),
            SizedBox(height: 16),
            AppTextField(
              controller: registerController.emailController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(email,width: 16,height: 16,),

              ),
              validator: (value) => FormValidators.validateEmail(value, ),

              fieldLabel:"البريد الإلكتروني",
              hintText:  "example@email.com",

            ),
            SizedBox(height: 16),

            // Phone Number
            AppTextField(
              controller: registerController.familyPhoneController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(phoneIcon,width: 16,height: 16,),
              ),
              keyboardType: TextInputType.number,
              inputFormatters:
              [FilteringTextInputFormatter.digitsOnly],
              validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

              fieldLabel: "رقم الهاتف",
              hintText: "أدخل رقم الهاتف",),
            SizedBox(height: 16,),
            AppTextField(
              controller: registerController.productCategoryController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(store,width: 16,height: 16,),

              ),
              onTap: (){
                registerController.getProductCategories();
                ProductCategoriesBottomSheet().getProductCategories(context, registerController);
              },
              readOnly: true,
              fieldLabel:"فئة المنتجات",
              hintText:  "اختر فئة المنتجات",
              suffixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.keyboard_arrow_down_sharp,color: grey3,),

              ),


            ),
            SizedBox(height: 16,),
            Text('وقت الدوام',style: text70014,),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: AppTextField(
                      controller: registerController.startTimeController,
                      onTap: (){
                        registerController.selectTime(context,true);
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(time,width: 16,height: 16,),
                  
                      ),
                      readOnly: true,
                      hintText:  "البداية",
                  
                  
                  
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Container(
                    child: AppTextField(
                      controller: registerController.endTimeController,
                      onTap: (){
                        registerController.selectTime(context,false);

                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(time,width: 16,height: 16,),
                  
                      ),
                      readOnly: true,
                      hintText:  "النهاية",
                  
                  
                  
                    ),
                  ),
                ),
                
              ],
            ),




            SizedBox(height: 32,),
            Column(
              children: [
                Obx((){
                 return registerController.loading.value?
                  Center(
                  child: Container(
                      height: 30,width: 30,
                      child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.5,)),
                  ):
                  MainAppButton(onPressed: (){

                    if (_formKey.currentState!.validate()) {
                      registerController.register(context);
                    }else{
                    }
                  }
                  , title: 'إنشاء الحساب');
                }),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "لديك حساب بالفعل؟",
                        style: text50014
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );

                      },
                      child: Text(
                          "تسجيل الدخول",
                          style: text50014.copyWith(color: darkPurple,decoration: TextDecoration.underline)
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32,)
          ],
        ),
      ),
    );

  }
}

