import 'package:admissions/main.dart';
import 'package:admissions/state_tree.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  StateTree get state => getState<StateTree>();
  StateTree read() => getRead<StateTree>();
  R select<R>(R Function(StateTree state) selector) =>
      getSelect<StateTree, R>(selector);
  R? event<R>(Evt<R> Function(StateTree state) selector) =>
      getEvent<StateTree, R>(selector);
}

extension StatelessWidgetExtensions on StatelessWidget {
  StateTree get state => store.state;
}
