class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  String username = '';
  setUsername(String _username){
    username = _username;
  }

  getUsername(){
    return username;
  }
}