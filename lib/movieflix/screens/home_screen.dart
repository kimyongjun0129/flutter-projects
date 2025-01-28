import 'package:flutter/material.dart';
import 'package:toonflix/movieflix/models/movie_model.dart';
import 'package:toonflix/movieflix/services/api_services.dart';
import 'package:toonflix/movieflix/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowMovies = ApiService.getNowMovies();
  final Future<List<MovieModel>> comeMovies = ApiService.getComeMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
              ),

              // Popular Movies title
              const Text(
                "Popular Movies",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Popular Movies posters
              SizedBox(
                //clipBehavior: Clip.hardEdge,
                height: 220,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, false, 300, 220);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // Now In Cinema title
              const Text(
                "Now in Cinemas",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // Now In Cinema posters
              SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: nowMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, true, 170, 170);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // Coming soon title
              const Text(
                "Coming soon",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // Coming soon posters
              SizedBox(
                height: 180,
                child: FutureBuilder(
                  future: comeMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, true, 150, 150);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 포스터 나열해주는 List
  ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot, bool needTitle,
      double width, double height) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        // 포스터 하나 분리
        return Movie(
          height: height,
          width: width,
          needTitle: needTitle,
          title: movie.title,
          thumb: movie.thumb,
          id: movie.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
    );
  }
}
