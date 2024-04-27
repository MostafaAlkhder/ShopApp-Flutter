import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/ShopCubit/shopCubit.dart';
import 'package:shopapp/bloc/ShopCubit/shopStates.dart';
import 'package:shopapp/coomon/models/categoriesModel.dart';
import 'package:shopapp/coomon/models/homeModel.dart';
import 'package:shopapp/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (BuildContext context, ShopStates state) {
        return AnimatedConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          fallback: (context) {
            return Center(child: CircularProgressIndicator());
          },
          builder: (BuildContext context) {
            return productBuilder(ShopCubit.get(context).homeModel, context,
                ShopCubit.get(context).categoriesModel);
          },
        );
      },
    );
  }

  Widget buildCategoryItem(DataModel data) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(data.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
              color: Colors.black.withOpacity(0.6),
              width: 100.0,
              child: Text(
                data.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ))
        ],
      );
  Widget productBuilder(
          HomeModel? model, context, CategoriesModel? categoriesModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data.banners
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e['image']}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            buildCategoryItem(categoriesModel.data.data[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10.0),
                        itemCount: categoriesModel!.data.data.length),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "New Procucts",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.63,
                children: List.generate(
                    model!.data.products.length,
                    (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      "${model.data.products[index]['image']}"),
                                  width: double.infinity,
                                  height: 200.0,
                                ),
                                if (model.data.products[index]['discount'] != 0)
                                  Container(
                                    color: Colors.red,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "DISCOUNT",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.data.products[index]['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14, height: 1.3),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${model.data.products[index]['price'].round()}",
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
                                      if (model.data.products[index]
                                              ['discount'] !=
                                          0)
                                        Text(
                                          "${model.data.products[index]['old_price'].round()}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              height: 1.3,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      Spacer(),
                                      CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor: ShopCubit.get(context)
                                                        .favorites[model.data
                                                            .products[index]
                                                        ["id"]] !=
                                                    null &&
                                                ShopCubit.get(context)
                                                        .favorites[model.data
                                                            .products[index]
                                                        ["id"]] ==
                                                    true
                                            ? Colors.red
                                            : Colors.grey,
                                        child: IconButton(
                                          onPressed: () {
                                            ShopCubit.get(context)
                                                .changeFavorites(model.data
                                                    .products[index]["id"]);
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
                        )),
              ),
            ),
          ],
        ),
      );
}
