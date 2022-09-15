import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/value/MyString.dart';

import '../../value/MyDimension.dart';
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
              // do something
            },
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<HomePageViewModel, HomePageViewModelState>(
          bloc: viewModel,
          builder: (context, state) {
            switch (state) {
              case HomePageViewModelState.init:
                return const Center(
                  child: Text(MyString.noNote),
                );
              case HomePageViewModelState.getMainNotesSuccess:
                return ListView.builder(
                    itemCount: viewModel.noteFiles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTapUp: (tapUpDetails) {
                          Navigator.of(context).pushNamed(
                              '/note_list',
                              arguments: {'note_files': viewModel.noteFiles[index]}
                          );
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.all(MyDimension.mainPadding),
                          child: AspectRatio(
                            aspectRatio: 3 / 1,
                            child: HomeNoteView(viewModel.noteFiles[index]),
                          ),
                        ),
                      );
                    });
            }
          },
        ),
      ),
    );
  }
}
