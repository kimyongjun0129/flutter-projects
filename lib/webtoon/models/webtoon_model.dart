class WebtoonModel {
  final String title, thumb, id;

  // named constructor를 사용. 많이 쓰이니 기억하자
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
