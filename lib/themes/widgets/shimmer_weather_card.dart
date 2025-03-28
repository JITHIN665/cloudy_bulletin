
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWeatherCard extends StatelessWidget {
  const ShimmerWeatherCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 120, height: 16, color: Colors.white),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(width: 100, height: 80, color: Colors.white),
                SizedBox(width: 16),
                Container(width: 60, height: 60, color: Colors.white),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (_) {
                return Column(
                  children: [
                    Icon(Icons.circle, color: Colors.white),
                    SizedBox(height: 6),
                    Container(width: 40, height: 10, color: Colors.white),
                    SizedBox(height: 4),
                    Container(width: 50, height: 8, color: Colors.white),
                  ],
                );
              }),
            ),
            SizedBox(height: 30),
            Container(width: 120, height: 14, color: Colors.white),
            SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (_, __) {
                  return Container(
                    width: 70,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 10, width: 40, color: Colors.white),
                          SizedBox(height: 8),
                          Icon(Icons.cloud, color: Colors.white),
                          SizedBox(height: 8),
                          Container(height: 10, width: 50, color: Colors.white),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
