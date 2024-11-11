import 'package:flutter/material.dart';
import 'package:project/Approver/Dashboard_Approver.dart';
import 'package:project/Approver/History_Approver.dart';
import 'package:project/Approver/Home_Approver.dart';
import 'package:project/Approver/Request_approver.dart';
import 'package:project/Login.dart';
import 'package:project/User/History_User.dart';
import 'dart:io';
import 'package:project/User/Home_User.dart';

class BookassetApprover extends StatefulWidget {
  final File? profileImage;
  final String? category;

  const BookassetApprover({super.key, this.profileImage, this.category});

  @override
  State<BookassetApprover> createState() => _BookassetpageState();
}

class _BookassetpageState extends State<BookassetApprover> {
  int _selectedIndex = 1;
  String? _selectedCategory;

  final List<String> categories = [
    'All',
    'Drama',
    'Comedy',
    'Crime',
    'Thriller',
    'Fantasy',
    'History',
    'Romantic',
    'Action',
  ];

  final List<Map<String, String>> books = [
    // Fantasy
    {
      'id': 'F0001',
      'title': 'AVENGER ENDGAME',
      'image': 'Assets/image/Recommend_2.jpg',
      'category': 'Fantasy',
      'status': 'Borrowed'
    },
    {
      'id': 'F0002',
      'title': 'THE FLASH',
      'image': 'Assets/image/Recommend_3.jpg',
      'category': 'Fantasy',
      'status': 'Disabled',
    },
    {
      'id': 'F0003',
      'title': 'BLACK PANTHER',
      'image': 'Assets/image/Recommend_4.jpg',
      'category': 'Fantasy',
      'status': 'Available',
    },
    {
      'id': 'F0004',
      'title': 'iRONMAN',
      'image': 'Assets/image/Recommend_2.jpg',
      'category': 'Comedy',
      'status': 'Pending',
    },

    // Drama
    {
      'id': 'D0001',
      'title': 'HOW TO TING',
      'image': 'Assets/image/D0001.jpg',
      'category': 'Drama',
      'status': 'Available'
    },
    {
      'id': 'D0002',
      'title': 'FAN DAY',
      'image': 'Assets/image/D0002.jpg',
      'category': 'Drama',
      'status': 'Borrowed',
    },
    {
      'id': 'D0003',
      'title': 'LAN MAR',
      'image': 'Assets/image/D0003.jpg',
      'category': 'Drama',
      'status': 'Pending',
    },

    // Comedy
    {
      'id': 'A0001',
      'title': 'BATMAN',
      'image': 'Assets/image/Recommend_5.jpg',
      'category': 'Action',
      'status': 'Available',
    },
    {
      'id': 'C0002',
      'title': 'ARTIFICIAL INTELLIGENCE',
      'image': 'Assets/image/C00002.jpg',
      'category': 'Crime',
      'status': 'Borrowed',
    },
    {
      'id': 'C0003',
      'title': 'CMONEY HEIST',
      'image': 'Assets/image/C00003.jpg',
      'category': 'Crime',
      'status': 'Disabled',
    },
    {
      'id': 'R0004',
      'title': 'TITANIC',
      'image': 'Assets/image/R0001.jpg',
      'category': 'Romantic',
      'status': 'Available',
    },

    // Crime
    {
      'id': 'A0001',
      'title': 'Fast and Furious 1',
      'image': 'Assets/image/A0001.jpg',
      'category': 'Action',
      'status': 'Pending',
    },
    {
      'id': 'CR0002',
      'title': 'CATCH ME IF YOU CAN',
      'image': 'Assets/image/C00002.jpg',
      'category': 'Crime',
      'status': 'Pending',
    },
    {
      'id': 'CR0003',
      'title': 'THE GODFATHER',
      'image': 'Assets/image/C00003.jpg',
      'category': 'Crime',
      'status': 'Available',
    },
    {
      'id': 'H0004',
      'title': 'PEE MAK PA KA NONG',
      'image': 'Assets/image/H0003.jpg',
      'category': 'History',
      'status': 'Available',
    },

    // Thriller
    {
      'id': 'T0001',
      'title': 'SAYONG',
      'image': 'Assets/image/T0001.jpg',
      'category': 'Thriller',
      'status': 'Available',
    },
    {
      'id': 'T0002',
      'title': 'TEE YOD 1',
      'image': 'Assets/image/T0002.jpg',
      'category': 'Thriller',
      'status': 'Borrowed',
    },
    {
      'id': 'T0003',
      'title': 'TEE YOD 2',
      'image': 'Assets/image/T0003.jpg',
      'category': 'Thriller',
      'status': 'Disabled',
    },
    {
      'id': 'T0004',
      'title': 'ANABEL',
      'image': 'Assets/image/T0004.jpg',
      'category': 'Thriller',
      'status': 'Available',
    },

    // Additional categories can be added similarly...
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category ?? categories[0];
  }

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
            'Book Assets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w500,
            ),
          ),
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

  Container _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFA9C7C3), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildDropdown(),
            const SizedBox(height: 20),
            SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.7, // กำหนดขนาดความสูง
              child: _buildContentForCategory(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentForCategory() {
    if (_selectedCategory == 'All') {
      return _buildBookListContent();
    } else {
      final filteredBooks =
          books.where((book) => book['category'] == _selectedCategory).toList();

      return filteredBooks.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return _buildBookCard(book);
              },
            )
          : Center(
              child: Text('No books available in this category',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
            );
    }
  }

  Widget _buildBookListContent() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55, // ปรับสัดส่วนพื้นที่การ์ด
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return _buildBookCard(book);
      },
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return GestureDetector(
      onTap: () {
        // Handle book tap, e.g., show details
      },
      child: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueGrey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  book['image']!,
                  height: 180, // เพิ่มความสูงของภาพ
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      book['title']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3, // เพิ่ม maxLines เพื่อให้ข้อความไม่ล้น
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${book['id']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    _buildStatusButton(book['status']!, book),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String status, Map<String, String> book) {
    Color statusColor;
    String statusText;

    switch (status) {
      case 'Available':
        statusColor = Colors.green;
        statusText = 'Available';
        break;
      case 'Borrowed':
        statusColor = Colors.blueGrey;
        statusText = 'Borrowed';
        break;
      case 'Disabled':
        statusColor = Colors.red;
        statusText = 'Disabled';
        break;
      case 'Pending':
        statusColor = Colors.orange;
        statusText = 'Pending';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showAvailablePopup(String title, String id, String imagePath) {
    final DateTime now = DateTime.now();
    final String currentDate = "${now.day}/${now.month}/${now.year}";

    TextEditingController returnDateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(color: Colors.black, thickness: 1),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 150,
              width: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text(
              'Book ID: $id',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Borrow Date: $currentDate',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: returnDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Return Date',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(now.year),
                      lastDate: DateTime(now.year + 5),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      returnDateController.text = formattedDate;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 1, 249),
                ),
              ),
              TextButton(
                onPressed: () {
                  _confirmBorrow(
                      title, id, imagePath, returnDateController.text);
                },
                child:
                    const Text('Borrow', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 3, 3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmBorrow(
      String title, String id, String imagePath, String returnDate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Borrow'),
        content: Text('Are you sure you want to borrow "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Change status to Pending
              setState(() {
                final bookIndex = books.indexWhere((book) => book['id'] == id);
                if (bookIndex != -1) {
                  books[bookIndex]['status'] = 'Pending';
                }
              });

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title has been borrowed successfully!'),
                  duration: const Duration(seconds: 2),
                ),
              );

              Navigator.of(context).pop(); // Close the confirm dialog
              Navigator.of(context).pop(); // Close the book details dialog
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 38, 36, 36).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCategory,
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    children: [
                      Image.asset(
                        _getImageForCategory(value),
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center, // ให้ข้อความชิดซ้าย
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }

  String _getImageForCategory(String category) {
    switch (category) {
      case 'Drama':
        return 'Assets/image/drama.png'; // Path to your comic icon
      case 'Comedy':
        return 'Assets/image/comedy.png'; // Path to your science icon
      case 'Romantic':
        return 'Assets/image/romance.png'; // Path to your science icon
      case 'Crime':
        return 'Assets/image/crime.png'; // Path to your science icon
      case 'Thriller':
        return 'Assets/image/thriller.png'; // Path to your science icon
      case 'Fantasy':
        return 'Assets/image/fantasy.png'; // Path to your science icon
      case 'History':
        return 'Assets/image/history.png'; // Path to your science icon
      case 'Action':
        return 'Assets/image/action.png'; // Path to your science icon
      // Add cases for other categories as needed
      default:
        return 'Assets/image/all.png'; // Default icon path
    }
  }

  Widget _buildIcon(String imagePath, int index) {
    return ColorFiltered(
      colorFilter: _selectedIndex == index
          ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : ColorFilter.mode(Colors.black, BlendMode.srcIn),
      child: Image.asset(
        imagePath,
        width: 25,
        height: 25,
      ),
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
          icon: _buildIcon('Assets/image/Request.png', 2),
          label: 'Request',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/Dashboard.png', 3),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('Assets/image/history (1).png', 4),
          label: 'History',
        ),
        // BottomNavigationBarItem(
        //   icon: _buildIcon('Assets/image/logout.png', 4),
        //   label: 'Logout',
        // ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          // if (index == 3) {
          //   _showLogoutConfirmation(); // แสดงการยืนยันล็อกเอาท์เมื่อเลือกไอคอนล็อกเอาท์
          //   return;
          // }
          _selectedIndex = index;
        });
        // if (index == 4) {
        //   _showLogoutConfirmation(); // แสดงการยืนยันล็อกเอาท์เมื่อเลือกไอคอนล็อกเอาท์
        //   return;
        // }
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeApprover()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RequestApprover(profileImage: widget.profileImage),
              ),
            );
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DashboardApprover(profileImage: widget.profileImage),
              ),
            );
          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HistoryApprover(profileImage: widget.profileImage),
              ),
            );
        }
      },
    );
  }
}
