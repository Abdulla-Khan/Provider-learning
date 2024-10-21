import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_todo/common/colors/app_colors.dart';
import 'package:riverpod_todo/common/extensions/size_extension.dart';
import 'package:riverpod_todo/common/strings/app_strings.dart';
import 'package:riverpod_todo/provider/home_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text(
              appString,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(8),
              width: context.width,
              height: context.height * 0.07,
              decoration: BoxDecoration(
                  border: Border.all(color: blackColor),
                  borderRadius: BorderRadius.circular(18)),
              child: TextField(
                controller: context.watch<HomeProvider>().todoController,
                cursorColor: blackColor.withOpacity(0.4),
                maxLength: 20,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  context.read<HomeProvider>().updateText(text);
                },
              ),
            ),
            ListView.builder(
                itemCount: context.watch<HomeProvider>().taskList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            wordSpacing: 1,
                            letterSpacing: 2),
                      ),
                      title: Text(
                        context.watch<HomeProvider>().taskList[index].title,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 239, 239, 239),
                            fontWeight: FontWeight.bold,
                            wordSpacing: 1,
                            letterSpacing: 2),
                      ),
                      trailing: SizedBox(
                        width: context.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => context
                                  .read<HomeProvider>()
                                  .deleteTask(index),
                              icon: Icon(
                                Icons.delete,
                                color: iconColor,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<HomeProvider>()
                                    .showDialogForEdit(context, index);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: iconColor,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ),
      floatingActionButton:
          context.watch<HomeProvider>().todoController.text.isEmpty
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: () => context.read<HomeProvider>().addTask(),
                  backgroundColor: backgroundColor,
                  child: Icon(
                    Icons.add,
                    color: whiteColor,
                    size: 30,
                  ),
                ),
    );
  }  
}
