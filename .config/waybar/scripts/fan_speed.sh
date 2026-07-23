#!/bin/bash

CPU=$(sensors | awk '/cpu_fan/ {print $2}')

echo "{\"text\":\" 󰈐 ${CPU}rpm\", \
\"tooltip\":\"CPU Fan Speed: ${CPU}rpm\"}"
