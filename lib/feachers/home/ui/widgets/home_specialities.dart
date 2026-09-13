// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/style/colors.dart';
// import 'package:flutter_application_1/core/widgets/custom_text_button.dart';
// import 'package:flutter_application_1/feachers/home/logic/home_provider_doctor.dart';
// import 'package:provider/provider.dart';

// class HomeSpecialities extends StatelessWidget {
//   const HomeSpecialities({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<HomeProvider>();
//     return Consumer<HomeProvider>(
//       builder: (context, _, _) {
//         return Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Doctor Speciality',
//                     style: TextStyle(
//                       color: AppColors.text100Color,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 CustomTextButton(onPressed: () {}, text: 'See All'),
//               ],
//             ),
//             SizedBox(
//               height: 80,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   final specialaization = provider.specializations[index];
//                   return Column(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: AppColors.primarySurfaceColor,
//                         radius: 30,
//                         child: Icon(
//                           Icons.category,
//                           color: AppColors.text100Color,
//                         ),
//                       ),
//                       Text(
//                         specialaization.name,
//                         style: TextStyle(
//                           color: AppColors.text100Color,
//                           fontSize: 12,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(width: 14),
//                 itemCount: provider.specializations.length,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
