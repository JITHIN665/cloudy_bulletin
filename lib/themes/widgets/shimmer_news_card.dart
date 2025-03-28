// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsCard extends StatelessWidget {
  const ShimmerNewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 200,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 140, width: double.infinity, color: Colors.white),
              SizedBox(height: 12),
              Container(height: 12, width: 200, color: Colors.white),
              SizedBox(height: 6),
              Container(height: 10, width: 150, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
