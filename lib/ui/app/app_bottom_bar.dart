import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/data/models/models.dart';

class AppBottomBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  final List<String> sortFields;
  final Function(String) onSelectedSortField;
  final String selectedSortField;
  final bool selectedSortAscending;

  final List<int> selectStatusIds;
  final List<int> selectStateIds;
  final Function(List<int>) onSelectedStatusIds;
  final Function(List<int>) onSelectedStateIds;

  AppBottomBar(
      {this.scaffoldKey,
        this.sortFields,
        this.onSelectedSortField,
        this.selectedSortField,
        this.selectedSortAscending,
        this.selectStateIds,
        this.selectStatusIds,
        this.onSelectedStateIds,
        this.onSelectedStatusIds});

  @override
  _AppBottomBarState createState() => new _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  PersistentBottomSheetController _sortController;
  PersistentBottomSheetController _filterController;

  @override
  Widget build(BuildContext context) {
    final _showFilterSheet = () {
      if (_filterController != null) {
        _filterController.close();
        return;
      }

      _filterController = widget.scaffoldKey.currentState.showBottomSheet((context) {
        return Container(
          color: Colors.grey[200],
          child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Column(
              children: EntityState.values.map<Widget>((state) {
                return CheckboxListTile(
                  title: Text(AppLocalization.of(context).lookup(state.toString())),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: true,
                  dense: true,
                  onChanged: (value) {

                  },
                );
              }).toList(),
            ),
            /*
            Column(
                mainAxisSize: MainAxisSize.min,
                children: sortFields.map((sortField) {
                  return CheckboxListTile(
                    dense: true,
                    title:
                        Text(AppLocalization.of(context).lookup(sortField)),
                    groupValue: selectedSortField,
                    onChanged: (value) {
                      this.onSelectedSortField(value);
                    },
                    value: sortField,
                  );
                }).toList()),
                */
          ]),
        );
      });

      _filterController.closed.whenComplete(() {
        _filterController = null;
      });
    };

    final _showSortSheet = () {
      if (_sortController != null) {
        _sortController.close();
        return;
      }

      _sortController = widget.scaffoldKey.currentState.showBottomSheet((context) {
        return Container(
          color: Colors.grey[200],
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.sortFields.map((sortField) {
                return RadioListTile(
                  dense: true,
                  title: Text(AppLocalization.of(context).lookup(sortField)),
                  subtitle: sortField == widget.selectedSortField
                      ? Text(widget.selectedSortAscending
                      ? AppLocalization.of(context).ascending
                      : AppLocalization.of(context).descending)
                      : null,
                  groupValue: widget.selectedSortField,
                  onChanged: (value) {
                    widget.onSelectedSortField(value);
                  },
                  value: sortField,
                );
              }).toList()),
        );
      });

      _sortController.closed.whenComplete(() {
        _sortController = null;
      });
    };

    return new BottomAppBar(
      hasNotch: true,
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: AppLocalization.of(context).sort,
            icon: Icon(Icons.sort_by_alpha),
            onPressed: _showSortSheet,
          ),
          IconButton(
            tooltip: AppLocalization.of(context).filter,
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
    );
  }
}