class User {
  int? usuarioID;
  String? nombreUsuario;
  String? contraseA;
  String? nombreCompleto;
  String? rol;

  User(
      {this.usuarioID,
      this.nombreUsuario,
      this.contraseA,
      this.nombreCompleto,
      this.rol});

  User.fromJson(Map<String, dynamic> json) {
    usuarioID = json['UsuarioID'];
    nombreUsuario = json['NombreUsuario'];
    contraseA = json['Contraseña'];
    nombreCompleto = json['NombreCompleto'];
    rol = json['Rol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UsuarioID'] = usuarioID;
    data['NombreUsuario'] = nombreUsuario;
    data['Contraseña'] = contraseA;
    data['NombreCompleto'] = nombreCompleto;
    data['Rol'] = rol;
    return data;
  }
}
