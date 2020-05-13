class User {
  final String username;
  final String url;
  final String avatar_url;
  final String html_url;

  User({this.username, this.url, this.avatar_url, this.html_url});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['login'],
      url: json['url'],
      avatar_url: json['avatar_url'],
      html_url: json['html_url']
    );
  }
}