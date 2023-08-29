import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';

class SearchAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({
    required this.dataType,
    key,
  }) : super(key: key);

  final DomainDataType dataType;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectDomainDataViewNotifier = ref.watch(selectDomainDataViewNotifierProvider(dataType).notifier);
    final searchTextController = useTextEditingController(text: '');
    final searchFocusNode = useFocusNode();
    final isSearchFocus = useState(false);
    final isSearchText = useState(false);
    final isSearch = useState(false);

    searchFocusNode.addListener(() {
      isSearchFocus.value = searchFocusNode.hasFocus;
      isSearch.value = isSearchFocus.value || isSearchText.value;
    });

    searchTextController.addListener(() {
      selectDomainDataViewNotifier.setSearchText(searchTextController.text);
      if (searchTextController.text == '') {
        isSearchText.value = false;
      } else {
        isSearchText.value = true;
      }
      isSearch.value = isSearchFocus.value || isSearchText.value;
    });
    return AppBar(
      leading: Icon(
        Icons.search,
        color: Theme.of(context).primaryColor,
      ),
      actions: [
        TextButton(
          onPressed: searchTextController.text == ''
              ? null
              : () {
                  searchTextController.text = '';
                },
          child: Text(
            'クリア',
            style: searchTextController.text == ''
                ? Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)
                : Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
      titleSpacing: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: TextField(
        controller: searchTextController,
        focusNode: searchFocusNode,
        decoration: InputDecoration(
          labelText: '検索・新規登録',
          labelStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}