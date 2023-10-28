import "package:flutter/material.dart";
import "package:flutter_project/utils/colors.dart";

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: BackButton(
          color: secondaryColor,
        ),
        title: Text(
          'Teacher',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "public/images/avatar.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, url, error) => const Icon(
                            Icons.error_outline_rounded,
                            size: 32,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
