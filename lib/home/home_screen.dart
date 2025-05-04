// import 'package:anti_corruption_app/home/appeals/create_appeal_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/auth_service.dart';
// import 'appeals/appeal_list_screen.dart';
// import 'news/news_list_screen.dart';
// import 'announcements/announcement_list_screen.dart';
// import '../screens/profile/profile_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const AppealListScreen(),
//     const NewsListScreen(),
//     const AnnouncementListScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Anti-Corruption App'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await Provider.of<AuthService>(context, listen: false).logout();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//       body: _screens[_currentIndex],
//       floatingActionButton: _currentIndex == 0
//           ? FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const CreateAppealScreen(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       )
//           : null,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.report),
//             label: 'Appeals',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.announcement),
//             label: 'Announcements',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text('Murojaatlar', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Yangiliklar', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Huquqiy maslahat', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karrupsiyasiz kelajak'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      backgroundColor: AppColors.primary,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: 'Murojaat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Yangiliklar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.announcement),
          label: 'Huquqiy maslahatlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}