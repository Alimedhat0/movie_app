// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/style/colors.dart';
// import 'package:flutter_application_1/feachers/home/logic/home_provider_doctor.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// class HomeHeader extends StatelessWidget {
//   const HomeHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<HomeProvider>();
//     return Consumer<HomeProvider>(
//       builder: (context, _, _) {
//         return Row(
//           spacing: 5,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hi, ${provider.user?.name ?? ''}!',
//                     style: TextStyle(
//                       color: AppColors.text100Color,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'How Are you Today?',
//                     style: TextStyle(
//                       color: AppColors.text80Color,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SvgPicture.asset('assets/svg/notifications.svg'),
//           ],
//         );
//       },
//     );
//   }
// }
