import 'package:flutter/material.dart';

class NewListPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Create a new list',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'List name'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Create a new list to group different wanted items.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              String title = _titleController.text;
              print('List name: $title');
              Navigator.pop(context);
            },
            child: Text('Create List'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, kMinInteractiveDimension),
            ),
          ),
        ],
      ),
    );
  }
}
