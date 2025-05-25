import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterSuccessScreen extends StatefulWidget {
  final UserModel userModel;
  const RegisterSuccessScreen({super.key,required this.userModel});

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: widget.userModel,)),
      );

    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(success),
              SizedBox(height: 32,),
              Text(
                'تم تسجيل الحساب بنجاح',
                style: text70020,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8,),
              Text(
                'مرحباً بك كأسرة منتجة في أفران',
                style: text50016,
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    );

  }
}
