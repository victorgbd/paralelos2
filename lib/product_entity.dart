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

class CategoryEntity {
  final int id;
  final String nombre;

  const CategoryEntity({required this.id, required this.nombre});
}

const categories = [
  CategoryEntity(id: 1, nombre: 'Bebidas'),
  CategoryEntity(id: 2, nombre: 'Snacks'),
  CategoryEntity(id: 3, nombre: 'Electronica'),
  CategoryEntity(id: 4, nombre: 'Ropa'),
  CategoryEntity(id: 5, nombre: 'Hogar'),
  CategoryEntity(id: 6, nombre: 'Deportes')
];

class Supplier {
  final int id;
  final String nombre;

  const Supplier({required this.id, required this.nombre});
}

const suppliers = [
  Supplier(id: 1, nombre: 'Juanito'),
  Supplier(id: 2, nombre: 'Cerveceria'),
  Supplier(id: 3, nombre: 'Mamonte')
];
