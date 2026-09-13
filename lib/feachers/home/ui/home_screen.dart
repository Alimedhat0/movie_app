// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/feachers/home/logic/home_provider_doctor.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create:
//           (context) =>
//               HomeProvider()
//                 ..getAllSpecializations()
//                 ..getAllDoctors()
//                 ..getProfile(),
//       child: Consumer<HomeProvider>(
//         builder: (context, _, _) {
//           final provider = context.read<HomeProvider>();
//           return Scaffold(
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {},
//               child: Icon(Icons.search, color: Colors.white),
//             ),
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerDocked,
//             bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               onTap: (value) {
//                 provider.changeIndex(value);
//               },
//               currentIndex: provider.currentIndex,
//               items: [
//                 BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.message),
//                   label: 'Messages',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.calendar_month),
//                   label: 'Appointments',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'Profile',
//                 ),
//               ],
//             ),
//             body: provider.homeScreens[provider.currentIndex],
//           );
//         },
//       ),
//     );
//   }
// }
