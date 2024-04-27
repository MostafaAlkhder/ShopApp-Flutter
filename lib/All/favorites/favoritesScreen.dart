import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/ShopCubit/shopCubit.dart';
import 'package:shopapp/bloc/ShopCubit/shopStates.dart';
import 'package:shopapp/coomon/models/favoritesModel.dart';
import 'package:shopapp/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AnimatedConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => AnimatedConditionalBuilder(
            condition:
                ShopCubit.get(context).favoritesModel!.data.data.length != 0,
            fallback: (BuildContext context) => Center(
                child: Text(
              "No Favorites",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            )),
            builder: (BuildContext context) => ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context).favoritesModel!.data.data[index],
                    context),
                separatorBuilder: (context, index) => Divider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data.length),
          ),
        );
      },
    );
  }

  Widget buildFavItem(FDataModel? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage("${model!.product.image}"),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.product.price.round()}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.w800,
                              color: defultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            "${model.product.oldPrice.round()}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.3,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context)
                                          .favorites[model.product.id] !=
                                      null &&
                                  ShopCubit.get(context)
                                          .favorites[model.product.id] ==
                                      true
                              ? Colors.red
                              : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(model.product.id);
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
