import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiction_challenge/logic/states.dart';
import 'package:fiction_challenge/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  List<ProductModel> favorites = [];

  List<ProductModel> products = [];

  List<ProductModel> cartItems = [];

  void getAllFavorites() {
    FirebaseFirestore.instance
        .collection('favorites')
        .get()
        .then((value) => {
          value.docs.forEach((element) {
            favorites.add(ProductModel.fromJson(element));
            print(favorites.length);
            emit(GetFavoritesSuccess());
          })
    }).catchError((error) {});
  }

  void getAllProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element));
        print(products.length);
        emit(GetProductsSuccess());
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  void createProduct({
    required String name,
    required String description,
    String? image,
    required double price,
    required double salePrice,
    required int stock,
  }) {
    ProductModel productModel = ProductModel(
      name: name,
      description: description,
      image: productImage!.path,
      price: price,
      salePrice: salePrice,
      stock: stock,
    );
    final newProduct =
    FirebaseFirestore.instance
        .collection('products')
        .doc();
    newProduct.set(productModel.toMap()).then((value) {
      productModel.id = newProduct.id;
      products.add(productModel);
      emit(ProductAddedSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ProductAddedFail());
    });
  }

  bool isFavorite(ProductModel product) => favorites.where((element) => element.id == product.id).isNotEmpty;

  void makeFavorite({
    required ProductModel product,
  }) async {
    if(isFavorite(product)) {
      await FirebaseFirestore.instance.collection('favorites').doc(product.id).delete();
      favorites.removeWhere((element) => element.id == product.id);
      emit(FavoriteDeleted());
    } else {
      final favoriteModel = ProductModel(
        id : product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        salePrice: product.salePrice,
        image: product.image
      );
      FirebaseFirestore.instance.collection('favorites')
          .doc(product.id)
      .set(favoriteModel.toMap()).then((value) {
        favorites.add(favoriteModel);
        emit(FavoriteProductAddedSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(FavoriteProductAddedFail());
      });
    }
  }

  bool isAddedToCart(ProductModel product) => cartItems.where((element) => element.id == product.id).isNotEmpty;

  void addToCart({
  required ProductModel product
}) async {
    if(isAddedToCart(product)) {
      await FirebaseFirestore.instance.collection('cart').doc(product.id).delete();
      cartItems.removeWhere((element) => element.id == product.id);
      emit(CartItemDeleted());
    } else {
      final cartModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        salePrice: product.salePrice,
        stock: product.stock,
        image: product.image,
      );
      FirebaseFirestore.instance
          .collection('cart')
          .doc(product.id)
          .set(cartModel.toMap()).then((value) {
        cartItems.add(cartModel);
        emit(CartItemAddedSuccess());
      }).catchError((error) {
        emit(CartItemAddedFail());
      });
    }
  }

  File? productImage;
  var picker = ImagePicker();

  Future<void> addProductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(ProductImageAddedSuccess());
    } else {
      emit(ProductImageAddedFail());
    }
  }
}
