import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  Future<void> _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = value;
    });
    await prefs.setBool('isDarkTheme', value);
  }

  void _confirmLogout(BuildContext context) {
    final homeCubit = context.read<HomeCubit>(); // Safe access
    print("Confirm Logout Dialog Shown"); // ✅ Debug

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              print("Logout cancelled"); // ✅ Debug
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print("Logout confirmed"); // ✅ Debug
              Navigator.of(context).pop();
              homeCubit.logout(context);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Text(_getAppBarTitle(state.selectedIndex));
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            backgroundColor: _isDarkTheme ? Colors.black : const Color.fromRGBO(35, 50, 60, 1.0),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add Post'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            onTap: (index) => context.read<HomeCubit>().onTabTapped(index),
          );
        },
      ),
    );
  }

// Function to Get Dynamic AppBar Title
  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "Dashboard";
      case 1:
        return "Add Post";
      case 2:
        return "Favourite";
      case 3:
        return "Profile";
      default:
        return "Home";
    }
  }

}
