import 'package:flutter/material.dart';

class MyTextEditingController extends TextEditingController {
  MyTextEditingController({
    String text,
    this.editingTextStyle = const TextStyle(backgroundColor: Colors.black12),
  }) : super(text: text);

// 增加editingTextStyle参数，让他随时可变自定义，默认灰色---↑↑↑↑↑↑↑↑↑↑↑↑↑
  final TextStyle editingTextStyle;

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: text);
    }
    // -----此处就是正在输入的样式
    final TextStyle composingStyle = style.merge(
      const TextStyle(decoration: TextDecoration.underline),
    );
    // -----↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--------
    // final TextStyle composingStyle = style.merge(editingTextStyle);
    // ---------------------------
    return TextSpan(style: style, children: <TextSpan>[
      TextSpan(text: value.composing.textBefore(value.text)),
      TextSpan(
        style: composingStyle,
        text: value.composing.textInside(value.text),
      ),
      TextSpan(text: value.composing.textAfter(value.text)),
    ]);
  }
}
