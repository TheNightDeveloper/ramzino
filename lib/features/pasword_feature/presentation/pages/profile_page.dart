import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.only(top: 10.h),
            sliver: SliverToBoxAdapter(
              child: MenuContainer(
                context: context,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
