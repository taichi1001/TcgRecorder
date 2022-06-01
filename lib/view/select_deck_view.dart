import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectDeckView extends HookConsumerWidget {
  const SelectDeckView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ここが検索欄になる'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _RecentlyUsedView(),
            _AllListView(),
          ],
        ),
      ),
    );
  }
}

class _RecentlyUsedView extends HookConsumerWidget {
  const _RecentlyUsedView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ['a', 'b', 'c', 'b', 'c', 'b', 'c', 'b', 'c'];
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        if (index == 0 || index == list.length + 1) {
          return Container();
        }
        return ListTile(
          title: Text(list[index - 1]),
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          indent: 16,
          thickness: 1,
          height: 0,
        );
      }),
      itemCount: list.length + 2,
    );
  }
}

class _AllListView extends HookConsumerWidget {
  const _AllListView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ['a', 'b', 'c', 'd', 'e'];
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(list[index]),
        );
      }),
      separatorBuilder: ((context, index) {
        return Divider();
      }),
      itemCount: list.length,
    );
  }
}
