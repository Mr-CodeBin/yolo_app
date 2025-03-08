import 'package:faker/faker.dart';
import 'dart:math';

class CardUtils {
  static Map<String, String> generateCardDetails() {
    final faker = Faker();
    String cardNum1 = '${Random().nextInt(9000) + 1000}';
    String cardNum2 = '${Random().nextInt(9000) + 1000}';
    String cardNum3 = '${Random().nextInt(9000) + 1000}';
    String cardNum4 = '${Random().nextInt(9000) + 1000}';

    String cardNumber =
        "$cardNum1 $cardNum2 $cardNum3 $cardNum4".split('').join(' ');
    String cardHolder = faker.person.name();
    String expiryDate =
        "${Random().nextInt(5) + 10}/${Random().nextInt(5) + 25}";

    return {
      'cardNum1': cardNum1,
      'cardNum2': cardNum2,
      'cardNum3': cardNum3,
      'cardNum4': cardNum4,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'expiryDate': expiryDate,
    };
  }
}
