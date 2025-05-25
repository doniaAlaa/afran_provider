import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(title: 'أراء المستخدم'),
        body:     Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 72,width: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefdAYZ6uy2rn4ODl9zSL1KwCAhiEPo9Xm-g&s')),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("محمود أحمد",style: text70016),
                              SizedBox(height: 4,),
                              Row(
                                children: List.generate(5, (i) => SvgPicture.asset(star)),
                              ),
                              SizedBox(height: 4,),
                              Text("منذ ٥ دقايق",style: text40010.copyWith(color: grey3,fontSize: 12)),

                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(color: grey2,thickness: 2,),
                      ),
                      Text("الطلب وصل في الوقت المحدد، والطعام كان لذيذًا جدًا. خدمة ممتازة.",style: text40010.copyWith(color: grey3,fontSize: 12)),

                    ],
                  ),
                ),
              ),
            );
          }),
        )

      ),
    );
  }
}

