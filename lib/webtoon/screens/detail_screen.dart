import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/webtoon/models/webtoon_detail_model.dart';
import 'package:toonflix/webtoon/models/webtoon_episode_model.dart';
import 'package:toonflix/webtoon/services/api_services.dart';
import 'package:toonflix/webtoon/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  // 중요!!!!! ** 어떤 property를 초기화할 때, 다른 property로는 접근이 불가능하다.
  // 이 문제를 해결하기 위해서는 DetailScreen을 statefulWidget을 변경해야 한다.
  //Future<WebtoonDetailModel> webtoon = ApiService.getToonById(id);

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

// 1. statefulWidget이 되면서 이 부분은 별도의 클래스로 바뀌게 된다.
class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  // Instance 생성 = 사용자의 저장소에 connection이 생겼다
  Future initPrefs() async {
    // 핸드폰 저장소에 액세스를 얻는다.
    prefs = await SharedPreferences.getInstance();
    // likedToons List 있으면 likedToons 변수에 넣어주고 없으면 null
    final likedToons = prefs.getStringList('likedToons');

    // 사용자가 현재 보고있는 웹툰이 likedToons 안에 있는지 없는지 확인해야 한다.
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    }
    // 실행자가 처음으로 앱을 실행할 때는 likedToons가 존재하지 않기 때문에 만들어주는 것이다.
    else {
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatesEpisodesById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      // 좋아요 유무를 판단 => id를 추가, 제거
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      // 리스트를 저장소에 다시 저장
      // null이면 안되기 때문에 if 문 안에다 추가
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        centerTitle: true,
        // 관심웹툰 등록
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite_outlined : Icons.favorite_border,
            ),
          ),
        ],
        title: Text(
          // 2. 그래서 단순히 title만으로는 찾지 못하여, widget.title로 변경이 된것이다.
          // widget.title에서 widget은 DetailScreen을 의미한다. (State가 속한 build method가 Statefulwidget의 data를 받아오는 방법)
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      // body에 감싸야 한다.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 50,
          ),
          child: Column(
            children: [
              // 포스터
              Center(
                child: Hero(
                  tag: widget.id,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                        // BorderRadius를 적용하기 위해서는 clipBehavior를 통해 자식의 부모 영역 침범을 제어해야 한다.
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            // 그림자 범위
                            blurRadius: 15,
                            offset: Offset(5, 10),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ]),
                    clipBehavior: Clip.hardEdge,
                    child:
                        // 이미지를 작게 만들려면 우선 SizedBox, Container 안에 넣어야 한다.
                        Image.network(
                      widget.thumb,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // Builder : Widget을 return하는 function이다.
              // future : 미래의 잠재적인 값을 결정하게 되고 정보를 불러오는 도안 어떤 걸 보여줄지 선택할 수 있도록 해준다.
              // FutureBuilder : 데이터를 다 받기 전에 먼저 데이터가 없이 그릴 수 있는 부분을 먼저 그려주기 위해 사용.
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),

              // 최신화 목록 및 버튼
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId: widget.id),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
