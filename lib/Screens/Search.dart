import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/CounterCubit.dart';
import 'package:newsapp/Cubit/CounterState.dart';
import 'package:newsapp/Widget/Item.dart';

class Search extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {},
      builder: (context, state) {
        var data = CounterCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Search News",
              style: Theme.of(context).textTheme.body2,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  onChanged: (value) {
                    CounterCubit.get(context).getSearch(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                    labelText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              data.length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, right: 15, left: 15),
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Item(data[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          );
                        },
                        itemCount: data.length,
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
