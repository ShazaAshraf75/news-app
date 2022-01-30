import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/layout/cubit/news_cubit.dart';
import 'package:news_app/layout/cubit/news_states.dart';




class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search Screen"),
          ),
          body: Column(children: [
            defaultTextField(
              context: context,
                controller: searchController,
                radius: 25,
                padding: 20,
                onChange: (value) {
                  NewsCubit.get(context).getSearch(value!);
                },
                prefixIcon: Icons.search,
                label: "Search",
                textInputType: TextInputType.text,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Search Field Must Not Be Empty";
                  }
                  return null;
                }),
            Expanded(child: articleBuilder(list, context, isSearch: true))
          ]),
        );
      },
    );
  }
}
