import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/Products.dart';
import '../model/User.dart';

//เก็บข้อมูลตัวแปลไว้ เพื่อกระจายไปยังหน้าต่างๆ
Appservice appservice = Appservice();

class Appservice {
  String email = "";
  TextEditingController Emaillogin = TextEditingController();
}

class ProviderSer extends ChangeNotifier {
  String reademail = "";
  List<File> imgfile = [];
  List<String> imgurl = [];
  ModelUsers user = ModelUsers(username: "", userpass: "", useraddress: "", usertel: "");
  String? url; 
  File? imgtest; 
  final FirebaseStorage store = FirebaseStorage.instance;
  // ProviderSer(this.store);
  List<File> get imagesFile => imgfile;
  File? get imagesFile2 => imgtest;
  ModelUsers get usermodel => user;
  String get keyuser => key;
  String key = ""; 
 FirebaseFirestore fireStore = FirebaseFirestore.instance;
void logout () {
 reademail = "";
 imagesFile.clear();
 imgurl.clear();
 url = null;
 imgtest = null;
}

void setuser (String name,String password,String address,String tel){
user.username = name;
user.userpass = password;
user.useraddress = address;
user.usertel = tel;
notifyListeners();
}

void addFile(List<File> images) {
    imgfile.addAll(images);
    notifyListeners();
    imgtest = File(images.first.path);
    notifyListeners();
  }

void createcol(String mail) async{
  
   final cartRef = fireStore.collection('products').doc(mail);
    //final products = _products.map((p) => p.toJson()).toList();
    List<Product> pro = [];
    final products = pro.map((p) => p.toJson()).toList();
    await cartRef.set({'products': products});
}
  void setemail(String mail) async{
    reademail = mail;
    url = await getProfileImageUrl();
    print(url);
    notifyListeners();
  }

    void setkey(String keyuser) async{
    key = keyuser;
    notifyListeners();
  }
Future<void> deleteOldImage() async {
    final ref = store.ref('users/$reademail/image');
    final result = await ref.listAll();
    if (result.items.isNotEmpty) {
      for (var element in result.items) {
        element.delete();
      }
    }
  }
Future<String?> getProfileImageUrl() async {
    try {
      final ref = store.ref('users/$reademail/image');
      final result = await ref.listAll();
      if (result.items.isNotEmpty) {
        final url = await result.items.first.getDownloadURL();
        print(url);
        return url;
      }
      return null;
    } catch (e) {
      print('Error getting profile image URL: $e');
    }
    return null;
  }

  Future<void> uploadImages() async {

    if (reademail == "") {
      notifyListeners();
    }

    if (imgfile.isEmpty) {
      notifyListeners();
    }
    await deleteOldImage();

    try {
      for (int i = 0; i < imgfile.length; i++) {
        String imageName = const Uuid().v4();
        final Reference storageRef =
            FirebaseStorage.instance.ref('users/${reademail}/image/$imageName');
        final UploadTask uploadTask = storageRef.putFile(imgfile[i]);
        final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {
          print("Upload for ${reademail} with Image $imageName");
        });
        final String url = await downloadUrl.ref.getDownloadURL();
        imgurl.add(url);
      }
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      imgfile.clear();
      notifyListeners();
    }
  }
}

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ProductProvider() {

  }

  void logout (){
    _products.clear();
  }

  Future<void> addProduct(Product product,String email) async {
    print("h[alkghp[ahlpamhp[alehpalwpal;e___]]]"+email);
    final cartRef = fireStore.collection('products').doc(email);
    //final products = _products.map((p) => p.toJson()).toList();
    List<Product> pro = [];
    pro.add(product);
    final products = pro.map((p) => p.toJson()).toList();
    await cartRef.update({'products': FieldValue.arrayUnion(products)});
    await initProducts(email);
    notifyListeners();
  }

  Future<void> initProducts(String email) async {
    final fireCart = fireStore.collection('products').doc(email);
    final snapshot = await fireCart.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      print(data['products']);
      final List<dynamic> productsData = data['products'] ?? [];
      final products = productsData
          .map((productData) => Product.fromJson(productData))
          .toList();
      _products = products;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<String> uploadProfileImage(File image,String email) async {
    String imageName = const Uuid().v4();
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${email}/medicine_image/$imageName');
    UploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }
}

class CartProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CartProvider() {
    
  }

  void logout(){
    _products.clear();
  }

  double get totalPrice => _products.fold(
      0, (total, product) => total + product.price * product.quantity);

  void addProduct(Product product,String email) async {
    final index = _products.indexWhere((p) => p.name == product.name);
    final cartRef = fireStore.collection('carts').doc(email);
    if (index != -1) {
      _products[index].quantity += product.quantity;
      final productss = _products.map((p) => p.toJson()).toList();
      await cartRef.update({'products': productss});
    } else {
      _products.add(product);
      
      final products = _products.map((p) => p.toJson()).toList();
      await cartRef.set({'products': products});
    }
    notifyListeners();
  }

  Future<void> getProductsInCart(String email) async {
    final fireCart = fireStore.collection('carts').doc(email);
    final snapshot = await fireCart.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> productsData = data['products'] ?? [];
      final products = productsData
          .map((productData) => Product.fromJson(productData))
          .toList();
      _products = products;
      notifyListeners();
    }
    notifyListeners();
  }

  void removeProduct(Product product,String email) async {
    _products.removeWhere((p) => p.name == product.name);
    final cartRef = fireStore.collection('carts').doc(email);
    await cartRef.update({
      'products': FieldValue.arrayRemove([product.toJson()])
    });
    notifyListeners();
  }
}
