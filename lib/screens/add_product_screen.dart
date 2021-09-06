import 'package:fiction_challenge/components.dart';
import 'package:fiction_challenge/logic/cubit.dart';
import 'package:fiction_challenge/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final saleController = TextEditingController();
  final stockController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ///image - product name - product description - price - sale price if existed - stock

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text('Add Product'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: fictionFormField(
                      controller: nameController,
                      label: 'Name',
                      icon: Icons.image,
                      textInputType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: fictionFormField(
                      controller: descController,
                      label: 'Description',
                      icon: Icons.details,
                      textInputType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: fictionFormField(
                      controller: priceController,
                      label: 'Price',
                      icon: Icons.price_change,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: fictionFormField(
                      controller: saleController,
                      label: 'Price after sale',
                      icon: Icons.price_change_sharp,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: fictionFormField(
                      controller: stockController,
                      label: 'Stock',
                      icon: Icons.home,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.addProductImage();
                    },
                    child: Text(
                      'Add Product Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.createProduct(
                        name: nameController.text,
                        description: descController.text,
                        price: double.parse(priceController.text),
                        salePrice: double.parse(saleController.text),
                        stock: int.parse(stockController.text),
                      );
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
