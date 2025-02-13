import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenNotFound extends StatelessWidget {
  const ScreenNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              "Screen Not Found",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "The requested screen could not be found.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child:
                  const Text("Go Back", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
