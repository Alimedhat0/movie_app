// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/style/colors.dart';
// import 'package:flutter_application_1/core/widgets/custom_text_button.dart';
// import 'package:flutter_application_1/feachers/doctor_details/ui/doctor_details_screen.dart';
// import 'package:flutter_application_1/feachers/doctors/ui/doctors_screen.dart';
// import 'package:flutter_application_1/feachers/home/logic/home_provider_doctor.dart';
// import 'package:provider/provider.dart';

// class HomeDoctors extends StatelessWidget {
//   const HomeDoctors({super.key});

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
//                     'Recommendation Doctors',
//                     style: TextStyle(
//                       color: AppColors.text100Color,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 CustomTextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder:
//                             (context) =>
//                                 DoctorsScreen(doctors: provider.doctors),
//                       ),
//                     );
//                   },
//                   text: 'See All',
//                 ),
//               ],
//             ),
//             Expanded(
//               child: ListView.separated(
//                 itemBuilder: (context, index) {
//                   final doctor = provider.doctors[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder:
//                               (context) =>
//                                   DoctorDetailsScreen(doctorModel: doctor),
//                         ),
//                       );
//                     },
//                     child: Row(
//                       spacing: 12,
//                       children: [
//                         Container(
//                           height: 110,
//                           width: 110,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                                 'https://static.vecteezy.com/system/resources/thumbnails/026/375/249/small_2x/ai-generative-portrait-of-confident-male-doctor-in-white-coat-and-stethoscope-standing-with-arms-crossed-and-looking-at-camera-photo.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             spacing: 6,
//                             children: [
//                               Text(
//                                 doctor.name,
//                                 style: TextStyle(
//                                   color: AppColors.text100Color,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Text(
//                                 '${doctor.specialization.name} | ${doctor.degree}',
//                                 style: TextStyle(
//                                   color: AppColors.bodyColor,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(height: 16),
//                 itemCount: provider.doctors.length,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
