class User {
  String username;
  String password;
  //String id;

  //User({required this.username, required this.password, required this.id});
  User({required this.username, required this.password});

  String getNombre() {
    return username;
  }

  void setNombre(String username) {
    this.username = username;
  }

  String getApellido() {
    return password;
  }

  void setApellido(String password) {
    this.password = password;
  }

  @override
  String toString() {
    return "Nombre: $username $password";
  }
}
