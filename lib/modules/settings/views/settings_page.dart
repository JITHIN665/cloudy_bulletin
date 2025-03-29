import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';
import 'package:cloudy_bulletin/support/connectivity_guard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final controller = Get.find<SettingsController>();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityGuard(
      child: Scaffold(
        appBar: AppBar(title: Text('Settings', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700)), centerTitle: true),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 209, 199, 233), Color.fromARGB(255, 238, 201, 227)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Obx(() {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Temperature Unit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          Text('°C'),
                          Switch(
                            activeTrackColor: Color(0xFFa18cd1),
                            inactiveThumbColor: Color(0xFFa18cd1),
                            value: controller.unit.value == 'Fahrenheit',
                            onChanged: (val) {
                              controller.setUnit(val ? 'Fahrenheit' : 'Celsius');
                            },
                          ),
                          Text('°F'),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 30, color: Colors.black),
                  Text('Select up to 5 News Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 5,
                    children:
                        controller.categories.map((category) {
                          final isSelected = controller.selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            backgroundColor: Colors.grey[400],
                            checkmarkColor: Colors.white,
                            onSelected: (selected) {
                              controller.toggleCategory(category);
                            },
                          );
                        }).toList(),
                  ),
                  if (controller.selectedCategories.length >= 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('Maximum 5 categories allowed.', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
