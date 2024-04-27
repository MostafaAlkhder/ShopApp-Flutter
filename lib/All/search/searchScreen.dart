import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/All/search/searchCubit.dart';
import 'package:shopapp/All/search/searchStates.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/styles/colors.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  bool SearchDone = false;
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (BuildContext context) => ShopSearchCubit(),
          child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ShopSearchSuccessState) SearchDone = true;
              return Scaffold(
                body: Form(
                    key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        defaultFormField(
                            controller: searchController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'enter text to search';
                              }
                              return null;
                            },
                            onSubmit: (String text) {
                              print("Beforeeeeeeeeeeeeeeeeeeeeee");
                              ShopSearchCubit.get(context).search(text);
                              print("Afterrrrrrrrrrrrrrrrrrrrrrr");
                            },
                            label: 'Search',
                            prefix: Icons.search),
                        SizedBox(
                          height: 10,
                        ),
                        if (state is ShopSearchLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: AnimatedConditionalBuilder(
                                condition: SearchDone,
                                builder: (context) {
                                  return ListView.separated(
                                      itemBuilder: (context, index) =>
                                          buildSearchItem(
                                              ShopSearchCubit.get(context)
                                                  .model!
                                                  .data
                                                  .data[index]),
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount: ShopSearchCubit.get(context)
                                          .model!
                                          .data
                                          .data
                                          .length);
                                },
                                fallback: (context) => Center(
                                        child: Text(
                                      "Search Here",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    )))),
                      ]),
                    )),
              );
            },
          ),
        ));
  }

  Widget buildSearchItem(model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage("${model!.image}"),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
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
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.price}",
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
                        Spacer(),
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
