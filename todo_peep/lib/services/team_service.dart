import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamService {
  final String baseUrl = "http://172.30.1.65:8080/api/v1";
  //이 토큰값은 예삔이가 끝나기 전까지 사용 예정
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwiaWF0IjoxNzQzMTUzODg2LCJleHAiOjE3NDMxNTc0ODZ9.t8ahw7mqMoUtnwju4Zy_Xo-xQR9gTPF5IJ8lVlQhC9s";

  //팀 프로젝트 생성
  Future<Map<String, dynamic>> createTeamProject(
      {required Map<String, String> teamData}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/team'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(teamData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // 성공 시 데이터 반환
      } else {
        throw Exception('팀 생성 실패: ${response.body}');
      }
    } catch (e) {
      throw Exception('서버 요청 실패: $e');
    }
  }
}
