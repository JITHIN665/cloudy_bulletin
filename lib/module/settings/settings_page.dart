import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final controller = Get.find<SettingsController>(); // ✅ keep controller alive

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Get.find<HomeController>().fetchWeatherAndNews(); // ✅ apply changes
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Wrap(
                spacing: 10,
                children: controller.categories.map((category) {
                  final isSelected =
                      controller.selectedCategories.contains(category);
                  return FilterChip(
                    selectedColor: Colors.green,
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      controller.toggleCategory(category);
                    },
                  );
                }).toList(),
              ),
              Divider(height: 32),
              ListTile(
                title: Text("Temperature Unit"),
                trailing: DropdownButton<String>(
                  value: controller.unit.value,
                  items: ['Celsius', 'Fahrenheit']
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) => controller.setUnit(val!),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
