import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:list_todo/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future isVisited({moreFunction}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(Constants.isVisited, true);
    moreFunction();
  }

  Future registerName({username}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.username, jsonEncode(username));
  }

  Future saveData({data}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.notes, jsonEncode(data));
  }

  Future loadUsername({username}) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(Constants.username)) {
      var prefsUsername = jsonDecode(prefs.getString(Constants.username)!);
      username(prefsUsername);
    }
  }

  Future loadData({noteList}) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(Constants.notes)) {
      final prefsNotes = jsonDecode(prefs.getString(Constants.notes)!);
      for (var i = 0; i < prefsNotes.length; i++) {
        noteList.add(prefsNotes[i]);
      }
    }
  }
}
