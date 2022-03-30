import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/page_state_provider.dart';

class TabScreen extends ConsumerWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: OutlinedButton(
              onPressed: () {
                var controller = ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      backgroundColor: Colors.green,
                        content:
                            Container(child: Text("Sono un material banner")),
                        actions: [Container()]));
                Future.delayed(Duration(seconds: 3), () {
                  controller.close();
                });
              },
              child: Text("Material banner")),
        ),
        OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Snackbar")));
            },
            child: Text("Snack bar")),
        OutlinedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      elevation: 2.0,
                      title: Text("Title"),
                      content: Text("Content"),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"))
                      ],
                    );
                  });
            },
            child: Text("Dialog")),
        OutlinedButton(
            onPressed: () {
              ref.read(pageStateProvider.notifier).setLoading();
              Future.delayed(Duration(seconds: 3), () {
                ref.read(pageStateProvider.notifier).setIdle();
              });
            },
            child: Text("Page loading")),
        OutlinedButton(
            onPressed: () {
              ref.read(pageStateProvider.notifier).setError("Page error message");
            },
            child: Text("Page error")),
        OutlinedButton(
            onPressed: () {
              ref.read(pageStateProvider.notifier).setMessage("Page generic message");
            },
            child: Text("Page message")),
      ],
    );
  }
}
