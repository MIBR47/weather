import 'package:flutter/material.dart';

import '../theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var selectedIndex = 0;
  String selectedChip = '';

  @override
  initState() {
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {}

  // Future<String?> runChips(int index) async {
  //   final chips = selectedChip[index];
  //   if (chips.isEmpty) {
  //     final doctor = _foundDoctor[index];
  //   } else {
  //     final doctor = _foundDoctor
  //         .where((element) =>
  //             element.profesi!.toLowerCase().contains(chips.toLowerCase()))
  //         .toList()[index];
  //   }
  //   return doctor;
  // }

  // void _runChips(String clickedChip) {
  //   List<Doctor> resultsCategory = [];
  //   if (clickedChip.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     resultsCategory = allDoctor;
  //   } else {
  //     resultsCategory = allDoctor
  //         .where((user) =>
  //             user.profesi!.toLowerCase().contains(clickedChip.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }

  //   // Refresh the UI
  //   setState(() {
  //     _foundDoctor = resultsCategory;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Widget searchbar() {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: TextField(
          autofocus: true,
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
              hintText: "Try Chiropractic",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.blueAccent,
              )),
        ),
      );
    }

    // Widget filtercard() {
    //   return SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: Row(
    //       children: [
    //         SizedBox(
    //           // width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height * 0.1,
    //           child: ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: doctors.length,
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemBuilder: ((context, index) {
    //               // ValueKey(doctors[index].id);
    //               final doctor = doctors[index];
    //               return Padding(
    //                 padding: const EdgeInsets.only(right: 8.0),
    //                 child: ChoiceChip(
    //                   label: Text(
    //                     doctor.profesi!,
    //                     style: selectedIndex == doctor.id
    //                         ? whiteTextStyle.copyWith(
    //                             fontSize: 16, fontWeight: reguler)
    //                         : greyTextStyle.copyWith(
    //                             fontSize: 16, fontWeight: reguler),
    //                   ),
    //                   selected: selectedIndex == doctor.id,
    //                   shape: StadiumBorder(
    //                       side: BorderSide(
    //                           color: selectedIndex == doctor.id
    //                               ? Colors.transparent
    //                               : grey40)),
    //                   selectedColor: secondaryBlue,
    //                   disabledColor: white,
    //                   backgroundColor: white,
    //                   onSelected: (bool value) {
    //                     setState(() {
    //                       selectedIndex = doctor.id!;
    //                       selectedChip = doctor.profesi!;
    //                       if (selectedChip.isEmpty) {
    //                         _foundCategory = allDoctor;
    //                       } else {
    //                         _foundCategory = allDoctor
    //                             .where((element) => element.profesi!
    //                                 .toLowerCase()
    //                                 .contains(selectedChip.toLowerCase()))
    //                             .toList();
    //                       }
    //                       print(selectedChip);
    //                       // return _runChips(value);
    //                     });
    //                   },
    //                 ),
    //               );
    //             }),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget cardlist() {
    //   return SizedBox(
    //     child: _foundDoctor.isNotEmpty
    //         ? ListView.builder(
    //             itemCount: _foundDoctor.length,
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemBuilder: ((context, index) {
    //               // ValueKey(_foundDoctor[index].id);
    //               final doctor = _foundDoctor[index];
    //               return TherapiestCard(
    //                 doctor,
    //               );
    //             }),
    //           )
    //         : const Text(
    //             'No results found',
    //             style: TextStyle(fontSize: 24),
    //           ),
    //   );
    // }

    Widget body() {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          // margin: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: [
                    searchbar(),
                    // filtercard(),
                    // cardlist(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // header(),
              body(),
            ],
          ),
        ),
      ),
    );
  }
}
