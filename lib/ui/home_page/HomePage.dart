import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/value/MyColor.dart';
import 'package:timer_note/value/MyString.dart';

import '../../value/MyDimension.dart';
import '../custom/HomeNoteView.dart';
import '../custom/dialog/SingleInputDialog.dart';
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
      backgroundColor: MyColor.secondaryColor,
      appBar: AppBar(
        title: const Text(MyString.homeTitle),
        backgroundColor: MyColor.primaryColor,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) {
              var index = -1;
              List<String> optionList = ["Title", "Create Time"];
              return optionList.map((option) {
                index ++;
                return PopupMenuItem(
                  value: index,
                  child: Text(option),
                );
              }).toList();
            },
            onSelected: (value) {
              switch (value) {
                case 0: {
                  viewModel.sortSubjects(SubjectsSortType.title);
                  break;
                }
                case 1: {
                  viewModel.sortSubjects(SubjectsSortType.createTime);
                  break;
                }
                default: {}
              }
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SingleInputDialog(
                  title: MyString.enterCategoryTitle,
                  inputHint: MyString.enterCategoryInputHint,
                  (title) { viewModel.addSubjectAndUpdate(title); }
                );
              });
        },
        backgroundColor: MyColor.emphasizeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: MyDimension.mainPadding),
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
                  child: Text(MyString.noSubject, style: TextStyle(color: MyColor.textOnPrimaryColor)),
                );
              case HomePageViewModelState.subjectUpdate:
                if (viewModel.noteFiles.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(MyString.noSubject, style: TextStyle(color: MyColor.textOnPrimaryColor, fontSize: MyDimension.fontSizeItemTitle), textAlign: TextAlign.center,),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        viewModel.recentSubject != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: MyDimension.mainPadding,
                                      top: MyDimension.mainPadding,
                                      right: MyDimension.mainPadding
                                  ),
                                  child: Text("Recent Topic", style: TextStyle(color: MyColor.textOnPrimaryColor, fontSize: MyDimension.fontSizeListTitle)),
                                ),
                                GestureDetector(
                                  onTapUp: (tapUpDetails) {
                                    Navigator.of(context).pushNamed('/note_list',
                                        arguments: {
                                          'note_files': viewModel.recentSubject
                                        }).then((value) {viewModel.getSubjects();});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: MyDimension.mainPadding,
                                        top: MyDimension.mainPadding,
                                        right: MyDimension.mainPadding),
                                    child: HomeNoteView(viewModel.recentSubject!, (uid) {viewModel.deleteSubject(uid);}),
                                  ),
                                )
                              ],
                            )
                        : Container(),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: MyDimension.mainPadding,
                              top: MyDimension.mainPadding,
                              right: MyDimension.mainPadding
                          ),
                          child: Text("All Topics", style: TextStyle(color: MyColor.textOnPrimaryColor, fontSize: MyDimension.fontSizeListTitle)),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: viewModel.noteFiles.length,
                            itemBuilder: (context, index) {
                              var subject = viewModel.noteFiles[index];
                              return GestureDetector(
                                onTapUp: (tapUpDetails) {
                                  viewModel.setRecentSubjectUid(viewModel.noteFiles[index].uuid);
                                  Navigator.of(context).pushNamed('/note_list',
                                      arguments: {
                                        'note_files': subject
                                      }).then((value) {viewModel.getSubjects();});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: MyDimension.mainPadding,
                                      top: MyDimension.mainPadding,
                                      right: MyDimension.mainPadding),
                                  child: HomeNoteView(subject, (uid){viewModel.deleteSubject(uid);}
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  );
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
