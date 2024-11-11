import 'package:flutter/material.dart';
import 'package:project/Admin/Bookasset_Admin.dart';
import 'package:project/Admin/Dashboard_Admin.dart';
import 'package:project/Admin/History_Admin.dart';
import 'package:project/Admin/Home_Admin.dart';
import 'dart:io';

import 'package:project/Login.dart';

class ReturnAdmin extends StatefulWidget {
  final File? profileImage;

  const ReturnAdmin({super.key, this.profileImage});

  @override
  State<ReturnAdmin> createState() => _StatuspageState();
}

class _StatuspageState extends State<ReturnAdmin> {
  int _selectedIndex = 2;

  var list = [
    {
      'id': 'C00001',
      'picture': 'Assets/image/Recommend_2.jpg',
      'moviename': 'EVENGERS END GAME',
      'borrowedDate': '01/10/2024',
      'returnedDate': '07/10/2024',
      'borrowerName': 'Alice',
      'status': 'Borrowed',
    },
    {
      'id': 'C00002',
      'picture': 'Assets/image/Recommend_5.jpg',
      'moviename': 'BATMAN THE DARK NIGHT',
      'borrowedDate': '05/10/2024',
      'returnedDate': '07/10/2024',
      'borrowerName': 'Jeng',
      'status': 'Borrowed',
    },
    {
      'id': 'C00003',
      'picture': 'Assets/image/Recommend_3.jpg',
      'moviename': 'THE FLASH',
      'borrowedDate': '03/10/2024',
      'returnedDate': '8/10/2024',
      'borrowerName': 'KruBra',
      'status': 'Borrowed',
    },
    {
      'id': 'C00004',
      'picture': 'Assets/image/deadpool1.jpg',
      'moviename': 'Dead Pool',
      'borrowedDate': '03/10/2024',
      'returnedDate': '9/10/2024',
      'borrowerName': 'Lili',
      'status': 'Borrowed',
    },
    {
      'id': 'C00005',
      'picture': 'Assets/image/Recommend_4.jpg',
      'moviename': 'BLACK PANTHER',
      'borrowedDate': '06/10/2024',
      'returnedDate': '12/10/2024',
      'borrowerName': 'Eris',
      'status': 'Borrowed',
    },
  ];

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
            'Return Assets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
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

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.logout,
              color: Colors.red,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Confirm Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(226, 0, 0, 0), // Adjust this color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Adjust this color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBody() {
    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildMovieCard(index);
        },
      ),
    );
  }

  Widget _buildMovieCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(197, 0, 0, 0).withOpacity(0.80),
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                list[index]['picture']!,
                height: 170,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list[index]['moviename']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('ID: ${list[index]['id']!}',
                      style: const TextStyle(fontSize: 12)),
                  Text('Borrowed: ${list[index]['borrowedDate']!}'),
                  Text('Returned: ${list[index]['returnedDate']!}'),
                  Text('Borrower: ${list[index]['borrowerName']!}'),
                  // Text('Status: ${list[index]['status']!}'),
                  const SizedBox(
                      height: 8), // Add spacing between text and button
                  ElevatedButton.icon(
                    onPressed: () => _showReturnDialog(
                        index), // เปลี่ยนจาก _showApprovalDialog เป็น _showReturnDialog
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 61, 26),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 4),
                      minimumSize: const Size(160, 30),
                    ),
                    icon: const Icon(
                      Icons.assignment_returned,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text('Return Assets',
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReturnDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.assignment_returned,
              color: Colors.blue,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Confirm Return',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Are you sure you want to return the movie "${list[index]['moviename']}"?',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 5, 5, 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Remove the movie from the list
              setState(() {
                list.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: const Text(
              'Return',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 222, 88, 11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF4C8479),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/home.png', 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/asset.png', 1),
          label: 'Assets',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/return.png', 2),
          label: 'Return',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/Dashboard.png', 3),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/history (1).png', 4),
          label: 'History',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeAdmin()));
            break;
          case 1:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BookassetAdmin(profileImage: widget.profileImage)));
            break;
          case 3:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DashboardAdmin(profileImage: widget.profileImage)));
            break;
          case 4:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HistoryAdmin(profileImage: widget.profileImage)));
            break;
        }
      },
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
}
