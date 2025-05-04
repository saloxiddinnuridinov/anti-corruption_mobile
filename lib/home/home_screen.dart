// import 'package:flutter/material.dart';
// import '../utils/colors.dart';
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
//     const Center(child: Text('Murojaatlar', style: TextStyle(fontSize: 24))),
//     const Center(child: Text('Yangiliklar', style: TextStyle(fontSize: 24))),
//     const Center(child: Text('Huquqiy maslahat', style: TextStyle(fontSize: 24))),
//     const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Karrupsiyasiz kelajak'),
//         centerTitle: true,
//       ),
//       body: _screens[_currentIndex],
//       floatingActionButton: _currentIndex == 0
//           ? FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       )
//           : null,
//       bottomNavigationBar: _buildBottomNavBar(),
//     );
//   }
//
//   BottomNavigationBar _buildBottomNavBar() {
//     return BottomNavigationBar(
//       currentIndex: _currentIndex,
//       onTap: (index) => setState(() => _currentIndex = index),
//       backgroundColor: AppColors.primary,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.white.withOpacity(0.6),
//       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//       type: BottomNavigationBarType.fixed,
//       elevation: 10,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.report),
//           label: 'Murojaat',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.article),
//           label: 'Yangiliklar',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.announcement),
//           label: 'Huquqiy maslahatlar',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'appeals/create_appeal_screen.dart'; // Bu importni qo'shish kerak

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAppealScreen(),
            ),
          );
        },
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