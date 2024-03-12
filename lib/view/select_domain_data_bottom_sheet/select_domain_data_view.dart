import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/selector/search_exact_match_domain_data_selector.dart';
import 'package:tcg_manager/selector/select_domain_view_info_selector.dart';
import 'package:tcg_manager/view/component/loading_overlay.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/all_list_section_bar.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/domain_data_list.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/search_app_bar.dart';

// TODO 検索バーから新規登録できなくする
class SelectDomainDataView extends HookConsumerWidget {
  const SelectDomainDataView({
    required this.selectDomainDataFunc,
    required this.tagCount,
    required this.dataType,
    this.deselectionFunc,
    this.afterFunc,
    this.enableVisiblity = false,
    this.returnSelecting = true,
    this.isShowMenu = true,
    this.isShowGuestData = true,
    key,
  }) : super(key: key);

  final Function(DomainData, int) selectDomainDataFunc;
  final Function(DomainData)? deselectionFunc;
  final DomainDataType dataType;
  final Function? afterFunc;
  final bool enableVisiblity;
  final int tagCount;
  final bool returnSelecting;
  final bool isShowMenu;
  final bool isShowGuestData;

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext rootContext, WidgetRef ref) {
    return Material(
      child: SafeArea(
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: SearchAppBar(dataType: dataType),
              body: Stack(
                children: [
                  _Body(
                    selectDomainDataFunc: selectDomainDataFunc,
                    tagCount: tagCount,
                    dataType: dataType,
                    afterFunc: afterFunc,
                    enableVisiblity: enableVisiblity,
                    returnSelecting: returnSelecting,
                    deselectionFunc: deselectionFunc,
                    rootContext: rootContext,
                    isShowMenu: isShowMenu,
                    isShowGuestData: isShowGuestData,
                  ),
                  const LoadingOverlay(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    required this.selectDomainDataFunc,
    required this.tagCount,
    required this.dataType,
    required this.rootContext,
    this.deselectionFunc,
    this.afterFunc,
    this.enableVisiblity = false,
    this.returnSelecting = true,
    this.isShowMenu = true,
    this.isShowGuestData = true,
    key,
  }) : super(key: key);

  final DomainDataType dataType;
  final Function(DomainData, int) selectDomainDataFunc;
  final Function(DomainData)? deselectionFunc;
  final Function? afterFunc;
  final bool enableVisiblity;
  final int tagCount;
  final bool returnSelecting;
  final BuildContext rootContext;
  final bool isShowMenu;
  final bool isShowGuestData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectDomainViewInfo = ref.watch(selectDomainViewInfoProvider(dataType));
    final selectDomainDataViewNotifier = ref.watch(selectDomainDataViewNotifierProvider(dataType).notifier);
    final searchText = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.searchText));
    final isNewAdd = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.isNewAdd));
    final searchExactMatchDomainData = ref.watch(searchExactMatchDomainDataProvider(dataType));
    final selectedDomainDataList = ref.watch(recordListViewNotifierProvider.select((value) => value.tagList));
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: selectDomainViewInfo.when(
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: true,
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (selectDomainViewInfo) {
          // dataTypeがGameで、新規追加ボタンを押したら
          if (dataType == DomainDataType.game && isNewAdd) {
            return DomainDataList(
              domainDataList: selectDomainViewInfo.publicGameDomainDataList,
              selectedDomainDataList: const [],
              rootContext: rootContext,
              selectDomainDataFunc: (domainData, _) async {
                final result = await showTextInputDialog(
                  context: context,
                  title: 'ゲーム名を入力',
                  textFields: [
                    DialogTextField(initialText: domainData.name),
                  ],
                );
                if (result != null) {
                  // TODO 登録済みのものだった場合の処理追加
                  await selectDomainDataViewNotifier.saveDomainData(result.first, domainData.id);
                }
              },
              enableVisibility: false,
              afterFunc: () => ref.read(selectDomainDataViewNotifierProvider(dataType).notifier).toggleIsNewAdd(),
              tagCount: tagCount,
              returnSelecting: false,
              isShowMenu: false,
            );
          }

          // 検索結果がなかった場合
          if (selectDomainViewInfo.searchDomainDataList.isEmpty && searchText != '') {
            return GestureDetector(
              onTap: () {
                selectDomainDataViewNotifier.saveDomainData(searchText);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: Theme.of(context).colorScheme.surface,
                child: Text(
                  '「$searchText」を登録する',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
            // 完全一致の検索結果があった場合
          } else if (selectDomainViewInfo.searchDomainDataList.isNotEmpty &&
              searchExactMatchDomainData.asData?.value != null &&
              searchText != '') {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '検索結果',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                DomainDataList(
                  domainDataList: selectDomainViewInfo.searchDomainDataList,
                  selectedDomainDataList: selectedDomainDataList,
                  rootContext: rootContext,
                  selectDomainDataFunc: selectDomainDataFunc,
                  enableVisibility: false,
                  afterFunc: afterFunc,
                  deselectionFunc: deselectionFunc,
                  tagCount: tagCount,
                  returnSelecting: returnSelecting,
                  isShowMenu: isShowMenu,
                ),
              ],
            );
            // 完全一致はないが検索結果がある場合
          } else if (selectDomainViewInfo.searchDomainDataList.isNotEmpty &&
              searchExactMatchDomainData.asData?.value == null &&
              searchText != '') {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    selectDomainDataViewNotifier.saveDomainData(searchText);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.surface,
                    child: Text(
                      '「$searchText」を登録する',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '検索結果',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                DomainDataList(
                  domainDataList: selectDomainViewInfo.searchDomainDataList,
                  selectedDomainDataList: selectedDomainDataList,
                  rootContext: rootContext,
                  selectDomainDataFunc: selectDomainDataFunc,
                  deselectionFunc: deselectionFunc,
                  enableVisibility: false,
                  afterFunc: afterFunc,
                  tagCount: tagCount,
                  returnSelecting: returnSelecting,
                  isShowMenu: isShowMenu,
                ),
              ],
            );
            // 検索していない場合の表示
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (dataType != DomainDataType.game)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '最近記録した${dataType.displayName}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                if (dataType == DomainDataType.game && isShowGuestData)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '共有されている${dataType.displayName}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                if (dataType == DomainDataType.game && isShowGuestData)
                  DomainDataList(
                    domainDataList: selectDomainViewInfo.guestGameList,
                    selectedDomainDataList: selectedDomainDataList,
                    rootContext: rootContext,
                    selectDomainDataFunc: selectDomainDataFunc,
                    enableVisibility: false,
                    tagCount: tagCount,
                    returnSelecting: returnSelecting,
                    isShowMenu: isShowMenu,
                  ),
                if (dataType != DomainDataType.game)
                  DomainDataList(
                    domainDataList: selectDomainViewInfo.recentlyUseDomainDataList,
                    selectedDomainDataList: selectedDomainDataList,
                    rootContext: rootContext,
                    selectDomainDataFunc: selectDomainDataFunc,
                    deselectionFunc: deselectionFunc,
                    enableVisibility: false,
                    afterFunc: afterFunc,
                    tagCount: tagCount,
                    returnSelecting: returnSelecting,
                    isShowMenu: isShowMenu,
                  ),
                AllListSectionBar(
                  enableVisiblity: enableVisiblity,
                  dataType: dataType,
                ),
                DomainDataList(
                  domainDataList: selectDomainViewInfo.gameDomainDataList,
                  selectedDomainDataList: selectedDomainDataList,
                  rootContext: rootContext,
                  selectDomainDataFunc: selectDomainDataFunc,
                  deselectionFunc: deselectionFunc,
                  enableVisibility: enableVisiblity,
                  afterFunc: afterFunc,
                  tagCount: tagCount,
                  returnSelecting: returnSelecting,
                  isShareHost: true,
                  isShowMenu: isShowMenu,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
