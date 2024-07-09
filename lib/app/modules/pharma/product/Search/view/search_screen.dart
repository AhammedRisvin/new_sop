import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/catagory%20screen/view%20model/catagory_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../helpers/app_router.dart';
import '../../../../../helpers/extentions.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../home/home screen/view model/theme_provider.dart';
import '../../../home/home screen/widget/product_listing_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.catagoryId,
    required this.subCatagoryId,
    this.isFromHome = false,
  });

  final String catagoryId;
  final String subCatagoryId;
  final bool isFromHome;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CatagoryProvider? provider;
  TextEditingController searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    provider = context.read<CatagoryProvider>();
    provider?.searchList.clear();
    provider?.searchKeyword = "";
    searchController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) {
        return Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            surfaceTintColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            title: CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: "Search Product",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            leading: widget.isFromHome
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      provider?.stopListening();
                      provider?.resetVoiceSearchState();
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                    ),
                  ),
          ),
          body: Consumer<CatagoryProvider>(
            builder: (context, provider, child) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onChanged: (value) {
                      _debouncer.run(() {
                        // Step 2
                        provider.setSearchKeyword(value);
                        provider.getProductFn(
                          catagoryId: widget.catagoryId,
                          subCatagoryId: widget.subCatagoryId,
                          search: value,
                        );
                      });
                    },
                    style: TextStyle(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        color: AppConstants.black40,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppConstants.black10,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppConstants.black10,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppConstants.black10,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppConstants.black40,
                        size: 18,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AvatarGlow(
                          animate: provider.isListening,
                          glowColor:
                              provider.isListening ? Colors.grey : Colors.white,
                          child: IconButton(
                            icon: Icon(
                              provider.isListening ? Icons.mic : Icons.mic_none,
                              color: AppConstants.black40,
                              size: 18,
                            ),
                            onPressed: () {
                              if (provider.isListening) {
                                provider.stopListening();
                                provider.resetVoiceSearchState();
                              } else {
                                provider.startListening(
                                  widget.catagoryId,
                                  widget.subCatagoryId,
                                  searchController,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizeBoxH(20),
                  provider.searchList.isEmpty == true &&
                          provider.searchKeyword.isEmpty == true
                      ? EmptyScreenWidget(
                          text: "Search for product",
                          image: AppImages.reminderEmpty,
                          height: Responsive.height * 60,
                        )
                      : provider.searchList.isEmpty == true
                          ? EmptyScreenWidget(
                              text: "No search data found",
                              image: AppImages.reminderEmpty,
                              height: Responsive.height * 60,
                            )
                          : provider.getProductStatus ==
                                  GetProductStatus.loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                  ),
                                )
                              : provider.getProductStatus ==
                                      GetProductStatus.loaded
                                  ? Expanded(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio:
                                              Responsive.height * 0.08,
                                        ),
                                        itemCount: provider.searchList.length,
                                        itemBuilder: (context, index) {
                                          final searchProduct =
                                              provider.searchList[index];
                                          return CommonProductListingWidget(
                                            onTap: () {
                                              context.pushNamed(
                                                  AppRouter
                                                      .productDetailsScreen,
                                                  queryParameters: {
                                                    "productLink":
                                                        searchProduct.link ??
                                                            "",
                                                  });
                                            },
                                            isDarkModeOn: isDarkModeOn,
                                            data: searchProduct,
                                          );
                                        },
                                      ),
                                    )
                                  : EmptyScreenWidget(
                                      text: "Server busy, try again later",
                                      image: AppImages.serverMaintenanceImage,
                                      height: Responsive.height * 60,
                                      isFromServerError: true,
                                      ontap: () {
                                        context.pop();
                                      },
                                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    provider?.resetVoiceSearchState();
    super.dispose();
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
