import 'dart:async';

import 'package:flutter/material.dart';

class InfiniteScroll extends StatefulWidget {
  final int numberOfElements;
  final int currentItems;
  final Future<void> Function() onLoadMore;
  final Widget Function(BuildContext context, int index) buildItem;
  final Widget? noItems;

  const InfiniteScroll({
    Key? key,
    required this.numberOfElements,
    required this.onLoadMore,
    required this.buildItem,
    required this.currentItems,
    this.noItems
  }) : super(key: key);

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState<T> extends State<InfiniteScroll> {
  late ScrollController controller;
  bool isLoading = false;
  bool isFinished = false;

  Timer? debounce;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    widget.onLoadMore();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    debounce?.cancel();
    super.dispose();
  }

  _scrollListener() async {
    if (controller.position.extentAfter < 100) {
      if (widget.currentItems >= widget.numberOfElements) setState(() {isFinished = true;});
      if (isFinished) return;
      if (isLoading) return;
      if (debounce?.isActive ?? false) return;
      setState(() {
        debounce = Timer(const Duration(milliseconds: 1000), () async {
          setState(() {isLoading = true;});
          await widget.onLoadMore();
          setState(() {isLoading = false;});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.numberOfElements == 0) {
       return widget.noItems ?? _emptyCard();
    }

    return ListView.builder(
        controller: controller,
        itemCount: isLoading ? widget.currentItems + 1 : widget.currentItems,
        itemBuilder: (context, index) {
            if (index == widget.currentItems ) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                    child: CircularProgressIndicator()
                ),
              );
            }
            return widget.buildItem(context, index);
        }
    );
  }

  Widget _emptyCard() {
    return const Card(
      child: Center(
        child: Text("Nessun elemento trovato"),
      ),
    );
  }
}
