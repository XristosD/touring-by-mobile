import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touring_by/core/enums/index_state.dart';
import 'package:touring_by/core/viewmodels/index_touring_by_model.dart';
import 'package:touring_by/locator.dart';
import 'package:touring_by/ui/index_touring_by/initiallizing_view_model_view.dart';
import 'package:touring_by/ui/main_view.dart';
import 'package:touring_by/ui/shared/app_colors.dart';
import 'package:touring_by/ui/shared/widgets/custom_loading_indicator.dart';

class IndexTouringByView extends StatefulWidget {
  @override
  _IndexTouringByViewState createState() => _IndexTouringByViewState();
}

class _IndexTouringByViewState extends State<IndexTouringByView> {
  @override
  Widget build(BuildContext context) {
    final IndexState state = ModalRoute.of(context).settings.arguments as IndexState;
    return MainView(
        body: ChangeNotifierProvider<IndexTouringByModel>(
          create: (context) => IndexTouringByModel(indexState: state),
          builder: (context, child) {
            return InitializingViewModelView(
              viewModelInitializer: Provider.of<IndexTouringByModel>(context, listen: false).initializer,
              loadingView: Center(child: CustomLoadingIndicator(),),
              loadedView: Consumer<IndexTouringByModel>(
                builder: (context, model, child){
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    model.indexStateTitle(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(50)
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index){
                            if(model.timeToLoad(index)){
                              WidgetsBinding.instance.addPostFrameCallback((duration) {
                                model.loadMore();
                              });
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14.0),
                              child: ListTile(
                                onTap: (){
                                  Navigator.of(context).pushNamed("/show_touring_by", arguments: model.itemList[index]['id']);
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${model.itemList[index]['tour']['place']['name']}, ${model.dateFormater(model.itemList[index]['created_at'])}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17.0
                                      ),
                                    ),
                                    model.indexState == IndexState.Shared ?
                                    Text(
                                      "Shared by ${model.itemList[index]['user']['name']}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17.0
                                      ),
                                    ) :
                                    Container(),
                                    Text(
                                      model.itemList[index]['tour']['name'],
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Icon(Icons.arrow_right),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: primaryColor
                                        ),
                                      )
                                    )
                                  ],
                                )
                              ),
                            );
                          },
                          childCount: model.itemList.length
                        )
                      ),
                      SliverToBoxAdapter(
                        child: model.viewState == ViewState.Busy ? Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CustomLoadingIndicator(),),
                        ) : Container(),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
    );
  }
}
