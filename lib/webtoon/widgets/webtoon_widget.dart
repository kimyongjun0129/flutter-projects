import 'package:flutter/material.dart';
import 'package:toonflix/webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // 대부분의 동작을 감지한다.
    return GestureDetector(
      // 버튼을 탭했을 때 발생하는 이벤트이다.
      onTap: () {
        // Navigator를 이용해서 유저가 다른 화면으로 이동했다고 느끼게 해줄 수 있다. (실제로는 그냥 다른 statelessWidget을 랜더한 것 뿐이다.)
        // route : DetailScreen 같은 statelessWidget을 애니메이션 효과로 감싸서 스크린처럼 보이도록 한다.
        // MaterialPageRoutes : 클래스이다. statelessWidget을 감싸서 다른 스크린처럼 보이게 해준다.
        // builder는 route를 만드는 함수이다.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
          ),
        );
      },
      child: Column(
        children: [
          // 서브 트리 내에 동일한 tag가 있는 경우, 화면 전환 시 애니메이션을 자동으로 넣어준다.
          Hero(
            // 웹툰의 ID로 태그를 달아준 것이다.
            tag: id,
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
                thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
