import 'package:flutter/material.dart';
import 'package:project/Admin/Bookasset_Admin.dart';
import 'package:project/Admin/History_Admin.dart';
import 'package:project/Admin/Home_Admin.dart';
import 'package:project/Admin/Return_Admin.dart';
import 'dart:io';
import 'package:project/Login.dart';

class DashboardAdmin extends StatefulWidget {
  final File? profileImage;

  const DashboardAdmin({Key? key, this.profileImage}) : super(key: key);

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.profileImage != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Image.file(widget.profileImage!),
                  ),
                );
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[700],
              child: widget.profileImage != null
                  ? ClipOval(
                      child: Image.file(widget.profileImage!,
                          width: 50, height: 50, fit: BoxFit.cover),
                    )
                  : const Icon(Icons.account_circle,
                      size: 40, color: Colors.white),
            ),
          ),
          const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap:
                _showLogoutConfirmation, // เรียกฟังก์ชันเมื่อต้องการออกจากระบบ
            child: Image.asset(
              'Assets/image/logout.png',
              width: 50,
              height: 35,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF4C8479),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFA9C7C3), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _buildCategorySelector(),
          const SizedBox(height: 30),
          _buildStatusCards(),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(10), // ลด padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'All',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold), // ลดขนาดฟอนต์
        ),
      ),
    );
  }

  Widget _buildStatusCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          _buildStatusCard('AVAILABLE', '8/20', Colors.teal),
          _buildStatusCard('BORROWED', '4/20', Colors.purpleAccent),
          _buildStatusCard('DISABLED', '5/20', Colors.redAccent),
          _buildStatusCard('PENDING', '3/20', Colors.orangeAccent),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status, String count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(
              255, 241, 239, 239), // เปลี่ยนพื้นหลังเป็นสีเดียวกัน
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF4C8479),
        items: [
          _buildBottomNavItem('Assets/image/home.png', 'Home', 0),
          _buildBottomNavItem('Assets/image/asset.png', 'Assets', 1),
          _buildBottomNavItem('Assets/image/return.png', 'Return', 2),
          _buildBottomNavItem('Assets/image/Dashboard.png', 'Dashboard', 3),
          _buildBottomNavItem('Assets/image/history (1).png', 'History', 4),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: (index) {
          _handleNavigation(index);
        });
  }

  BottomNavigationBarItem _buildBottomNavItem(
      String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: _buildIcon(iconPath, index),
      label: label,
    );
  }

  Widget _buildIcon(String imagePath, int index) {
    return ColorFiltered(
      colorFilter: _selectedIndex == index
          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      child: Image.asset(
        imagePath,
        width: 25,
        height: 25,
      ),
    );
  }

  void _handleNavigation(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const HomeAdmin();
        break;
      case 1:
        page = BookassetAdmin(profileImage: widget.profileImage);
        break;
      case 2:
        page = ReturnAdmin(profileImage: widget.profileImage);
        break;
      case 4:
        page = HistoryAdmin(profileImage: widget.profileImage);
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            const Icon(Icons.logout, color: Colors.red, size: 24),
            const SizedBox(width: 8),
            const Text('Confirm Logout',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
