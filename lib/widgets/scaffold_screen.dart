import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/page_state_provider.dart';
import 'package:flutter_starter_project/widgets/loading.dart';

class ScaffoldScreen extends StatefulWidget {
  final Widget Function(BuildContext context, WidgetRef ref, Widget? child)
      pageBuilder;
  final Widget Function(BuildContext context, WidgetRef ref)?
      bottomNavigationBar;
  final Widget Function(BuildContext context, WidgetRef ref)? drawer;
  final AppBar Function(BuildContext context, WidgetRef ref)? appBar;
  final Widget Function(BuildContext context, WidgetRef ref)? bottomSheet;
  final String title;
  final Future<void> Function(BuildContext context)? onInit;

  const ScaffoldScreen(
      {Key? key,
      required this.title,
      required this.pageBuilder,
      this.drawer,
      this.appBar,
      this.bottomSheet,
      this.onInit,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  State<ScaffoldScreen> createState() => _ScaffoldScreenState();
}

class _ScaffoldScreenState extends State<ScaffoldScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) widget.onInit!(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final pageState = ref.watch(pageStateProvider);

      ref.listen(pageStateProvider, (prev, next) {
          if (next is PageError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(next.errorMessage, style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
            ));
          } else if (next is PageMessage) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(next.message, style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blueAccent,
            ));
          }
      });

      return Scaffold(
          appBar: widget.appBar != null
              ? widget.appBar!(context, ref)
              : AppBar(title: Text(widget.title), elevation: 0),
          drawer: widget.drawer != null ? widget.drawer!(context, ref) : null,
          bottomNavigationBar: widget.bottomNavigationBar != null
              ? widget.bottomNavigationBar!(context, ref)
              : null,
          bottomSheet: widget.bottomSheet != null
              ? widget.bottomSheet!(context, ref)
              : null,
          body: SafeArea(
              child: Stack(children: [
                widget.pageBuilder(context, ref, null),
                pageState is PageLoading ? Loading() : Container()
          ])));
    });
  }
}
