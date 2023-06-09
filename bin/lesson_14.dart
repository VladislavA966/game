import 'dart:io';
import 'dart:math';

void main() {
  print(
      'Выберите режим\n1 - Игрок угадывает \n2 - Компьютер угадывает \n3 - Соревнование');
  String choose = stdin.readLineSync()!;
  if (choose == '1') {
    game();
  } else if (choose == '2') {
    gameTwo();
  } else if (choose == '3') {
    gameThree();
  } else {
    print('Неправильный ввод');
  }
}

int game() {
  int counter = 0;
  int randomNumber = Random().nextInt(100) + 1;
  print('Я загадал число от 1 до 100, попробуй его отгадать');
  do {
    counter++;
    int number = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    if (counter <= 7) {
      if (randomNumber == number) {
        print('Вы выиграли');
        print('Вы выиграли за $counter попыток');
        break;
      } else if (randomNumber > number) {
        print('Число больше');
        print('Попыток осталось ${7 - counter}');
      } else if (randomNumber < number) {
        print('Число меньше');
        print('Попыток осталось ${7 - counter}');
      }
    } else {
      print('Число не верно, вы проиграли');
    }
  } while (counter <= 7);
  return counter;
}

gameTwo() {
  print('Загадайте число от 1 до 100.');
  print('Я буду пытаться угадать!');
  int counter = 0;
  int myNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  int lowLimit = 1;
  int upLimit = 100;
  String otvet;
  do {
    int varriant = lowLimit +
        ((upLimit - lowLimit) ~/
            2); //До этой формулы я так и не смог додумался, нашел её на Reddit, я делал просто varriant = (uppLimit - lowLimit) ~/ 2
    print('Ваше число $varriant? (yes/no)');
    otvet = stdin.readLineSync()!;
    if (otvet == 'yes') {
      print('Ура! Я угадал число $myNumber за $counter попыток');
      counter++;
      break;
    } else if (otvet == 'no') {
      counter++;
      print('Попыток осталось ${7 - counter}');
      print('Больше или меньше загаданного числа? (больше/меньше)');
      String otvet = stdin.readLineSync()!.toLowerCase();
      if (otvet == 'more') {
        lowLimit = varriant;
      } else if (otvet == 'less') {
        upLimit = varriant;
      } else {
        print('Некорректный ответ. Пожалуйста, ответьте "less" или "more".');
      }
    } else if (otvet != 'yes' || otvet != 'no') {
      print('Некорректный ответ. Пожалуйста, ответьте "yes" или "no".');
    } else if (counter > 7) {
      print('Попытки закончились, игра закончена');
      break;
    }
  } while (counter <= 7);
  return counter;
}

gameThree() {
  int userScore = 0;
  int aiScore = 0;
  int roundScore = 1;
  print(
      'Добро пожаловать в игру соревнование \nИгра будет состоять из нескольких раундов, игрок который угадал максимальное количество чисел за меньшее число попыток выиграл');
  print('Выберите число раундов до 10');
  int round = int.tryParse(stdin.readLineSync() ?? '') ?? 3;
  do {
    print('============================');
    print('Раунд $roundScore');
    int userCounter = game();

    int aiCounter = gameTwo();
    roundScore++;
    userScore += userCounter;
    aiScore += aiCounter;
  } while (roundScore <= round);
  if (userScore > aiScore) {
    print('Победил компьютер');
  } else if (userScore < aiScore) {
    print('Победил игрок');
  } else {
    print('У вас ничья');
  }
}
