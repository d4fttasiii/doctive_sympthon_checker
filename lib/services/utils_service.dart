import 'dart:math';

class UtilsService {
  List<int> generateUniqueRandomNumbers(int count, int max) {
    final rng = Random();
    final numbers = Set<int>();

    while (numbers.length <= count) {
      numbers.add(rng.nextInt(max));
    }

    return numbers.toList();
  }
}
