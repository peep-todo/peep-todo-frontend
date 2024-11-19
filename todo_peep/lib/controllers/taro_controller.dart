import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaroController extends GetxController {
  RxBool selectCard = false.obs;
  RxBool loveFortune = false.obs;
  RxBool wealthFortune = false.obs;
  RxBool studyFortune = false.obs;
  RxString current = "애정운".obs;
  RxInt number = 0.obs;
  RxBool animation = false.obs;
  RxBool loveFortuneAnimation = false.obs;
  RxBool wealthFortuneAnimation = false.obs;
  RxBool studyFortuneAnimation = false.obs;

  //타로 카드 뒤집는 애니메이션이 끝나고 나서 3장의 카드를 등록활수있도록 수정
  //뒤집는 애니메이샨의 카드를 위젯을 생성

  // 모든 카드 리스트 생성
  final List<String> allCards = [
    // 메이저 아르카나
    'The Fool', 'The Magician', 'The High Priestess', 'The Empress',
    'The Emperor',
    'The Hierophant', 'The Lovers', 'The Chariot', 'Strength', 'The Hermit',
    'Wheel of Fortune', 'Justice', 'The Hanged Man', 'Death', 'Temperance',
    'The Devil', 'The Tower', 'The Star', 'The Moon', 'The Sun',
    'Judgment', 'The World',

    // // 마이너 아르카나 (컵)
    // 'Ace of Cups', '2 of Cups', '3 of Cups', '4 of Cups', '5 of Cups',
    // '6 of Cups', '7 of Cups', '8 of Cups', '9 of Cups', '10 of Cups',
    // 'Page of Cups', 'Knight of Cups', 'Queen of Cups', 'King of Cups',

    // // 마이너 아르카나 (펜타클)
    // 'Ace of Pentacles', '2 of Pentacles', '3 of Pentacles', '4 of Pentacles',
    // '5 of Pentacles',
    // '6 of Pentacles', '7 of Pentacles', '8 of Pentacles', '9 of Pentacles',
    // '10 of Pentacles',
    // 'Page of Pentacles', 'Knight of Pentacles', 'Queen of Pentacles',
    // 'King of Pentacles',

    // // 마이너 아르카나 (검)
    // 'Ace of Swords', '2 of Swords', '3 of Swords', '4 of Swords', '5 of Swords',
    // '6 of Swords', '7 of Swords', '8 of Swords', '9 of Swords', '10 of Swords',
    // 'Page of Swords', 'Knight of Swords', 'Queen of Swords', 'King of Swords',

    // // 마이너 아르카나 (막대기)
    // 'Ace of Wands', '2 of Wands', '3 of Wands', '4 of Wands', '5 of Wands',
    // '6 of Wands', '7 of Wands', '8 of Wands', '9 of Wands', '10 of Wands',
    // 'Page of Wands', 'Knight of Wands', 'Queen of Wands', 'King of Wands',
  ];

  RxList<dynamic> selectedCards = [].obs;

  @override
  void onInit() {
    super.onInit();
    reset();
  }

  void reset() {
    selectCard(false);
    selectedCards([]);
    loveFortune(false);
    wealthFortune(false);
    studyFortune(false);
    current("애정운");
    number(0);
    animation(false);
    loveFortuneAnimation(false);
    wealthFortuneAnimation(false);
    studyFortuneAnimation(false);
  }

  // 3장의 카드를 무작위로 선택하는 함수
  void selectRandomCards() {
    final random = Random();
    Set<String> selectedCardNames = {};

    while (selectedCards.length < 6) {
      // 3장의 카드(이름 + 방향)
      final cardName = allCards[random.nextInt(allCards.length)];

      // 카드가 이미 선택된 카드인지 확인
      if (!selectedCardNames.contains(cardName)) {
        selectedCardNames.add(cardName); // 중복 체크를 위한 카드 이름 추가
        final isReversed = random.nextBool(); // 랜덤으로 정방향/역방향 결정

        selectedCards.add(cardName); // 카드 이름 추가
        selectedCards.add(isReversed); // 방향 정보 추가
      }
    }
    selectCard(true);
    print(selectedCards);
  }

  //카드삭제와 변경
  void changeRandomCard() {
    reset();
  }

  // 카드 클릭시 카드선택하기
  void selectTaroCard() {
    //카드가 세장 선택된 이후일 경우 카드를 순서대로 보여줌?
    if (loveFortune == true.obs &&
        wealthFortune == true.obs &&
        studyFortune == true.obs) {
      return;
    } else if (selectCard == true.obs) {
      loveFortune == true.obs
          ? wealthFortune == true.obs
              ? studyFortune(true)
              : wealthFortune(true)
          : loveFortune(true);
    } else {
      selectRandomCards();
      //첫번쨰 카드 지정
      loveFortune(true);
      current("애정운");
    }
    selectCurrent();
  }

  //선택할 카드가 애정운, 재물운, 학업운중 무엇인지 표현하기 위한 변수
  void selectCurrent() {
    loveFortune == true.obs
        ? wealthFortune == true.obs
            ? current("학업&취업운")
            : current("재물운")
        : current("애정운");
  }

  //타로 카드 뒤집는 애니메이션을 위한 변수의 값변경
  void addNumber() {
    print(number);
    if (number.toInt() == 4) {
      return;
    }
    number += 2;
    number(number.toInt());
  }
}
