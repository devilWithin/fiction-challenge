import 'dart:io';

import 'package:fiction_challenge/logic/cubit.dart';
import 'package:fiction_challenge/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Favorites'),
            backgroundColor: Colors.deepOrange,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 700,
              width: 500,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Container(color: Colors.deepOrange, height: 1),
                itemCount: cubit.favorites.length,
                itemBuilder: (context, index) => Container(
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
                                      File(cubit.favorites[index].image!)),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(cubit.favorites[index].name!, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                              ),),
                              Text(cubit.favorites[index].description!,style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),),
                              Row(
                                children: [
                                  Text(
                                    '${cubit.favorites[index].price}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      decoration:
                                      TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    '${cubit.favorites[index].salePrice}',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  SizedBox(width: 20),

                                ],
                              ),
                              Text('Stock : ${cubit.favorites[index].stock}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
