import 'package:flutter/material.dart';
import 'package:toonflix/webtoon/models/webtoon_model.dart';
import 'package:toonflix/webtoon/services/api_services.dart';
import 'package:toonflix/webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      // FutureBuilder가 webtoons 앞에 자동으로 await를 붙여주고 Future가 완료되는 것을 기다려준다.
      body: FutureBuilder(
        future: webtoons,
        // snapshot을 이용하면 Future의 상태를 알 수 있다.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // ListView에는 높이 값이 없다. (=> Coulmn은 ListView가 얼마나 큰지 모른다. => ListView에 제한된 높이를 준다.)
                // Expanded : 화면의 남는 공간을 차지하는 위젯
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    // 많은 양의 데이터를 연속적으로 보여주고싶을 때 사용. (Column, Row 부적절)
    // .builder : 좀 더 최적화된 ListView이다.
    // .sepated : .builder에서 구분자 추가(List 사이에 어떤 걸 해줄 건지)
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      // dart가 몇 개의 아이템을 build 할 건지 정해주는 것
      itemCount: snapshot.data!.length,
      // ListView.builder가 아이템을 build할 때 호출하는 함수이다.
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // 인덱스를 이용해서 어떤 아이템이 build 되고 있는지 알 수 있다.
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
