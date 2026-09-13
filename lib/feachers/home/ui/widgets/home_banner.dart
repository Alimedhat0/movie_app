import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/colors.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/home_banner.png'),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset('assets/images/doctor_female.png'),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                'Book and\nschedule with\nnearest doctor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Find Nearby',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
