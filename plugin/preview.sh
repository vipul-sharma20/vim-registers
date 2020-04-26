#!/bin/bash

str=$1
preview="${str:2:100}"
echo $preview | fold -w 50
