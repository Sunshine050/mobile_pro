import 'package:flutter/material.dart';
import 'package:project/Login.dart';
import 'package:project/User/History_User.dart';
import 'dart:io';
import 'package:project/User/Home_User.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // ใช้สำหรับ jsonDecode

class BookassetUser extends StatefulWidget {
  final File? profileImage;
  final String? category;

  const BookassetUser({super.key, this.profileImage, this.category});

  @override
  State<BookassetUser> createState() => _BookassetpageState();
}

class _BookassetpageState extends State<BookassetUser> {
  int _selectedIndex = 1;
  String? _selectedCategory;
  List<dynamic> _assets = [];

  @override
  void initState() {
    super.initState();
    fetchAssets(); // ดึงข้อมูลจาก API เมื่อเริ่มหน้า
  }

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchAssets() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.206.1:3000/assets'), // แก้ไข URL ให้ตรงกับ API ของคุณ
        headers: {
          'Authorization': 'Bearer YOUR_TOKEN_HERE', // ใส่ token ของคุณ
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _assets = jsonDecode(response.body); // ใช้ _assets แทน books
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching assets: $e');
    }
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
          Expanded(
            child: Image.asset(
              'Assets/image/video-player.png',
              width: 50,
              height: 35,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 30),
          const Text(
            'Movie Assets',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay-ExtraBold',
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 30),
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
                          width: 40, height: 40, fit: BoxFit.cover),
                    )
                  : const Icon(Icons.account_circle,
                      size: 40, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 118, 117, 117),
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
      return _buildAssetListContent();
    } else {
      final filteredAssets = _assets
          .where((asset) => asset['category'] == _selectedCategory)
          .toList();

      return filteredAssets.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: filteredAssets.length,
              itemBuilder: (context, index) {
                final asset = filteredAssets[index];
                return _buildAssetCard(asset);
              },
            )
          : Center(
              child: Text('ไม่มีสินทรัพย์ในหมวดหมู่นี้',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
            );
    }
  }

  Widget _buildAssetListContent() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _assets.length,
      itemBuilder: (context, index) {
        final asset = _assets[index];
        return _buildAssetCard(asset);
      },
    );
  }

  Widget _buildAssetCard(Map<String, dynamic>? asset) {
    if (asset == null) {
      return Container();
    }

    return GestureDetector(
      onTap: () {
        // Handle asset tap
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
                  asset['image'] ?? '',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      asset['title'] ?? 'Title',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${asset['id'] ?? 'Unknown'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    _buildStatusButton(asset['status'] ?? 'Unknown', asset),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String status, Map<String, dynamic> book) {
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

    return GestureDetector(
      onTap: () {
        if (status == 'Available') {
          _showAvailablePopup(
              book['title'] ?? '', book['id'] ?? '', book['image'] ?? '');
        }
      },
      child: Container(
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
      ),
    );
  }

  void _showAvailablePopup(String title, String id, String imagePath) {
    final DateTime now = DateTime.now();
    final String currentDate = "${now.day}/${now.month}/${now.year}";

    TextEditingController dateController =
        TextEditingController(text: currentDate);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Borrow Asset'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Do you want to borrow "$title"?'),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Borrow Date'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Borrow Confirmed'),
                  content: Text('You have successfully borrowed "$title".'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> _buildDropdown() {
    return DropdownButton<String>(
      value: _selectedCategory,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      items: <String>['All', 'Book', 'Video', 'Magazine']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: const Text('Select Category'),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Book Assets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (_selectedIndex == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeUser()),
          );
        } else if (_selectedIndex == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryUser()),
          );
        }
      },
    );
  }
}
