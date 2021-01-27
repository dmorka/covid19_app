import 'package:covid19_app/models/user.dart';
import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  final UserModel userModel;

  ContactInfo(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserPersonalDataItem(
            Icons.phone, userModel.phoneNumber, context),
        SizedBox(height: 5),
        _buildUserPersonalDataItem(Icons.location_pin,
            userModel.address.getFullAddress(), context),
        Text("ID: " + userModel.id)
      ],
    );
  }

  Widget _buildUserPersonalDataItem(IconData icon, String value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        SizedBox(width: 5),
        Container(
          width: MediaQuery.of(context).size.width * .5,
          child: Text(
            value,
            style: TextStyle(
                color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
