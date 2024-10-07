import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_list_menu/models/category.dart';
import 'package:grocery_list_menu/widgets/api_services.dart';

import '../models/grocery_item.dart';
import '../providers/grocery_items_provider.dart';
import '../widgets/constants.dart';
import 'new_item.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key, required this.title});

  final String title;

  @override
  ConsumerState<GroceryList> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<GroceryList> {
  bool busy = false;
  final dio = Dio();
  late ApiCalls apiService;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  void addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const NewItem();
    }));
  }

  @override
  void initState() {
    super.initState();
    dio.options.connectTimeout = const Duration(seconds: 10);
    apiService = ApiCalls(
        context,
        ref,
        dio,
        GroceryItem(
          quantity: 2,
          name: "",
          id: "",
          category: Category("categoryName", Colors.transparent),
        ));
    apiService.loadItemListFromBackend(() {
      setState(() {
        busy = true;
      });
    }, () {
      setState(() {
        busy = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final groceryItemList = ref.watch(groceryItemsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () {
              addItem();
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: groceryItemList.isEmpty
            ? const Center(child: Text("No Items Yet"))
            : Column(
                children: List.generate(
                    groceryItemList.length, (index) => buildGroceryItemTile(groceryItemList[index], ref))),
      ),
    );
  }

  Widget buildGroceryItemTile(GroceryItem groceryItem, WidgetRef newRef) {
    final apiService = ApiCalls(context, newRef, dio, groceryItem);
    return StatefulBuilder(builder: (context, innerSetState) {
      return Dismissible(
        key: ValueKey(groceryItem.id),
        onDismissed: (direction) {
          apiService.deleteItem();
        },
        child: ListTile(
          leading: Container(
            height: 20,
            width: 20,
            color: groceryItem.category.categoryColor,
          ),
          title: Text(groceryItem.name),
          trailing: Text("${groceryItem.quantity}"),
        ),
      );
    });
  }
}
