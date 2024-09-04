import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_peep/widgets/team/invite_member.dart';

class ProjectCreate extends StatelessWidget {
  const ProjectCreate({super.key});

  void onClickShareUrl(String url) {
    final shareURL = url;
    Share.share(
      shareURL,
      subject: '초대 링크 공유하기',
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //뒤로가기 버튼 제거
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "완료",
              style: TextStyle(
                color: Color(0xffbcbcbc),
                fontSize: 16,
                fontWeight: FontWeight.w500, // 텍스트 색상 설정
              ),
            ),
          ),
        ],
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "팀 프로젝트를 생성했어요!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 31),
                // Image.asset('assets/images/team/project_create_emo.png'),
                Lottie.asset(
                  'assets/images/team/team_create_emo.json',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 52),
                Container(
                  width: screenWidth * 0.4,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff424656),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            width: screenWidth - 20,
                            height: screenHeight * 0.65, // 원하는 높이로 설정
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: InviteMember(),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      "팀원 초대하기",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "초대 링크",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                GestureDetector(
                  onTap: () {
                    onClickShareUrl("www.naver.com입니다. 글까지 넘어가나?");
                  },
                  child: Container(
                    width: screenWidth - 58,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffCFCFCF).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "https://www.figma.com/design/U23RIAk5W5V",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff808080),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(screenWidth - 58, 34),
                    side: const BorderSide(color: Color(0xffcfcfcf)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/team/link.svg"),
                      const SizedBox(width: 7),
                      const Text(
                        "링크 복사하기",
                        style: TextStyle(
                          color: Color(0xff424656),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        // 아래쪽(border bottom)에만 테두리 적용
                        color: Colors.black, // 테두리 색상
                        width: 1, // 테두리 두께
                      ),
                    )),
                    child: const Text(
                      "다음에 초대하기",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
