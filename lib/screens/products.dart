import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Models
import 'package:jantari/models/product.dart';

// BLoCs
import 'package:jantari/bloc/product/bloc.dart';
import 'package:jantari/bloc/auth/bloc.dart';

// Utilities
import 'package:jantari/utils/size_config.dart';
import 'package:jantari/utils/styles.dart';

// Widgets
import 'package:jantari/widgets/c_layout.dart';
import 'package:jantari/widgets/c_card.dart';

class Products extends StatefulHookWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final List<String> _images = ["assets/DA.png", "assets/FDA.png", "assets/ADA.png"];
  ValueNotifier<List<Product>> filtered = ValueNotifier<List<Product>>([]);
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool searching = false;
  List filteredProducts = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final products = context.select(
      (ProductBloc bloc) => bloc.state.productStateModel.products,
    );

    final permissionDictionary = context.select(
      (AuthBloc bloc) => bloc.state.authStateModel.permissionDictionary,
    );

    useEffect(() {
      if (products?.isNotEmpty ?? false) {
        final productsIntersection = (products ?? [])
            .where((item1) =>
                permissionDictionary?['workflows']
                    ?.any((item2) => item2 == item1.code) ??
                false)
            .toList();
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          setState(() {
            filteredProducts = productsIntersection;
          });
        });
      }
    }, [products]);

    return CustomScreenLayout(
      content: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List>(
              valueListenable: filtered,
              builder: (context, value, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.resizeWidth(3.7),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              focusNode: searchFocus,
                              controller: searchController,
                              style: TextStyle(
                                fontSize: SizeConfig.resizeFont(
                                    CustomFonts.customParagraph),
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    searchFocus.unfocus();
                                    searchController.text = "";
                                    searching = false;
                                    filtered.value = [];
                                  },
                                ),
                                contentPadding: const EdgeInsets.all(0),
                              ),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  searching = true;
                                  filtered.value = [];
                                  filteredProducts.forEach((product) {
                                    if (product.name
                                            .toString()
                                            .toLowerCase()
                                            .contains(text.toLowerCase()) ||
                                        product.code
                                            .toString()
                                            .toLowerCase()
                                            .contains(text.toLowerCase())) {
                                      filtered.value.add(product);
                                    }
                                  });
                                } else {
                                  searching = false;
                                  filtered.value = [];
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: filteredProducts.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: SizeConfig.resizeWidth(4),
                                  );
                                },
                                itemCount: searching
                                    ? filtered.value.length
                                    : filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final item = searching
                                      ? filtered.value[index]
                                      : filteredProducts[index];
                                  return CustomCard(
                                    onTap: () => {
                                      Navigator.pushNamed(
                                        context,
                                        '/workflows',
                                        arguments: {
                                          "productCode": item.code,
                                        },
                                      )
                                    },
                                    leadingImage: _images[Random().nextInt(2)],
                                    title: item.name ?? "Not Available",
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
