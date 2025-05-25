import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/profile/controllers/user_info_controller.dart';
import 'package:afran_provider/profile/widgets/account_info.dart';
import 'package:afran_provider/profile/widgets/profile_image_alert.dart';
import 'package:afran_provider/register/controllers/register_controller.dart';
import 'package:afran_provider/register/screens/register_second_step.dart';
import 'package:afran_provider/register/widgets/product_categories_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserInfoScreen extends StatefulWidget {
  final UserModel userModel;
   UserInfoScreen({super.key,required this.userModel});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserInfoController userInfoController = Get.put(UserInfoController());
  RegisterController registerController = Get.put(RegisterController());


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      userInfoController.nameController.text = widget.userModel.name??'';
      userInfoController.familyNameController.text = widget.userModel.owner??'';
      userInfoController.emailController.text = widget.userModel.email??'';
      userInfoController.phoneController.text = widget.userModel.phone??'';

    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'بياناتي'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 106,width: 106,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.network(
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },

                              'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww'),
                        ),

                      ),
                      InkWell(
                        onTap: () async{
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['jpg']
                          );
                          if(result != null){
                            // ProfileImageAlert().changeProfileImageAlert(context,result,userInfoController);
                            userInfoController.updateProfileImage(context,result);
                          }
                        },
                        child: Container(
                          height: 36,width: 36,
                          decoration: BoxDecoration(
                              color: darkPurple,
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(editIcon),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Obx((){
                  return  Row(
                    children: [
                      Expanded(child: Container(
                          height: 40,
                          child: MainAppButton(
                              backgroundColor:userInfoController.selectedButton.value == 0? darkPurple:grey,
                              titleColor:userInfoController.selectedButton.value == 0?  Colors.white:Color(0xFF121212),

                              onPressed: (){
                                userInfoController.selectedButton.value = 0;
                              }, title: 'معلومات الحساب'))),
                      SizedBox(width: 8,),
                      Expanded(child: Container(
                          height: 40,
                          child: MainAppButton(onPressed: (){
                            userInfoController.selectedButton.value = 1;

                          },
                              backgroundColor:userInfoController.selectedButton.value == 1?darkPurple:grey,
                              titleColor:userInfoController.selectedButton.value == 1?  Colors.white:Color(0xFF121212),                              title: 'المستندات')))
                    ],
                  );
                }),
                SizedBox(height: 24,),
                Obx((){
                  return userInfoController.selectedButton.value == 0 ? AccountInfo():Doucuments(registerController: registerController,);
                }),
                SizedBox(height: 24,),
                Obx((){
                  return Row(
                    children: [
                      userInfoController.updateLoading.value?
                      Container(
                          height: 50,width: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,),
                          )):
                      Expanded(child: Container(child:
                      MainAppButton(onPressed: (){
                        if(userInfoController.selectedButton.value == 0){
                          userInfoController.updateAccountInfo(context);
                        }
                      }, title: 'حفظ'))),
                      SizedBox(width: 16,),
                      Expanded(child: Container(child: MainAppButton(
                          backgroundColor: grey,
                          titleColor: grey3,
                          onPressed: (){}, title: 'تجاهل'))),

                    ],
                  );
                }),
                SizedBox(height: 16,)


              ],
            ),
          ),
        ),
      ),
    );
  }
}

