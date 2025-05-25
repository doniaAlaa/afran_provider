import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/profile/controllers/user_info_controller.dart';
import 'package:afran_provider/register/controllers/register_controller.dart';
import 'package:afran_provider/register/widgets/product_categories_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AccountInfo extends StatelessWidget {
   AccountInfo({super.key});

  UserInfoController userInfoController = Get.put(UserInfoController());

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        AppTextField(
          controller: userInfoController.nameController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(person,width: 16,height: 16,),

          ),
          fieldLabel:"اسم المسؤول",
          hintText:  "أدخل اسم المسؤول",

        ),
        SizedBox(height: 16,),
        AppTextField(
          controller: userInfoController.familyNameController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(store,width: 16,height: 16,),

          ),
          fieldLabel:"اسم الأسرة المنتجة",
          hintText:  "أدخل اسم الأسرة المنتجة",

        ),
        SizedBox(height: 16,),
        AppTextField(
          controller: userInfoController.emailController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(email,width: 16,height: 16,),

          ),
          fieldLabel:"البريد الإلكتروني",
          hintText:  "example@email.com",
          validator: (value) => FormValidators.validateEmail(value, ),


        ),
        SizedBox(height: 16),

        // Phone Number
        AppTextField(
          controller: userInfoController.phoneController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(phoneIcon,width: 16,height: 16,),
          ),
          fieldLabel: "رقم الهاتف",
          hintText: "أدخل رقم الهاتف",),

        SizedBox(height: 16),
        AppTextField(
          controller: userInfoController.productCategoryController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(store,width: 16,height: 16,),

          ),
          onTap: (){
            RegisterController registerController = Get.put(RegisterController());
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

        SizedBox(height: 16),

        // Password
        AppTextField(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
          ),
          suffixIcon: Icon(Icons.visibility_off_outlined,color: Colors.black.withOpacity(0.3),),
          fieldLabel: "كلمة المرور الحالية",
          hintText: "أدخل كلمة المرور الحالية ",),
        SizedBox(height: 16),

        // Password
        AppTextField(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
          ),
          suffixIcon: Icon(Icons.visibility_off_outlined,color: Colors.black.withOpacity(0.3),),
          fieldLabel: "كلمة المرور الجديدة",
          hintText: "أدخل كلمة المرورالجديدة",),
        // Confirm Password
        SizedBox(height: 16,),
        AppTextField(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
          ),
          suffixIcon: Icon(Icons.visibility_off_outlined,color: Colors.black.withOpacity(0.3),),

          fieldLabel: "تأكيد كلمة المرور",
          hintText: "أعد إدخال كلمة المرور",),
      ],
    );

  }
}

