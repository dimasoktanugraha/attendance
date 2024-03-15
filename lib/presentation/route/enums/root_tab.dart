part of '../app_router.dart';

enum RootTab {
  home('0'),
  attendance('1'),
  setting('2');

  final String value;
  const RootTab(this.value);

  factory RootTab.fromIndex(int index) {
    return values.firstWhere(
      (value) => value.value == '$index',
      orElse: () => RootTab.home,
    );
  }
}
