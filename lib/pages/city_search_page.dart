import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sight/bloc/city_search_bloc/city_search_event.dart';
import '../bloc/city_search_bloc/city_search_bloc.dart';
import '../bloc/city_search_bloc/city_search_state.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            // Custom back button
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Container(
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 8),
                margin: EdgeInsets.only(right: 12),
                child: TextField(
                  onChanged: (value) {
                    context
                        .read<CitySearchBloc>()
                        .add(CitySearchQueryChanged(query: value));
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter a city name',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12), // Padding inside the TextField
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CitySearchBloc, CitySearchState>(
        builder: (context, state) {
          if (state is CitySearchLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CitySearchLoadSuccess) {
            return ListView.builder(
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final city = state.cities[index];
                return ListTile(
                  title: Text(city.name),
                  subtitle: Text(city.country),
                  onTap: () {
                    Navigator.pop(context, city);
                  },
                );
              },
            );
          } else if (state is CitySearchLoadFailure) {
            return Center(child: Text('Failed to load cities'));
          }
          return Container();
        },
      ),
    );
  }
}
