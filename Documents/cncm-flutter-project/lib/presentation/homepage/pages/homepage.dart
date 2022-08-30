import 'package:cncm_flutter_new/presentation/earning/pages/earnings.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newfeed_state.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newsfeed_events.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/event.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/state.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/tab_blogs.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/tab_home.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/tab_profile.dart';
import 'package:flutter/material.dart';
import '../../../service_locator.dart';
import '../../assets_manager/bloc/bloc.dart';
import '../../assets_manager/bloc/event.dart';
import '../../auth/blocs/department_bloc/bloc.dart';
import '../../auth/blocs/department_bloc/event.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String homePageRouteName = 'home page route name';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const TabHomePage(),
    EarningsPage(),
    const TabsBlog(),
    const TabProfilePage(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // BlocProvider.of<NewsFeedBloc>(context).add(LoadNewsFeed());
        // BlocProvider.of<TrailerBloc>(context).add(LoadTrailerEvent());
        // BlocProvider.of<AssetManageBloc>(context).add(LoadAssets());
        sl<NewsFeedBloc>().add(LoadNewsFeed());
        sl<TrailerBloc>().add(LoadTrailerEvent());
        sl<AssetManageBloc>().add(LoadAssets());
        sl<DepartmentBloc>().add(LoadDepartments());



        // return ;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            debugPrint('$index');
            setState(() {
              _selectedIndex = index;
              if(index == 2 || index == 0){
                if(sl<NewsFeedBloc>().state  is! LoadedNewsFeed) {
                  sl<NewsFeedBloc>().add(LoadNewsFeed());
                }
                if(sl<TrailerBloc>().state is! LoadedTrailer) {
                  sl<TrailerBloc>().add(LoadTrailerEvent());
                }
              }
            });
          },
          items: [
            const BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: '',
              icon: Icon(
                Icons.apps,
                // color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: '',
              icon: SvgPicture.asset(
                'assets/earn.svg',
                width: 18,
                  height: 18,
                color: (_selectedIndex == 1)? Colors.green : Colors.white,
                ) 
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: '',
              icon: SvgPicture.asset(
                  'assets/blog.svg',
                  width: 15,
                  height: 15,
                  color: (_selectedIndex == 2)? Colors.green : Colors.white,
                  ),
              ),
            const BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: '',
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
