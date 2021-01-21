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
