import 'package:ramzino/features/auth_feature/presentation/widgets/widgets_resource.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class PasswordsPage extends StatefulWidget {
  const PasswordsPage({super.key});

  @override
  State<PasswordsPage> createState() => _PasswordsPageState();
}

class _PasswordsPageState extends State<PasswordsPage> {
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordBloc, PasswordState>(
      listener: (context, state) {
        if (state is PasswordAddedState) {
          BlocProvider.of<PasswordBloc>(context).add(GetAllPasswordsEvent());
          Fluttertoast.showToast(msg: 'رمز عبور افزوده شد');
        } else if (state is PasswordDeletedState) {
          BlocProvider.of<PasswordBloc>(context).add(GetAllPasswordsEvent());
          Fluttertoast.showToast(msg: 'رمز حذف شد');
        } else if (state is PasswordUpdatedState) {
          BlocProvider.of<PasswordBloc>(context).add(GetAllPasswordsEvent());
          Fluttertoast.showToast(msg: 'رمز ویرایش  شد');
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatActionButton(
            context: context,
          ),
          backgroundColor: kbgColor,
          body: CustomScrollView(
            controller: _mainScrollController,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              sliverAppbar(_searchTextController),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                sliver: PasswordsList(
                  scrollController: _scrollController,
                  context: context,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
