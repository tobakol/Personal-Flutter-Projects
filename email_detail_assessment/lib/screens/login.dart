import 'dart:convert';

import 'package:email_detail_assessment/models/meal.dart';
import 'package:email_detail_assessment/screens/category_meals_screen.dart';
import 'package:email_detail_assessment/utilities/default_scaffold.dart';
import 'package:email_detail_assessment/utilities/widgets_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meals_list_provider.dart';
import '../utilities/inputs_filelds/custom_text_fields.dart';
import '../utilities/inputs_filelds/password_form_field.dart';
import '../utilities/validation_util.dart';
import '../utilities/view_utilities.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool busy = false;
  List<Meal> availableMeals = [];

  final formKey = GlobalKey<FormState>();

  Future<void> loadCategories() async {
    setState(() {
      busy = true;
    });
    String jsonString = await rootBundle.loadString('assets/json/items.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      final dynCategories = List<Map<String, dynamic>>.from(jsonData["DUMMY_MEALS"]);

      for (Map<String, dynamic> dynItem in dynCategories) {
        final mealItemized = Meal.fromJson(dynItem);
        availableMeals.add(mealItemized);
      }
    });
    setState(() {
      busy = false;
    });
  }

  void _submit(WidgetRef newRef) async {
    setState(() {
      busy = true;
    });

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (isValid) {
      debugPrint(availableMeals.first.toString());

      Future.delayed(const Duration(seconds: 4), () async {
        setState(() {
          busy = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryMealsScreen()),
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mealsService = MealsProviderService(serviceRef: ref);
    final mealItemList = ref.watch(mealItemsProvider);
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    FocusNode emailNode = FocusNode();
    FocusNode passwordNode = FocusNode();

    return DefaultScaffold(
        busy: busy,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 27, width: 105).spaceSymmetrically(vertical: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Log In",
                  ).spaceTo(bottom: 20),
                ),
                CustomInputFields(
                  node: emailNode,
                  iconPresent: true,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "abc@email.com",
                  labelText: 'Enter email',
                  validate: (value) => ValidationUtil.validateEmail(value),
                ).spaceTo(bottom: 30),
                PasswordTextField(
                  node: passwordNode,
                  keyboardType: TextInputType.text,
                  hintText: "Your Password",
                  controller: passwordController,
                  validate: (value) => ValidationUtil.validatePassword(value),
                ),
                onboardingButton(
                  buttonText: "SIGN IN",
                  onPressed: () async {
                    final wasAdded = mealsService.editPlaceList(availableMeals);

                    _submit(ref);
                  },
                ).spaceTo(bottom: 20, top: 20),
              ],
            ).spaceSymmetrically(horizontal: 20, vertical: 24),
          ),
        ));
  }
}
