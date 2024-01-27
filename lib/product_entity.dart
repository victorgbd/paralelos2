class Product {
  int? productoID;
  String? productoNombre;
  String? descripcion;
  String? precio;
  int? cantidadStock;
  int? reorden;
  int? categoriaID;
  String? categoriaNombre;
  int? proveedorID;
  String? proveedorNombre;

  Product(
      {this.productoID,
      this.productoNombre,
      this.descripcion,
      this.precio,
      this.cantidadStock,
      this.reorden,
      this.categoriaID,
      this.categoriaNombre,
      this.proveedorID,
      this.proveedorNombre});

  Product.fromJson(Map<String, dynamic> json) {
    productoID = json['ProductoID'];
    productoNombre = json['ProductoNombre'];
    descripcion = json['Descripcion'];
    precio = json['Precio'];
    cantidadStock = json['CantidadStock'];
    reorden = json['Reorden'];
    categoriaID = json['CategoriaID'];
    categoriaNombre = json['CategoriaNombre'];
    proveedorID = json['ProveedorID'];
    proveedorNombre = json['ProveedorNombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductoID'] = productoID;
    data['ProductoNombre'] = productoNombre;
    data['Descripcion'] = descripcion;
    data['Precio'] = precio;
    data['CantidadStock'] = cantidadStock;
    data['Reorden'] = reorden;
    data['CategoriaID'] = categoriaID;
    data['CategoriaNombre'] = categoriaNombre;
    data['ProveedorID'] = proveedorID;
    data['ProveedorNombre'] = proveedorNombre;
    return data;
  }
}
