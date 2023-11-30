import 'package:fluttertoast/fluttertoast.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController _searchTextControl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PasswordBloc>(context).add(GetAllPasswordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController =
        TabController(length: 3, vsync: this, initialIndex: 2);

    return Scaffold(
        backgroundColor: kbgColor,
        body: BlocConsumer<PasswordBloc, PasswordState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is PasswordAddedState) {
              ///
            } else if (state is LoadingState) {
              const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PasswordDeletedState) {
              BlocProvider.of<PasswordBloc>(context)
                  .add(GetAllPasswordsEvent());
              Fluttertoast.showToast(msg: 'رمز عبور حذف شد');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DashboardContainer(
                    searchTextControl: _searchTextControl,
                    context: context,
                  ),
                  TabsContainer(
                    tabController: _tabController,
                    context: context,
                  )
                ],
              ),
            );
          },
        ));
  }
}
