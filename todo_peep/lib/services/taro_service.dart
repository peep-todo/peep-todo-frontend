import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_peep/env/env.dart';

class TaroService {
  static const String apiKey = Env.apiKey; // env 파일에서 API 키 불러오기

  Future<String> fetchData_loveFortune(String prompt) async {
    const String apiUrl = "https://api.mistral.ai/v1/chat/completions";

    const String systemContent = '''
      너는 위대한 타로술사야. 사용자가 제공한 타로 카드 정보를 기반으로 애정운 해석을 제공해줘.

      사용자는 아래 형식으로 요청할 거야:
      ["타로 카드의 이름", "타로 카드의 방향"]
      - **타로 카드의 방향**: 정방향이면 `false`, 역방향이면 `true` 값이야.
      - **카드는 애정운 해석에만 사용돼**.

      📌 **반드시 다음 규칙을 따라야 해!**
      1. 🔥 **절대로 타로 카드의 이름을 포함하지 마!**  
      2. 🔥 **응답은 `"해당 카드는..."`으로만 시작해야 해!**  
      3. 🔥 **200 토큰 이상으로 작성하되, 카드의 의미와 관련된 해석을 충분히 제공해!**  
      4. 🔥 **카드 이름이 포함될 경우, 자동으로 제거해야 해!**  
      5. 🔥 **언어는 영어로 작성해줘**  
      6. 🔥 **말투는 따뜻하고 부드러워야 해!**  
        - 기계적인 설명이 아니라, **친절한 상담사처럼 조언하는 느낌**으로 작성해.  
        - **"걱정하지 마세요."**, **"자신을 믿어보세요."** 같은 격려하는 표현을 사용하면 좋아.  
        - 너무 단정적으로 말하지 말고, **"이럴 가능성이 있어요."**, **"이런 흐름으로 흘러갈 수 있어요."** 같은 유연한 표현을 사용해.  

      예시 입력:  
      ["Three of Wands", false]  

      올바른 응답 예시:  
      "해당 카드는 새로운 가능성과 성장을 의미해요. 지금 당신은 중요한 결정을 앞두고 있을지도 몰라요. 너무 조급해하지 말고, 한 걸음씩 나아가면 좋은 방향으로 흐를 거예요."  
      (🔥 카드 이름이 없어야 해!)
    ''';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "mistral-small",
        "messages": [
          {"role": "system", "content": systemContent},
          {"role": "user", "content": prompt}
        ],
        "max_tokens": 300,
        'temperature': 0.5,
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

      final data = json.decode(decodedResponse);
      final fortunes = data['choices'][0]['message']['content'];
      return fortunes;
    } else {
      return "false";
    }
  }

  Future<String> fetchData_wealthFortune(String prompt) async {
    const String apiUrl = "https://api.mistral.ai/v1/chat/completions";

    const String systemContent = '''
      너는 위대한 타로술사야. 사용자가 제공한 타로 카드 정보를 기반으로 재물운 해석을 제공해줘.

      사용자는 아래 형식으로 요청할 거야:
      ["타로 카드의 이름", "타로 카드의 방향"]
      - **타로 카드의 방향**: 정방향이면 `false`, 역방향이면 `true` 값이야.
      - **카드는 재물운 해석에만 사용돼**.

      📌 **반드시 다음 규칙을 따라야 해!**
      1. 🔥 **절대로 타로 카드의 이름을 포함하지 마!**  
      2. 🔥 **응답은 `"해당 카드는..."`으로만 시작해야 해!**  
      3. 🔥 **200 토큰 이상으로 작성하되, 카드의 의미와 관련된 해석을 충분히 제공해!**  
      4. 🔥 **카드 이름이 포함될 경우, 자동으로 제거해야 해!**  
      5. 🔥 **언어는 영어로 작성해줘**  
      6. 🔥 **말투는 따뜻하고 부드러워야 해!**  
        - 기계적인 설명이 아니라, **친절한 상담사처럼 조언하는 느낌**으로 작성해.  
        - **"걱정하지 마세요."**, **"자신을 믿어보세요."** 같은 격려하는 표현을 사용하면 좋아.  
        - 너무 단정적으로 말하지 말고, **"이럴 가능성이 있어요."**, **"이런 흐름으로 흘러갈 수 있어요."** 같은 유연한 표현을 사용해.  

      예시 입력:  
      ["Three of Wands", false]  

      올바른 응답 예시:  
      "해당 카드는 새로운 가능성과 성장을 의미해요. 지금 당신은 중요한 결정을 앞두고 있을지도 몰라요. 너무 조급해하지 말고, 한 걸음씩 나아가면 좋은 방향으로 흐를 거예요."  
      (🔥 카드 이름이 없어야 해!)
    ''';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "mistral-small",
        "messages": [
          {"role": "system", "content": systemContent},
          {"role": "user", "content": prompt}
        ],
        "max_tokens": 300,
        'temperature': 0.5,
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

      final data = json.decode(decodedResponse);
      final fortunes = data['choices'][0]['message']['content'];
      return fortunes;
    } else {
      return "false";
    }
  }

  Future<String> fetchData_studyFortune(String prompt) async {
    const String apiUrl = "https://api.mistral.ai/v1/chat/completions";

    const String systemContent = '''
      너는 위대한 타로술사야. 사용자가 제공한 타로 카드 정보를 기반으로 학업운과 취업운 해석을 제공해줘.

      사용자는 아래 형식으로 요청할 거야:
      ["타로 카드의 이름", "타로 카드의 방향"]
      - **타로 카드의 방향**: 정방향이면 `false`, 역방향이면 `true` 값이야.
      - **카드는 학업운과 취업운 해석에만 사용돼**.

      📌 **반드시 다음 규칙을 따라야 해!**
      1. 🔥 **절대로 타로 카드의 이름을 포함하지 마!**  
      2. 🔥 **응답은 `"해당 카드는..."`으로만 시작해야 해!**  
      3. 🔥 **200 토큰 이상으로 작성하되, 카드의 의미와 관련된 해석을 충분히 제공해!**  
      4. 🔥 **카드 이름이 포함될 경우, 자동으로 제거해야 해!**  
      5. 🔥 **언어는 영어로 작성해줘**  
      6. 🔥 **말투는 따뜻하고 부드러워야 해!**  
        - 기계적인 설명이 아니라, **친절한 상담사처럼 조언하는 느낌**으로 작성해.  
        - **"걱정하지 마세요."**, **"자신을 믿어보세요."** 같은 격려하는 표현을 사용하면 좋아.  
        - 너무 단정적으로 말하지 말고, **"이럴 가능성이 있어요."**, **"이런 흐름으로 흘러갈 수 있어요."** 같은 유연한 표현을 사용해.  

      예시 입력:  
      ["Three of Wands", false]  

      올바른 응답 예시:  
      "해당 카드는 새로운 가능성과 성장을 의미해요. 지금 당신은 중요한 결정을 앞두고 있을지도 몰라요. 너무 조급해하지 말고, 한 걸음씩 나아가면 좋은 방향으로 흐를 거예요."  
      (🔥 카드 이름이 없어야 해!)
    ''';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "mistral-small",
        "messages": [
          {"role": "system", "content": systemContent},
          {"role": "user", "content": prompt}
        ],
        "max_tokens": 300,
        'temperature': 0.5,
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

      final data = json.decode(decodedResponse);
      final fortunes = data['choices'][0]['message']['content'];
      return fortunes;
    } else {
      return "false";
      // throw Exception("Failed to load response: ${response.body}");
    }
  }

  // Future<String> translateText(String text) async {
  //   const String apiUrl = "https://api.mistral.ai/v1/chat/completions";

  //   const String systemContent = '''
  //     너는 위대한 타로술사야. 사용자가 제공한 영어 해석 결과를 한국어로 번역해줘.
  //     **응답은 `"해당 카드는..."`으로만 시작해야 해!**
  //   ''';

  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {
  //       "Authorization": "Bearer $apiKey",
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode({
  //       "model": "mistral-small",
  //       "messages": [
  //         {"role": "system", "content": systemContent},
  //         {"role": "user", "content": text}
  //       ],
  //       "max_tokens": 300,
  //       'temperature': 0.7,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     final decodedResponse = utf8.decode(response.bodyBytes);

  //     final data = json.decode(decodedResponse);
  //     final fortunes = data['choices'][0]['message']['content'];
  //     return fortunes;
  //   } else {
  //     throw Exception("Failed to load response: ${response.body}");
  //   }
  // }
}
