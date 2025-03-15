import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDdayScreen extends StatefulWidget {
  const AddDdayScreen({super.key});

  @override
  _AddDdayScreenState createState() => _AddDdayScreenState();
}

class _AddDdayScreenState extends State<AddDdayScreen> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  String _repeatOption = "없음";
  bool _includeStartDay = false;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showRepeatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("매주",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
                onTap: () => _selectRepeatOption("매주"),
              ),
              ListTile(
                title: const Text("매월",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
                onTap: () => _selectRepeatOption("매월"),
              ),
              ListTile(
                title: const Text("매년",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
                onTap: () => _selectRepeatOption("매년"),
              ),
              ListTile(
                title: const Text("없음",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
                onTap: () => _selectRepeatOption("없음"),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectRepeatOption(String option) {
    setState(() {
      _repeatOption = option;
    });
    Navigator.pop(context);
  }

  bool get _isFormComplete =>
      _titleController.text.isNotEmpty && _selectedDate != null;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("디데이 추가"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: _isFormComplete ? () {} : null,
            child: Text("완료",
                style: TextStyle(
                    color: _isFormComplete ? Colors.blue : Colors.grey)),
          ),
        ],
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf4f4f4),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("제목",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF808080))),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  hintText: "제목",
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFCFCFCF)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF4F4F4),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("날짜",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF808080))),
                      Text(
                        _selectedDate != null
                            ? DateFormat('yyyy.MM.dd').format(_selectedDate!)
                            : "날짜 선택",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFFC8C8C8)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: _showRepeatOptions,
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF4F4F4),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("일정 반복",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF808080))),
                      Text(_repeatOption,
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFFC8C8C8))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("설정일로부터 1일",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF808080))),
                  Switch(
                    value: _includeStartDay,
                    onChanged: (bool value) {
                      setState(() {
                        _includeStartDay = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
