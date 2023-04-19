import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../common/constants/constants.dart';
import '../../eweet/view/eweet_list_view.dart';
import '../../eweet/view/new_eweet_view.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_floating_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  late final ValueNotifier<bool> _isDialOpen;

  @override
  void initState() {
    _isDialOpen = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _isDialOpen.dispose();
    super.dispose();
  }

  void _onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  _onCreatePost() {
    const NewEweetView().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _getBody(),
      bottomNavigationBar: AppBottomNavBar(
        page: _page,
        onPageChange: (x) => _onPageChange(x),
      ),
      floatingActionButton: AppFloatingButton(
        isDialOpen: _isDialOpen,
        onCreatePost: _onCreatePost,
      ),
    );
  }

  Widget _getBody() {
    switch (_page) {
      case 0:
        return const EweetListView();
      case 1:
        return Center(
            child: Text(
          "Explore Screen!",
          style: boldTextStyle(size: 22, color: Colors.white),
        ));
      case 2:
        return Center(
            child: Text(
          "Spaces Screen!",
          style: boldTextStyle(size: 22, color: Colors.white),
        ));
      case 3:
        return Center(
            child: Text(
          "Notifications Screen!",
          style: boldTextStyle(size: 22, color: Colors.white),
        ));
      case 4:
        return Center(
            child: Text(
          "Inbox Screen!",
          style: boldTextStyle(size: 22, color: Colors.white),
        ));

      default:
        return Center(
            child: Text(
          "Unknown Page!",
          style: boldTextStyle(size: 22, color: Colors.white),
        ));
    }
  }
}
