import 'package:flutter/material.dart';

class InviteMember extends StatelessWidget {
  const InviteMember({super.key});
  //나중에 검색정보? get이용하려나?
  // String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xffE5E8EB),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          const SizedBox(height: 21),
          Container(
            width: screenWidth,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffeeeeee).withOpacity(0.5),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: TextField(
                style: TextStyle(fontSize: 14),
                textAlignVertical: TextAlignVertical.center,
                // onChanged: () {},
                decoration: InputDecoration(
                  hintText: '친구를 찾아보세요',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xff808080),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 22,
                    color: Color(0xffcfcfcf),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
