import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async {
    //final url = Uri.parse("http://google.com");
    //await launchUrl(url);
    // 위 2줄을 요약하면 아랫줄이다.
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        // Container 내에서 공간을 주고싶을때 sized box 대신 이걸 사용
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                // 그림자 범위
                blurRadius: 5,
                offset: Offset(3, 5),
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title이 길어짐을 보완하고자 추가
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  // 텍스트 줄바꿈 여부
                  softWrap: false,
                  episode.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
