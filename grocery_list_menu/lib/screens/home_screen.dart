import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  late Future<List<GroceryItem>> loadedListItems;

  void addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const NewItem();
    }));
  }

  Future<List<GroceryItem>> loadListFromBackend() async {
    List<GroceryItem> overAllListItem = [];
    setState(() {
      busy = true;
    });
    final response = await dio.get(
      ConstantsUtil.generalUrl,
      options: Options(headers: jsonHeader),
    );
    final Map<String, dynamic>? groceryMapListData = response.data;
    if (response.data == null) {
      setState(() {
        busy = false;
      });
      return [];
    }
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }

    debugPrint(response.data.toString());
    final List<GroceryItem> listItems = [];
    for (final item in groceryMapListData!.entries) {
      final itemIzedMap = <String, Map<String, dynamic>>{item.key: item.value};
      final itemizedListItem = GroceryItem.fromJson(itemIzedMap);
      listItems.add(itemizedListItem);
      Future.microtask(() {
        final wasAdded = ref.read(groceryItemsProvider.notifier).editGroceryItemToList(itemizedListItem);
        // Set initial value
      });
      //return listItems;
      overAllListItem = listItems;
    }
    return overAllListItem;
  }

  void _deleteItem(GroceryItem item) async {
    try {
      final wasAdded = ref.read(groceryItemsProvider.notifier).editGroceryItemToList(item);
      final response = await dio.delete(ConstantsUtil.deleteUrl(item.id!));
      if (response.statusCode != 200) {
        final wasAdded = ref.read(groceryItemsProvider.notifier).editGroceryItemToList(item);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        if (context.mounted) {
          showSnackbar(context, "Request took too long");
        }
      } else {
        if (context.mounted) {
          showSnackbar(context, 'Error: ${e.response?.data ?? e.message}');
        }
      }
      final wasAdded = ref.read(groceryItemsProvider.notifier).editGroceryItemToList(item);
    }
  }

  @override
  void initState() {
    super.initState();
    dio.options.connectTimeout = const Duration(seconds: 10);
    loadedListItems = loadListFromBackend();
  }

  @override
  Widget build(BuildContext context) {
    // final orgList = ref.read(groceryItemsProvider);
    // debugPrint(orgList[3].id ?? "Cant yet get it");
    final groceryItemList = ref.watch(groceryItemsProvider);
    Widget _body = SingleChildScrollView(
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(groceryItemList.length, (index) => buildGroceryItemTile(groceryItemList[index]))),
    );
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
        body: FutureBuilder(
            future: loadedListItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loader(context, busy);
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No Items Yet"));
              }
              return _body;
            }));
  }

  Widget buildGroceryItemTile(GroceryItem groceryItem) {
    return StatefulBuilder(builder: (context, innerSetState) {
      return Dismissible(
        key: ValueKey(groceryItem.id),
        onDismissed: (direction) {
          _deleteItem(groceryItem);
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
