import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:flutter/material.dart';

class SuccessTrackingScreen extends StatelessWidget {
  const SuccessTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 96,width: 96,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Image.network(
                  fit: BoxFit.cover,
                  'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww'),
            ),
          ),
          SizedBox(height: 24,),
          Text('تم تسليم طلبك بنجاح',style: text70020,),
          SizedBox(height: 8,),
          Text('منذ ٥ دقايق',style: text50014.copyWith(color: grey3,fontSize: 18),),
          SizedBox(height: 24,),
          Text('كيف كانت تجربتك مع التوصيل ؟',style: text70020,)
        ],
      ),
    );
  }
}

