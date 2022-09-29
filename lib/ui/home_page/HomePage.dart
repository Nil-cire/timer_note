import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/value/MyString.dart';

import '../../value/MyDimension.dart';
import '../custom/AddSubjectDialog.dart';
import '../custom/HomeNoteView.dart';
import 'HomePageViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<HomePageViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(MyString.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddSubjectDialog((title) {
                      viewModel.addSubjectAndUpdate(title);
                    });
                  });
            },
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<HomePageViewModel, HomePageViewModelState>(
          bloc: viewModel,
          buildWhen: (context, state) {
            return (state == HomePageViewModelState.subjectUpdate ||
                state == HomePageViewModelState.init);
          },
          builder: (context, state) {
            switch (state) {
              case HomePageViewModelState.init:
                return const Center(
                  child: Text(MyString.noSubject),
                );
              case HomePageViewModelState.subjectUpdate:
                if (viewModel.noteFiles.isEmpty) {
                  return const Center(
                    child: Text(MyString.noSubject),
                  );
                } else {
                  return ListView.builder(
                      itemCount: viewModel.noteFiles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapUp: (tapUpDetails) {
                            Navigator.of(context).pushNamed('/note_list',
                                arguments: {
                                  'note_files': viewModel.noteFiles[index]
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: MyDimension.mainPadding,
                                top: MyDimension.mainPadding,
                                right: MyDimension.mainPadding),
                            child: HomeNoteView(viewModel.noteFiles[index]),
                          ),
                        );
                      });
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
