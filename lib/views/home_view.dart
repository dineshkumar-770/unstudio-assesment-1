import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unstudio_assignment/providers/registered_providers.dart';
import 'package:unstudio_assignment/themes/app_colors.dart';
import 'package:unstudio_assignment/themes/text_styles.dart';
import 'package:unstudio_assignment/widgets/selected_garments_widegt.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer(
            builder: (context, ref, child) {
              final homeState = ref.watch(appStateNotifierProvider);
              final providerMethod = ref.read(appStateNotifierProvider.notifier);
              if (homeState.fetchAllGarmentsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (homeState.allGaremnetsErrorMsg.isNotEmpty) {
                return Center(
                  child: Text(
                    homeState.allGaremnetsErrorMsg,
                    style: CustomTextStyles.black18W400,
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Stack(
                  fit: StackFit.loose,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TOP",
                                    style: CustomTextStyles.black18Bold,
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                              const Divider(
                                color: AppColors.lightGrey,
                              )
                            ],
                          ),
                          Expanded(
                              child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1.25 / 1, mainAxisSpacing: 8, crossAxisSpacing: 8),
                            itemCount: homeState.allGarmentsDataModel.male?.top?.length ?? 0,
                            itemBuilder: (context, index) {
                              final topGarments = homeState.allGarmentsDataModel.male?.top?[index];
                              return InkWell(
                                onTap: () {
                                  providerMethod.selectTopGarment(topGarments!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: homeState.selectedTOP.id == topGarments?.id
                                              ? AppColors.black
                                              : AppColors.lightGrey,
                                          width: 2),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            topGarments?.displayUrl ?? "",
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              );
                            },
                          )),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BOTTOM",
                                    style: CustomTextStyles.black18Bold,
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                              const Divider(
                                color: AppColors.lightGrey,
                              )
                            ],
                          ),
                          Expanded(
                              child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1.25 / 1, mainAxisSpacing: 8, crossAxisSpacing: 8),
                            itemCount: homeState.allGarmentsDataModel.male?.bottom?.length ?? 0,
                            itemBuilder: (context, index) {
                              final bottomGarments = homeState.allGarmentsDataModel.male?.bottom?[index];
                              return InkWell(
                                onTap: () {
                                  providerMethod.selectBottomGarment(bottomGarments!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: homeState.selectedBOTTOM.id == bottomGarments?.id
                                              ? AppColors.black
                                              : AppColors.lightGrey,
                                          width: 2),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            bottomGarments?.displayUrl ?? "",
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                    if (homeState.selectedBOTTOM.id != null || homeState.selectedTOP.id != null) ...[
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SelectedGarmentsWidegt(
                            bottomGarment: homeState.selectedBOTTOM,
                            topGarments: homeState.selectedTOP,
                          ))
                    ]
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
