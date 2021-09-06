import 'dart:io';

import 'package:fiction_challenge/logic/cubit.dart';
import 'package:fiction_challenge/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart Items',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.deepOrange,
          ),
          body: Container(
            height: 700,
            width: 500,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  Container(color: Colors.deepOrange, height: 1),
              itemCount: cubit.cartItems.length,
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
                                  File(cubit.cartItems[index].image!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(cubit.cartItems[index].name!),
                            Text(cubit.cartItems[index].description!),
                            Row(
                              children: [
                                Text('${cubit.cartItems[index].price}'),
                                SizedBox(width: 20),
                                Text(
                                    '${cubit.cartItems[index].salePrice}'),
                                SizedBox(width: 20),
                                Text('${cubit.cartItems[index].stock}'),
                              ],
                            )
                          ],
                        ),
                      ],
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
