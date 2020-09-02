abstract class AbsSwitchTab {}

// Appbottombar 切换
class SwitchTab implements AbsSwitchTab {
  int index;
  SwitchTab(this.index);
}

class Foo<T> {
  // 在这里实现
  String toString() => "Instance of 'Foo<$T>'";
}
