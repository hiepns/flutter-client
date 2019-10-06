import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_item.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class GroupList extends StatelessWidget {
  const GroupList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupListVM viewModel;

  @override
  Widget build(BuildContext context) {
    /*
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    */

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.groupList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.groupList.length,
                          itemBuilder: (BuildContext context, index) {
                            final groupId = viewModel.groupList[index];
                            final group = viewModel.groupMap[groupId];
                            final user = viewModel.user;

                            void showDialog() => showEntityActionsDialog(
                                entity: group,
                                context: context,
                                onEntityAction: viewModel.onEntityAction);

                            return GroupListItem(
                              user: viewModel.user,
                              filter: viewModel.filter,
                              group: group,
                              onTap: () => viewModel.onGroupTap(context, group),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, group, action);
                                }
                              },
                              onLongPress: () => showDialog(),
                            );
                          },
                        ),
                ),
        ),

        /*
        filteredClient != null
            ? Material(
                color: Colors.orangeAccent,
                elevation: 6.0,
                child: InkWell(
                  onTap: () => viewModel.onViewEntityFilterPressed(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          '${localization.filteredBy} ${filteredClient.listDisplayName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => viewModel.onClearEntityFilterPressed(),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.groupList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.groupList.length,
                          itemBuilder: (BuildContext context, index) {
                            final user = viewModel.user;
                            final groupId = viewModel.groupList[index];
                            final group = viewModel.groupMap[groupId];
                            final client =
                                viewModel.clientMap[group.clientId] ??
                                    ClientEntity();


                              void showDialog() => showEntityActionsDialog(
                                  entity: group,
                                  context: context,
                                  user: user,
                                  onEntityAction: viewModel.onEntityAction);



                            return GroupListItem(
                                 user: viewModel.user,
                                 filter: viewModel.filter,
                                 group: group,
                                 client:
                                     viewModel.clientMap[group.clientId] ??
                                         ClientEntity(),
                                 onTap: () =>
                                     viewModel.onGroupTap(context, group),
                                 onEntityAction: (EntityAction action) {
                                   if (action == EntityAction.more) {
                                     showDialog();
                                   } else {
                                     viewModel.onEntityAction(
                                         context, group, action);
                                   }
                                 },
                                 onLongPress: () =>
                                    showDialog(),
                               );
                          },
                        ),
                ),
        ),*/
      ],
    );
  }
}
