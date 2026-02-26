import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'features/perfil/perfil_page.dart';
import 'features/pesquisa/pesquisa_page.dart';
import 'widgets/custom_navbar.dart';
import 'widgets/custom_topbar.dart';
import 'core/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.lightBeige,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        cardColor: Colors.white,
        useMaterial3: true,
      ),

      home: const MainPage(),
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SearchScreen(),
    ProfilePage(),
  ];

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: _changePage,
    ),
    );
  }
}