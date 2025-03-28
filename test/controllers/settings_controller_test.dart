import 'package:flutter_test/flutter_test.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';

void main() {
  late SettingsController controller;

  setUp(() {
    controller = SettingsController();
  });

  test('Initial unit is Celsius', () {
    expect(controller.unit.value, 'Celsius');
  });

  test('Toggle temperature unit updates value', () {
    controller.setUnit('Fahrenheit');
    expect(controller.unit.value, 'Fahrenheit');
  });

  test('Select and deselect categories', () {
    controller.toggleCategory('business');
    expect(controller.selectedCategories, contains('business'));

    controller.toggleCategory('business');
    expect(controller.selectedCategories, isNot(contains('business')));
  });

  test('Cannot select more than 5 categories', () {
    final five = ['a', 'b', 'c', 'd', 'e'];
    for (var cat in five) {
      controller.toggleCategory(cat);
    }
    controller.toggleCategory('f');
    expect(controller.selectedCategories.length, 5);
  });
}
