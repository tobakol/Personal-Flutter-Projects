import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forms_challenge/models/grocery_item.dart';
import 'package:forms_challenge/providers/grocery_items_provider.dart';
import 'package:forms_challenge/screens/new_item.dart';
import 'package:forms_challenge/widgets/constants.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key, required this.title});

  final String title;

  @override
  ConsumerState<GroceryList> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<GroceryList> {
  bool busy = false;
  final dio = Dio();
  void addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const NewItem();
    }));
  }

  void saveToBackend() async {
    try {
      setState(() {
        busy = true;
      });
      final response = await dio.get(
        ConstantsUtil.generalUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      final Map<String, dynamic>? groceryMapListData = response.data;
      if (response.data == null) {
        setState(() {
          busy = false;
        });
        return;
      } else if (response.statusCode == 200) {
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
          setState(() {
            busy = false;
          });
        }
      } else {
        showSnackbar(context, response.statusMessage);
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
      setState(() {
        busy = false;
      });
    }
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
    dio.options.connectTimeout = Duration(seconds: 10);
    saveToBackend();
  }

  @override
  Widget build(BuildContext context) {
    // final orgList = ref.read(groceryItemsProvider);
    // debugPrint(orgList[3].id ?? "Cant yet get it");
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
        child: Stack(
          children: [
            groceryItemList.isEmpty
                ? Center(child: Text("No Items Yet"))
                : Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(groceryItemList.length, (index) => buildGroceryItemTile(groceryItemList[index]))),
            loader(context, busy)
          ],
        ),
      ),
    );
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
