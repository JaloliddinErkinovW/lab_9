import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'registration_screen.dart';

class DisplayTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information Table'),
      ),
      body: FutureBuilder<List<User>>(
        future: DBHelper().getUsers(), // Fetch the user data from the database
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No user data available.'));
          } else {
            // Display the table of user information
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Address')),
                ],
                rows: snapshot.data!.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user.username)),
                    DataCell(Text(user.phone)),
                    DataCell(Text(user.email)),
                    DataCell(Text(user.address)),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
