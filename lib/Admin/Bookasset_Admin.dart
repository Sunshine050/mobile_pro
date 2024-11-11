import 'package:flutter/material.dart';
import 'package:project/Admin/Dashboard_Admin.dart';
import 'package:project/Admin/History_Admin.dart';
import 'package:project/Admin/Home_Admin.dart';
import 'package:project/Admin/Return_Admin.dart';
import 'package:project/Login.dart';
import 'package:project/User/History_User.dart';
import 'dart:io';
import 'package:project/User/Home_User.dart';
import 'package:file_picker/file_picker.dart';

class BookassetAdmin extends StatefulWidget {
  final File? profileImage;
  final String? category;
  static File? imagemovie;

  const BookassetAdmin({super.key, this.profileImage, this.category});

  @override
  State<BookassetAdmin> createState() => _BookassetpageState();
}

class _BookassetpageState extends State<BookassetAdmin> {
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
      'title': 'AVENGER ',
      'image': 'Assets/image/Recommend_2.jpg',
      'category': 'Fantasy',
      'status': 'Borrowed'
    },
    {
      'id': 'F0002',
      'title': 'FANTASY ISLAND',
      'image': 'Assets/image/Recommend_3.jpg',
      'category': 'Fantasy',
      'status': 'Disabled',
    },
    {
      'id': 'F0003',
      'title': 'FROZEN',
      'image': 'Assets/image/Recommend_4.jpg',
      'category': 'Fantasy',
      'status': 'Pending',
    },
    {
      'id': 'F0004',
      'title': 'FINDING NEMO',
      'image': 'Assets/image/Recommend_2.jpg',
      'category': 'Fantasy',
      'status': 'Borrowed',
    },

    // Drama
    {
      'id': 'D0001',
      'title': 'How to ting',
      'image': 'Assets/image/D0001.jpg',
      'category': 'Drama',
      'status': 'Available'
    },
    {
      'id': 'D0002',
      'title': 'fan day',
      'image': 'Assets/image/D0002.jpg',
      'category': 'Drama',
      'status': 'Borrowed',
    },
    {
      'id': 'D0003',
      'title': 'lan ma',
      'image': 'Assets/image/D0003.jpg',
      'category': 'Drama',
      'status': 'Available',
    },

    // Comedy
    {
      'id': 'C0001',
      'title': 'The BATMAN',
      'image': 'Assets/image/Recommend_5.jpg',
      'category': 'Comedy',
      'status': 'Available',
    },
    {
      'id': 'C0002',
      'title': 'PEEMAK',
      'image': 'Assets/image/H0003.jpg',
      'category': 'History',
      'status': 'Borrowed',
    },
    {
      'id': 'C0003',
      'title': 'MONEYHEIST',
      'image': 'Assets/image/C00003.jpg',
      'category': 'Comedy',
      'status': 'Available',
    },
    {
      'id': 'C0004',
      'title': 'SYONG',
      'image': 'Assets/image/T0001.jpg',
      'category': 'Comedy',
      'status': 'Available',
    },

    // Crime
    {
      'id': 'CR0001',
      'title': 'FAST',
      'image': 'Assets/image/A0001.jpg',
      'category': 'Action',
      'status': 'Available',
    },
    {
      'id': 'CR0002',
      'title': 'ARTINTELLO',
      'image': 'Assets/image/C00002.jpg',
      'category': 'Crime',
      'status': 'Borrowed',
    },
    {
      'id': 'CR0003',
      'title': 'THE GODFATHER',
      'image': 'Assets/image/C00003.jpg',
      'category': 'Crime',
      'status': 'Available',
    },
    {
      'id': 'CR0004',
      'title': 'SARASIN',
      'image': 'Assets/image/R0004.jpg',
      'category': 'Romantic',
      'status': 'Available',
    },

    // Thriller
    {
      'id': 'T0001',
      'title': 'SYONG',
      'image': 'Assets/image/T0001.jpg',
      'category': 'Thriller',
      'status': 'Available',
    },
    {
      'id': 'T0002',
      'title': 'TWILIGHT',
      'image': 'Assets/image/T0002.jpg',
      'category': 'Thriller',
      'status': 'Borrowed',
    },

    {
      'id': 'T0004',
      'title': 'ANNABELLE',
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
            'Movie Assets',
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
            _buildDropdownAndAddButton(), // ใช้ฟังก์ชันใหม่
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
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

  Widget _buildStatusButton(String status) {
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

  void _editBook(Map<String, String> book) {
    TextEditingController titleController =
        TextEditingController(text: book['title']);
    TextEditingController idController =
        TextEditingController(text: book['id']);
    TextEditingController imagePathController =
        TextEditingController(text: book['image']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Book: ${book['title']}'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Book Name'),
                  ),
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(labelText: 'Book ID'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );
                      if (result != null) {
                        setState(() {
                          imagePathController.text = result.files.single.path!;
                        });
                      }
                    },
                    child: const Text('Choose Image'),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 44, 20, 229),
            ),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                book['title'] = titleController.text;
                book['id'] = idController.text;
                book['image'] = imagePathController.text;
              });
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 233, 12, 12),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
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

  Widget _buildDropdownAndAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 230, // Specify the desired width for the dropdown
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
                            textAlign: TextAlign.center,
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
          const SizedBox(width: 10), // Space between dropdown and button
          ElevatedButton(
            onPressed: () {
              _showAddBookDialog(); // Call function to show add book dialog
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 12, 29, 216),
                fixedSize: Size(70, 30) // Set button size
                ),
            child: const Text(
              'Add ',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBookDialog() {
    String bookTitle = '';
    String bookId = '';
    File? imagePath;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Book'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Book Name'),
                onChanged: (value) {
                  bookTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Book ID'),
                onChanged: (value) {
                  bookId = value;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );

                  if (result != null && result.files.single.path != null) {
                    setState(() {
                      imagePath = File(result.files.single.path!);
                    });
                  }
                },
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 10),
              if (imagePath != null)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 150,
                  child: Image.file(
                    imagePath!,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (bookTitle.isNotEmpty &&
                  bookId.isNotEmpty &&
                  imagePath != null) {
                setState(() {
                  books.add({
                    'title': bookTitle,
                    'id': bookId,
                    'image': imagePath!.path, // เก็บ path ของไฟล์
                    'status': 'Available',
                  });
                });
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
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
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: book['image']!.startsWith(
                            'Assets/') // Check if it's an asset path
                        ? Image.asset(
                            book['image']!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(book['image']!),
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  // Edit Icon
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      _editBook(book);
                    },
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    tooltip: 'Edit',
                    color: const Color.fromARGB(255, 6, 1, 249),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      book['title']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${book['id']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    _buildStatusButton(book['status']!),
                  ],
                ),
              ),
            ],
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

  BottomNavigationBarItem _buildBottomNavItem(
      String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: _buildIcon(iconPath, index),
      label: label,
    );
  }

  void _handleNavigation(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const HomeAdmin();
        break;

      case 2:
        page = ReturnAdmin(profileImage: widget.profileImage);
        break;
      case 3:
        page = DashboardAdmin(profileImage: widget.profileImage);
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
}
