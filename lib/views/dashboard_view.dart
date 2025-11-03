
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'settings_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardGrid(),
    ApprovalPage(),
    ReportsPage(),
    SettingsView(), // Display SettingsView as a tab
  ];

  @override
  Widget build(BuildContext context) {
    // Use a list of titles that corresponds to the tabs
    final List<String> appBarTitles = [
      'Dashboard',
      'Approval',
      'Reports',
      'Settings', 
    ];

    return Scaffold(
      backgroundColor: _selectedIndex == 3 ? Colors.grey.shade100 : Colors.teal.shade700,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          appBarTitles[_selectedIndex], // Title changes based on selected tab
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            color: _selectedIndex == 3 ? Colors.black : Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: _selectedIndex == 3 ? Colors.black : Colors.white),
            onPressed: () {
              context.go('/login');
            },
          ),
        ],
        iconTheme: IconThemeData(color: _selectedIndex == 3 ? Colors.black : Colors.white),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((255 * 0.1).round()),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                activeIcon: Icon(Icons.check_circle),
                label: 'Approval',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined),
                activeIcon: Icon(Icons.bar_chart),
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.teal.shade700,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: <Widget>[
        _buildDashboardItem(context, 'Punch In', '08:30 AM', Icons.timer),
        _buildDashboardItem(context, 'Punch Out', '05:30 PM', Icons.timer_off),
        _buildDashboardItem(context, 'Attendance', '', Icons.calendar_today),
        _buildDashboardItem(context, 'Providers', '', Icons.people),
        _buildDashboardItem(context, 'Tour Plan', '', Icons.map),
        _buildDashboardItem(context, 'Checklist', '', Icons.checklist),
        _buildDashboardItem(context, 'Providers', '', Icons.list_alt),
        _buildDashboardItem(context, 'Training', '', Icons.school),
      ],
    );
  }

  Widget _buildDashboardItem(
      BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.teal.shade700),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Approval Page',
        style: GoogleFonts.lato(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Reports Page',
        style: GoogleFonts.lato(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
