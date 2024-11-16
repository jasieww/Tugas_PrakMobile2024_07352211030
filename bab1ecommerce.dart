// import pustaka supya kse sedia fitur program asinkron, contoh FUTURE
import 'dart:async';

// Enum untuk Peran Pengguna
// Mendefenisikan enum ROLE yg memiliki dua nilai yaitu nilai ADMIN DAN CUSTOMER yg kse tnju peran penggunna dan sistem
enum Role { Admin, Customer }

// Kelas untuk Produk
// inStock untuk cek status ketersedian produk

class Product {
  String productName;
  double price;
  bool inStock;

// Product disini as atribut
  Product({required this.productName, required this.price, required this.inStock});
}

// Kelas dasar untuk Pengguna
// <product> spya tau dftr yg dimiliki atau ada
// role (peran pengguna)
class User {
  String name;
  int age;
  late List<Product>? products;
  Role? role;

// konstruktor USER inisialisasi tribut dan kasih nilai default untuk produk kalo trda  
  User({required this.name, required this.age, this.role, List<Product>? products}) {
    this.products = products ?? [];
  }
}

// Subkelas untuk Pengguna Admin
class AdminUser extends User {
  AdminUser({required String name, required int age}) : super(name: name, age: age, role: Role.Admin);

  // Metode untuk menambahkan produk
  void addProduct(Product product, Map<String, Product> productList) {
    if (product.inStock) {
      if (!productList.containsKey(product.productName)) {
        productList[product.productName] = product;
        print('Produk \"${product.productName}\" berhasil ditambahkan.');
      } else {
        print('Produk \"${product.productName}\" sudah ada.');
      }
    } else {
      try {
        throw Exception('Produk \"${product.productName}\" tidak tersedia di stok.');
      } on Exception catch (e) {
        print('Error: ${e.toString()}');
      }
    }
  }

  // Metode untuk menghapus produk
  void removeProduct(String productName, Map<String, Product> productList) {
    if (productList.containsKey(productName)) {
      productList.remove(productName);
      print('Produk \"$productName\" berhasil dihapus.');
    } else {
      print('Produk \"$productName\" tidak ditemukan.');
    }
  }
}

// Subkelas untuk Pengguna Customer
class CustomerUser extends User {
  CustomerUser({required String name, required int age}) : super(name: name, age: age, role: Role.Customer);

  // Metode untuk melihat produk
  void viewProducts(Map<String, Product> productList) {
    if (productList.isEmpty) {
      print('Tidak ada produk yang tersedia.');
    } else {
      print('Produk yang tersedia:');
      productList.forEach((name, product) {
        print('${product.productName} - Rp${product.price} - Tersedia: ${product.inStock ? 'Ya' : 'Tidak'}');
      });
    }
  }
}

// Simulasi pengambilan detail produk
Future<void> fetchProductDetails() async {
  print('Mengambil detail produk...');
  await Future.delayed(Duration(seconds: 2));
  print('Detail produk berhasil diambil!');
}

void main() async {
  // Membuat daftar produk menggunakan Map
  Map<String, Product> productList = {};
 
  // Membuat beberapa produk contoh
  Product product1 = Product(productName: 'Laptop', price: 12000000.0, inStock: true);
  Product product2 = Product(productName: 'Komputer', price: 1500000.0, inStock: true);
  Product product3 = Product(productName: 'Hp', price: 8000000.0, inStock: false);

  // Membuat pengguna Admin
  AdminUser admin = AdminUser(name: 'Jasie', age: 19);

  // Admin menambahkan produk
  admin.addProduct(product1, productList);
  admin.addProduct(product2, productList);
  admin.addProduct(product3, productList); // Akan memicu exception

  // Membuat pengguna Customer
  CustomerUser customer = CustomerUser(name: 'Lisa', age: 19);

  // Customer melihat produk
  customer.viewProducts(productList);

  // Mengambil detail produk (asinkron)
  await fetchProductDetails();
}
