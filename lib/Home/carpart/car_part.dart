// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/Home/carpart/car_parts2.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

// import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';

class AddCarPart extends StatefulHookConsumerWidget {
  const AddCarPart({super.key});

  @override
  ConsumerState<AddCarPart> createState() => _AddCarPartState();
}

class _AddCarPartState extends ConsumerState<AddCarPart>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  late TabController _tabController;

  String? popular;
  // bool isClicked = false;
  // String selectedImage = '';

  // late List<Category> categories = [];
  late List<Category> categories1 = [];
  late List<Category> categories2 = [];
  late List<Category> categories3 = [];
  late List<Category> categories4 = [];
  late List<bool> itemVisibility = [];
  late List<bool> itemVisibility2 = [];
  late List<bool> itemVisibility3 = [];
  late List<bool> itemVisibility4 = [];
  late String searchQuery;
  String selectedCarPart = '';
  String selectedCategory = '';
  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();
    searchQuery = '';
    loadCategories();
    loadCat2();
    loadCat3();
    loadCat4();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> loadCategories() async {
    String data1 =
        await rootBundle.loadString('assets/images/carpart_cat.json');
    List<dynamic> categoriesData = json.decode(data1);

    categories1 = categoriesData.map<Category>((categoryData) {
      List<dynamic> subCategoriesData = categoryData['category'];
      List<SubCategory> subCategories =
          subCategoriesData.map<SubCategory>((subCategoryData) {
        return SubCategory(
          name: subCategoryData,
        );
      }).toList();
      return Category(
        name: categoryData['name'],
        image: categoryData['image'],
        subCategories: subCategories,
      );
    }).toList();

    setState(() {
      itemVisibility = List.generate(categories1.length, (index) => false);
    });
  }

  Future<void> loadCat2() async {
    String data2 =
        await rootBundle.loadString('assets/images/carpart_cat.json');
    List<dynamic> categoriesData = json.decode(data2);

    // Filter categories whose names start with alphabets A-J
    List<Category> filteredCategories2 = categoriesData
        .where((categoryData) => categoryData['name']
            .toString()
            .toUpperCase()
            .startsWith(RegExp(r'[A-J]')))
        .map<Category>((categoryData) {
      List<dynamic> subCategoriesData = categoryData['category'];
      List<SubCategory> subCategories =
          subCategoriesData.map<SubCategory>((subCategoryData) {
        return SubCategory(
          name: subCategoryData,
        );
      }).toList();
      return Category(
        name: categoryData['name'],
        image: categoryData['image'],
        subCategories: subCategories,
      );
    }).toList();

    // Sort filtered categories by name
    filteredCategories2.sort((a, b) => a.name.compareTo(b.name));

    // Update state with filtered categories
    setState(() {
      categories2 = filteredCategories2;
      itemVisibility2 = List.generate(categories2.length, (index) => false);
    });
  }

  Future<void> loadCat3() async {
    String data3 =
        await rootBundle.loadString('assets/images/carpart_cat.json');
    List<dynamic> categoriesData = json.decode(data3);

    // Filter categories whose names start with alphabets A-J
    List<Category> filteredCategories3 = categoriesData
        .where((categoryData) => categoryData['name']
            .toString()
            .toUpperCase()
            .startsWith(RegExp(r'[K-U]')))
        .map<Category>((categoryData) {
      List<dynamic> subCategoriesData = categoryData['category'];
      List<SubCategory> subCategories =
          subCategoriesData.map<SubCategory>((subCategoryData) {
        return SubCategory(
          name: subCategoryData,
        );
      }).toList();
      return Category(
        name: categoryData['name'],
        image: categoryData['image'],
        subCategories: subCategories,
      );
    }).toList();

    // Sort filtered categories by name
    filteredCategories3.sort((a, b) => a.name.compareTo(b.name));

    // Update state with filtered categories
    setState(() {
      categories3 = filteredCategories3;
      itemVisibility3 = List.generate(categories3.length, (index) => false);
    });
  }

  //v-z
  Future<void> loadCat4() async {
    String data4 =
        await rootBundle.loadString('assets/images/carpart_cat.json');
    List<dynamic> categoriesData = json.decode(data4);

    // Filter categories whose names start with alphabets A-J
    List<Category> filteredCategories4 = categoriesData
        .where((categoryData) => categoryData['name']
            .toString()
            .toUpperCase()
            .startsWith(RegExp(r'[V-Z]')))
        .map<Category>((categoryData) {
      List<dynamic> subCategoriesData = categoryData['category'];
      List<SubCategory> subCategories =
          subCategoriesData.map<SubCategory>((subCategoryData) {
        return SubCategory(
          name: subCategoryData,
        );
      }).toList();
      return Category(
        name: categoryData['name'],
        image: categoryData['image'],
        subCategories: subCategories,
      );
    }).toList();

    // Sort filtered categories by name
    filteredCategories4.sort((a, b) => a.name.compareTo(b.name));

    // Update state with filtered categories
    setState(() {
      categories4 = filteredCategories4;
      itemVisibility4 = List.generate(categories4.length, (index) => false);
    });
  }

  List<SubCategory> filteredSubCategories = [];
  List<SubCategory> filteredSubCategories4 = [];

  void updateFilteredSubCategories(String query) {
    filteredSubCategories.clear();
    if (query.isNotEmpty) {
      for (var category in categories1) {
        filteredSubCategories.addAll(category.subCategories.where(
            (subCategory) =>
                subCategory.name.toLowerCase().contains(query.toLowerCase())));
      }
    }
  }

  void updateFilteredSubCategories4(String query) {
    filteredSubCategories4.clear();
    if (query.isNotEmpty) {
      for (var category in categories4) {
        filteredSubCategories4.addAll(category.subCategories.where(
            (subCategory) =>
                subCategory.name.toLowerCase().contains(query.toLowerCase())));
      }
    }
  }

  SubCategory? selectedSubCategory;
  void toggleSelection(SubCategory subCategory) {
    if (selectedSubCategory == subCategory) {
      // If the tapped subcategory is already selected, deselect it
      selectedSubCategory = null;
    } else {
      // Otherwise, select the tapped subcategory
      selectedSubCategory = subCategory;
    }

    // Trigger a rebuild of the UI
    setState(() {});
  }

  // SubCategory? selectedSubCategory2;
  // void toggleSelection2(SubCategory subCategory) {
  //   if (selectedSubCategory2 == subCategory) {
  //     // If the tapped subcategory is already selected, deselect it
  //     selectedSubCategory2 = null;
  //   } else {
  //     // Otherwise, select the tapped subcategory
  //     selectedSubCategory2 = subCategory;
  //   }
  //   // Trigger a rebuild of the UI
  //   setState(() {});
  // }

  // SubCategory? selectedSubCategory3;
  // void toggleSelection3(SubCategory subCategory) {
  //   if (selectedSubCategory3 == subCategory) {
  //     // If the tapped subcategory is already selected, deselect it
  //     selectedSubCategory3 = null;
  //   } else {
  //     // Otherwise, select the tapped subcategory
  //     selectedSubCategory3 = subCategory;
  //   }
  //   // Trigger a rebuild of the UI
  //   setState(() {});
  // }

  // SubCategory? selectedSubCategory4;
  // void toggleSelection4(SubCategory subCategory) {
  //   if (selectedSubCategory4 == subCategory) {
  //     // If the tapped subcategory is already selected, deselect it
  //     selectedSubCategory4 = null;
  //   } else {
  //     // Otherwise, select the tapped subcategory
  //     selectedSubCategory4 = subCategory;
  //   }
  //   // Trigger a rebuild of the UI
  //   setState(() {});
  // }

  @override
  void dispose() {
    carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categories1.sort((a, b) => a.name.compareTo(b.name));

    // Filter categories based on search query
    List<Category> filteredCategories = categories1.where((category) {
      return category.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    //carparts2
    categories2.sort((a, b) => a.name.compareTo(b.name));

    // Filter categories based on search query
    List<Category> filteredCategories2 = categories2.where((category) {
      return category.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

//carParts 3
    categories3.sort((a, b) => a.name.compareTo(b.name));

    // Filter categories based on search query
    List<Category> filteredCategories3 = categories3.where((category) {
      return category.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

//carpart4
    categories4.sort((a, b) => a.name.compareTo(b.name));

    // Filter categories based on search query
    List<Category> filteredCategories4 = categories4.where((category) {
      return category.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    // final state = ref.watch(profileProvider);
    // final model = ref.read(profileProvider.notifier);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xffEEF5F5),
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Car part",
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Select the part of the car you want to add",
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: AppColors.indieC,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.appThemeColor,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              PageIndicator(
                                  currentPage: 1,
                                  indicatorColor: AppColors.indieC,
                                  inactiveIndicatorColor: Color(0xffD7E2E4),
                                  totalPages: 4),
                            ],
                          ),
                          const Center(
                            child: Text(
                              "Select from the category below",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.appThemeColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: carController,
                              keyboardType: TextInputType.text,
                              onTapOutside: (event) {
                                // FocusScope.of(context)
                                //     .unfocus(); // Close the keyboard
                              },
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                  // updateFilteredSubCategories(searchQuery);
                                });
                              },
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Search',

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xffC1C3C3), width: 0.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.appThemeColor)),
                                filled: true,
                                fillColor: Colors.white,
                                // hintText: 'Enter your password',
                                suffixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Color(0xffC1C3C3),
                                ),
                                hintStyle: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffC1C3C3),
                                    letterSpacing: 1.2,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),

                      //tabs for all A-J K-P others

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 43,
                          // padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                              // border: Border.all(
                              //     color: const Color(0xffEEEFF0), width: 1),
                              color: Colors.transparent),
                          child: TabBar(
                            controller: _tabController,
                            // controller: DefaultTabController.of(context),

                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: const Color(0xff425658),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: AppColors.white,
                            labelStyle: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w600,
                                fontSize: 10),
                            unselectedLabelColor: AppColors.appThemeColor,
                            tabs: const [
                              Tab(text: 'All'),
                              Tab(text: 'A-J'),
                              Tab(text: 'K-U'),
                              Tab(text: 'V-Z'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.51,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // All Cars
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredCategories.length,
                                itemBuilder: (context, index) {
                                  final category = filteredCategories[index];
                                  final categoryName = category.name;
                                  final catImage = category.image;
                                  final List<SubCategory> subCategories =
                                      category.subCategories;

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(catImage),
                                            Text(
                                              categoryName,
                                              style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff202A2A),
                                                letterSpacing: 1.5,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Expanded(
                                              child: Divider(
                                                thickness: 1.5,
                                                color: Colors
                                                    .grey, // Change color to your preference
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemVisibility[index] =
                                                      !itemVisibility[index];
                                                });
                                              },
                                              child: itemVisibility[index]
                                                  ? const Icon(
                                                      Icons
                                                          .keyboard_arrow_up_rounded,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_sharp,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: itemVisibility[index],
                                        child: Column(
                                          children: subCategories
                                              .map<Widget>((subCategory) =>

                                                  // ListTile(
                                                  //       title: Text(subCategory.name),
                                                  //     ))
                                                  GestureDetector(
                                                    onTap: () {
                                                      toggleSelection(
                                                          subCategory);

                                                      setState(() {
                                                        selectedCarPart =
                                                            subCategory.name;
                                                        selectedCategory =
                                                            categoryName;

                                                        selectedImagePath =
                                                            catImage;
                                                      });

                                                      print(subCategory.name);
                                                    },
                                                    child: Container(
                                                      height: 57,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3,
                                                          horizontal: 15),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              // popular == subCategory.name
                                                              selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : const Color(
                                                                      0xfff0f5f5),
                                                          width: 2,
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black45,
                                                            blurRadius: 0.1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            subCategory.name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .green,
                                                            ),
                                                          ),
                                                          // const SizedBox(
                                                          //     width:
                                                          //         10), // Adjust spacing between name and circle
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                            child: Center(
                                                              child: selectedSubCategory ==
                                                                      subCategory
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .lightGreen,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.lightGreen,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      child: const Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ), // Show check mark only if selected
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            //A-J
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredCategories2.length,
                                itemBuilder: (context, index) {
                                  final category = filteredCategories2[index];
                                  final categoryName = category.name;
                                  final catImage = category.image;

                                  final List<SubCategory> subCategories =
                                      category.subCategories;

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(catImage),
                                            Text(
                                              categoryName,
                                              style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff202A2A),
                                                letterSpacing: 1.5,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Expanded(
                                              child: Divider(
                                                thickness: 1.5,
                                                color: Colors
                                                    .grey, // Change color to your preference
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemVisibility2[index] =
                                                      !itemVisibility2[index];
                                                });
                                              },
                                              child: itemVisibility2[index]
                                                  ? const Icon(
                                                      Icons
                                                          .keyboard_arrow_up_rounded,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_sharp,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: itemVisibility2[index],
                                        child: Column(
                                          children: subCategories
                                              .map<Widget>((subCategory) =>

                                                  // ListTile(
                                                  //       title: Text(subCategory.name),
                                                  //     ))
                                                  GestureDetector(
                                                    onTap: () {
                                                      toggleSelection(
                                                          subCategory);

                                                      setState(() {
                                                        selectedCarPart =
                                                            subCategory.name;
                                                        selectedCategory =
                                                            categoryName;
                                                            selectedImagePath =
                                                            catImage;
                                                      });

                                                      print(subCategory.name);
                                                    },
                                                    child: Container(
                                                      height: 57,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3,
                                                          horizontal: 15),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              // popular == subCategory.name
                                                              selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : const Color(
                                                                      0xfff0f5f5),
                                                          width: 2,
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black45,
                                                            blurRadius: 0.1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            subCategory.name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .green,
                                                            ),
                                                          ),
                                                          // const SizedBox(
                                                          //     width:
                                                          //         10), // Adjust spacing between name and circle
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                            child: Center(
                                                              child: selectedSubCategory ==
                                                                      subCategory
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .lightGreen,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.lightGreen,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      child: const Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ), // Show check mark only if selected
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            //carparts3
                            //k-u
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredCategories3.length,
                                itemBuilder: (context, index) {
                                  final category = filteredCategories3[index];
                                  final categoryName = category.name;
                                  final catImage = category.image;
                                  final List<SubCategory> subCategories =
                                      category.subCategories;

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(catImage),
                                            Text(
                                              categoryName,
                                              style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff202A2A),
                                                letterSpacing: 1.5,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Expanded(
                                              child: Divider(
                                                thickness: 1.5,
                                                color: Colors
                                                    .grey, // Change color to your preference
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemVisibility3[index] =
                                                      !itemVisibility3[index];
                                                });
                                              },
                                              child: itemVisibility3[index]
                                                  ? const Icon(
                                                      Icons
                                                          .keyboard_arrow_up_rounded,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_sharp,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: itemVisibility3[index],
                                        child: Column(
                                          children: subCategories
                                              .map<Widget>((subCategory) =>

                                                  // ListTile(
                                                  //       title: Text(subCategory.name),
                                                  //     ))
                                                  GestureDetector(
                                                    onTap: () {
                                                      toggleSelection(
                                                          subCategory);

                                                      setState(() {
                                                        selectedCarPart =
                                                            subCategory.name;

                                                        selectedCategory =
                                                            categoryName;

                                                            selectedImagePath =
                                                            catImage;
                                                      });

                                                      print(subCategory.name);
                                                    },
                                                    child: Container(
                                                      height: 57,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3,
                                                          horizontal: 15),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              // popular == subCategory.name
                                                              selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : const Color(
                                                                      0xfff0f5f5),
                                                          width: 2,
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black45,
                                                            blurRadius: 0.1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            subCategory.name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .green,
                                                            ),
                                                          ),
                                                          // const SizedBox(
                                                          //     width:
                                                          //         10), // Adjust spacing between name and circle
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                            child: Center(
                                                              child: selectedSubCategory ==
                                                                      subCategory
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .lightGreen,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.lightGreen,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      child: const Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ), // Show check mark only if selected
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            //v-z
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                itemCount: filteredCategories4.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final category = filteredCategories4[index];
                                  final categoryName = category.name;
                                  final catImage = category.image;
                                  final List<SubCategory> subCategories =
                                      category.subCategories;

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(catImage),
                                            Text(
                                              categoryName,
                                              style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff202A2A),
                                                letterSpacing: 1.5,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Expanded(
                                              child: Divider(
                                                thickness: 1.5,
                                                color: Colors
                                                    .grey, // Change color to your preference
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemVisibility4[index] =
                                                      !itemVisibility4[index];
                                                });
                                              },
                                              child: itemVisibility4[index]
                                                  ? const Icon(
                                                      Icons
                                                          .keyboard_arrow_up_rounded,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_sharp,
                                                      color: Colors
                                                          .grey, // Change color to your preference
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: itemVisibility4[index],
                                        child: Column(
                                          children: subCategories
                                              .map<Widget>((subCategory) =>

                                                  // ListTile(
                                                  //       title: Text(subCategory.name),
                                                  //     ))
                                                  GestureDetector(
                                                    onTap: () {
                                                      toggleSelection(
                                                          subCategory);

                                                      setState(() {
                                                        selectedCarPart =
                                                            subCategory.name;

                                                        selectedCategory =
                                                            categoryName;

                                                            selectedImagePath =
                                                            catImage;
                                                      });

                                                      print(subCategory.name);
                                                    },
                                                    child: Container(
                                                      height: 57,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.85,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3,
                                                          horizontal: 15),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              // popular == subCategory.name
                                                              selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : const Color(
                                                                      0xfff0f5f5),
                                                          width: 2,
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black45,
                                                            blurRadius: 0.1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            subCategory.name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .green,
                                                            ),
                                                          ),
                                                          // const SizedBox(
                                                          //     width:
                                                          //         10), // Adjust spacing between name and circle
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: selectedSubCategory ==
                                                                      subCategory
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                            child: Center(
                                                              child: selectedSubCategory ==
                                                                      subCategory
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .lightGreen,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.lightGreen,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      child: const Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ), // Show check mark only if selected
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //bottom
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MoticarLoginButton(
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () async {
                      if (selectedCarPart.isNotEmpty) {
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: true,
                        //   builder: (context) {
                        //     return Center(
                        //       child: AlertDialog(
                        //         backgroundColor:
                        //             AppColors.appThemeColor,
                        //         shadowColor: AppColors.appThemeColor,
                        //         content: Container(
                        //           padding: const EdgeInsets.all(20),
                        //           decoration: BoxDecoration(
                        //             borderRadius:
                        //                 BorderRadius.circular(10),
                        //           ),
                        //           child: const Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               // const SpinKitWave(
                        //               //   color: AppColors.appThemeColor,
                        //               //   size: 30.0,
                        //               // ),

                        //               SizedBox(
                        //                 height: 100,
                        //                 width: 100,
                        //                 child: RiveAnimation.asset(
                        //                   'assets/images/preloader.riv',
                        //                 ),
                        //               ),

                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );

                        // await Future.delayed(
                        //     const Duration(milliseconds: 100));

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AddCarPart2(
                                imagePath: selectedImagePath,
                                partCategory: selectedCategory,
                                carParts: selectedCarPart);
                          },
                        ));

                        //
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MoticarDialog(
                              icon: const Icon(Icons.info_rounded,
                                  color: AppColors.appThemeColor, size: 50),
                              title: '',
                              subtitle:
                                  'Please select your car brand, before proceeding',
                              onTap: () {
                                Navigator.pop(context);
                              },
                              buttonColor: AppColors.appThemeColor,
                              textColor: AppColors.white,
                              buttonText: "Dismiss",
                            );
                          },
                        );
                      }
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubCategory {
  final String name;

  SubCategory({required this.name});
}

class Category {
  final String name;
  final String image;
  final List<SubCategory> subCategories;

  Category(
      {required this.name, required this.image, required this.subCategories});
}
