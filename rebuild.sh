#!/usr/bin/env bash

flutter pub get

#flutter packages pub run build_runner build --verbose

flutter packages pub run build_runner watch --delete-conflicting-outputs --verbose
