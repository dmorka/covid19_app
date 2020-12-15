import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const backgroundColor = Color(0XFFeffedf2);
const mainColor = Color(0XFF8d12fe);
var numFormatter = NumberFormat("###,000", "en_US");

const ANNOUNCEMENT_DATA = [
  {
    "name":"Anna",
    "description":"Potrzebuję pomocy w...",
    "when":"05-11-2020 11:20",
    "where":"Warszawa, Śródmieście"
  },
  {
    "name":"Paweł",
    "description":"Potrzebuję pomocy z...",
    "when":"07-11-2020 15:30",
    "where":"Warszawa, Śródmieście"
  },
  {
    "name":"Patryk",
    "description":"Czy ktoś może mi pomóc w...",
    "when":"09-11-2020 09:10",
    "where":"Warszawa, Ursynów"
  },
  {
    "name":"Piotr",
    "description":"Bardzo potrzebuję...",
    "when":"ASAP",
    "where":"Warszawa, Żoliborz"
  }
];