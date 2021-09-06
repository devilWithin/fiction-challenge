import 'dart:io';

import 'package:fiction_challenge/components.dart';
import 'package:fiction_challenge/logic/cubit.dart';
import 'package:fiction_challenge/logic/states.dart';
import 'package:fiction_challenge/screens/cart_screen.dart';
import 'package:fiction_challenge/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add_product_screen.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              navigateTo(context, AddProductScreen());
            },
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      Container(color: Colors.deepOrange, height: 1),
                  itemCount: cubit.products.length,
                  itemBuilder: (context, index) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    actions: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          child: IconSlideAction(
                            caption: cubit.isFavorite(cubit.products[index])
                                ? 'UnFavorite'
                                : 'Favorite',
                            color: cubit.isFavorite(cubit.products[index])
                                ? Colors.deepOrange
                                : Colors.grey,
                            icon: Icons.favorite,
                            onTap: () {
                              cubit.makeFavorite(
                                product: cubit.products[index],
                              );
                            },
                          ),
                          height: 100,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          child: IconSlideAction(
                            caption: cubit.isAddedToCart(cubit.products[index])
                                ? 'Remove From Cart'
                                : 'Add To Cart',
                            color: cubit.isAddedToCart(cubit.products[index])
                                ? Colors.deepOrange
                                : Colors.grey,
                            icon: Icons.shopping_cart,
                            onTap: () {
                              cubit.addToCart(product: cubit.products[index]);
                            },
                          ),
                          height: 100,
                        ),
                      ),
                    ],
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: 150,
                          child: Row(
                            children: [
                              Container(
                                width: 130,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(cubit.products[index].image!)),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(cubit.products[index].name!, style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24
                                  ),),
                                  Text(cubit.products[index].description!,style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),),
                                  Row(
                                    children: [
                                      Text(
                                        '${cubit.products[index].price}',
                                        style: TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        '${cubit.products[index].salePrice}',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(width: 20),

                                    ],
                                  ),
                                  Text('Stock : ${cubit.products[index].stock}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        IconButton(
                          onPressed: () {
                            navigateTo(context, FavoritesScreen());
                          },
                          icon: Icon(Icons.favorite),
                          color: Colors.white,
                          iconSize: 50,
                        ),
                        Text(
                          '${cubit.favorites.length}',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        IconButton(
                          onPressed: () {
                            navigateTo(context, CartScreen());
                          },
                          icon: Icon(Icons.add_shopping_cart_outlined),
                          color: Colors.white,
                          iconSize: 50,
                        ),
                        Text(
                          '${cubit.cartItems.length}',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
