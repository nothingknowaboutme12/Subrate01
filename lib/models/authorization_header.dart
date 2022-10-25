
class AuthorizationHeader{
  late String token;

  AuthorizationHeader({required String token}){
    this.token = 'Bearer $token';
  }
}