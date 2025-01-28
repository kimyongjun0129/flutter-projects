import 'package:flutter/material.dart';
import 'package:toonflix/movieflix/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final double width, height;
  final bool needTitle;
  final String title, thumb;
  final int id;

  const Movie({
    super.key,
    required this.width,
    required this.height,
    required this.needTitle,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Image.network(
              fit: BoxFit.cover,
              "https://image.tmdb.org/t/p/w500$thumb",
            ),
          ),
          needTitle
              ? const SizedBox(
                  height: 10,
                )
              : const SizedBox(),
          needTitle
              ? Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
