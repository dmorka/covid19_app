import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const backgroundColor = Color(0XFFeffedf2);
const mainColor = Color(0XFF8d12fe);
var numFormatter = NumberFormat("###,000", "en_US");

const COVID_LABS_REQ_BODY = ''
    '<wfs:GetFeature xmlns:wfs="http://www.opengis.net/wfs" service="WFS" version="1.1.0" outputFormat="json" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.1.0/wfs.xsd">'
    '   <wfs:Query typeName="feature:laboratoria_covid" srsName="EPSG:900913" xmlns:feature="urn:x-isdp:gs:namespace:default"></wfs:Query>'
    '</wfs:GetFeature>'
    '';

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