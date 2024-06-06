class Camiones {
  String idcamion;
  String patente;
  String descripcion;

  Camiones({
    required this.idcamion,
    required this.patente,
    required this.descripcion,
  });

  get getPatente => this.patente;

  set setPatente(patente) => this.patente = patente;

  get getDescripcion => this.descripcion;

  set setDescripcion(descripcion) => this.descripcion = descripcion;

  get getIdcamion => this.idcamion;

  set setIdcamion(String idcamion) => this.idcamion = idcamion;

  @override
  String toString() {
    return "El camion: $descripcion";
  }
}
