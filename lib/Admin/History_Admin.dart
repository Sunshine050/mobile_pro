import 'package:flutter/material.dart';
import 'package:project/Admin/Bookasset_Admin.dart';
import 'package:project/Admin/Dashboard_Admin.dart';
import 'package:project/Admin/Home_Admin.dart';
import 'package:project/Admin/Return_Admin.dart';
import 'dart:io';
import 'package:project/Login.dart';

class HistoryAdmin extends StatefulWidget {
  final File? profileImage;

  const HistoryAdmin({super.key, this.profileImage});

  @override
  State<HistoryAdmin> createState() => _StatuspageState();
}

class _StatuspageState extends State<HistoryAdmin> {
  int _selectedIndex = 4; // Set the current page index

  final List<Map<String, String>> books = [
    {
      'title': 'AVENGER ENDGAME',
      'image': 'Assets/image/Recommend_2.jpg',
      'id': 'C0001',
      'borrowedDate': '16/10/2024',
      'returnedDate': '25/10/2024',
      'bookingName': 'JANE',
      'ApproverName': 'Ap1',
      'ReturnedName': 'Re1',
      'status': 'approve',
    },
    {
      'title': 'THE FLASH',
      'image': 'Assets/image/Recommend_3.jpg',
      'id': 'C0002',
      'borrowedDate': '17/10/2024',
      'returnedDate': '26/10/2024',
      'bookingName': 'LISA',
      'ApproverName': 'Ap2',
      'status': 'reject',
    },
    {
      'title': 'BLACK PANTHER',
      'image': 'Assets/image/Recommend_4.jpg',
      'id': 'C0003',
      'borrowedDate': '18/10/2024',
      'returnedDate': '27/10/2024',
      'bookingName': 'JOHN',
      'ApproverName': 'Ap3',
      'ReturnedName': 'Re1',
      'status': 'approve',
    },
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // เปลี่ยนเป็นสีขาว
        ),
        child: _buildHistoryContent(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              child: widget.profileImage != null
                  ? ClipOval(
                      child: Image.file(widget.profileImage!,
                          width: 43, height: 40, fit: BoxFit.cover),
                    )
                  : const Icon(Icons.account_circle,
                      size: 40, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 118, 117, 117),
            ),
          ),
          const SizedBox(width: 50),
          const Text(
            'History',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay-ExtraBold',
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 50),
          GestureDetector(
            onTap: _showLogoutConfirmation,
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
              backgroundColor: const Color.fromARGB(226, 0, 0, 0),
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
              backgroundColor: Colors.red,
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

  Widget _buildHistoryContent() {
    return SingleChildScrollView(
      child: Column(
        children: books.map((book) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      book['image']!,
                      fit: BoxFit.cover,
                      height: 145,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          book['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Book ID: ${book['id']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Borrowed: ${book['borrowedDate']}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                        ),
                        Text(
                          'Returned: ${book['returnedDate']}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Borrower Name: ${book['bookingName']}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                        ),
                        Text(
                          'Approver Name: ${book['ApproverName']}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (book['status'] == 'approve')
                          Text(
                            'Returned Name: ${book['ReturnedName']}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                            height:
                                10), // Add some space between the text and status
                        Center(
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center the row
                            children: [
                              Icon(
                                book['status'] == 'approve'
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: book['status'] == 'approve'
                                    ? Colors.blue
                                    : Colors.red,
                                size: 24,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                book['status']!,
                                style: TextStyle(
                                  color: book['status'] == 'approve'
                                      ? Colors.blue
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }).toList(),
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
          case 2:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReturnAdmin(profileImage: widget.profileImage)));
            break;
          case 3:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DashboardAdmin(profileImage: widget.profileImage)));
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

  void _logout() {
    Navigator.pop(context);
  }
}
