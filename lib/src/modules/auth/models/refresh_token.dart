class RefreshToken {
  late String accessToken;
  late String refreshToken;

  RefreshToken(String accessToken_, String refreshToken_) {
    accessToken = accessToken_;
    refreshToken = refreshToken_;
  }

  RefreshToken.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
