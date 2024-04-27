import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/ShopCubit/shopCubit.dart';
import 'package:shopapp/bloc/ShopCubit/shopStates.dart';
import 'package:shopapp/coomon/models/categoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) =>
          AnimatedConditionalBuilder(
        condition: ShopCubit.get(context).categoriesModel != null,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data.data.length),
      ),
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(model.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Spacer(),
            Icon(Icons.arrow_forward)
          ],
        ),
      );
}
