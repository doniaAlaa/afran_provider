import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/profile/widgets/empty_favorit.dart';
import 'package:afran_provider/profile/widgets/favorit_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            // shadowColor: Colors.white,
            leading: Icon(Icons.arrow_back_ios,size: 20,color: darkPurple2,),
            titleSpacing: 0,
            title:  Text('المفضلة',style: text70018.copyWith(color: darkPurple2),)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               // FavoritData(),
               EmptyFavorit()
            ],
          ),
        ),

      ),
    );
  }
}

