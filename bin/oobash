#!/bin/bash

# ---------------------------------------------------------------------------
# OO support functions
# Kludged by Pim van Riezen <pi@madscience.nl>
# ---------------------------------------------------------------------------
DEFCLASS=""
CLASS=""
THIS=0

class() {
  DEFCLASS="$1"
  eval CLASS_${DEFCLASS}_VARS=""
  eval CLASS_${DEFCLASS}_FUNCTIONS=""
}

static() {
  return 0
}

func() {
  local varname="CLASS_${DEFCLASS}_FUNCTIONS"
  eval "$varname=\"\${$varname}$1 \""
}

var() {
  local varname="CLASS_${DEFCLASS}_VARS"
  eval $varname="\"\${$varname}$1 \""
}

loadvar() {
  eval "varlist=\"\$CLASS_${CLASS}_VARS\""
  for var in $varlist; do
    eval "$var=\"\$INSTANCE_${THIS}_$var\""
  done
}

loadfunc() {
  eval "funclist=\"\$CLASS_${CLASS}_FUNCTIONS\""
  for func in $funclist; do
    eval "${func}() { ${CLASS}::${func} \"\$*\"; return \$?; }"
  done
}

savevar() {
  eval "varlist=\"\$CLASS_${CLASS}_VARS\""
  for var in $varlist; do
    eval "INSTANCE_${THIS}_$var=\"\$$var\""
  done
}

typeof() {
  eval echo \$TYPEOF_$1
}

new() {
  local class="$1"
  local cvar="$2"
  shift
  shift
  local id=$(uuidgen | tr A-F a-f | sed -e "s/-//g")
  eval TYPEOF_${id}=$class
  eval $cvar=$id
  local funclist
  eval "funclist=\"\$CLASS_${class}_FUNCTIONS\""
  for func in $funclist; do
    eval "${cvar}.${func}() { local t=\$THIS; THIS=$id; local c=\$CLASS; CLASS=$class; loadvar; loadfunc; ${class}::${func} \"\$*\"; rt=\$?; savevar; CLASS=\$c; THIS=\$t; return $rt; }"
  done
  eval "${cvar}.${class} \"\$*\" || true"
}

# ---------------------------------------------------------------------------
# Example code
# ---------------------------------------------------------------------------

# class definition
class Storpel
  func Storpel
  func setName
  func setQuality
  func print
  var name
  var quality

# class implementation
Storpel::Storpel() {
  setName "$1"
  setQuality "$2"
  if [ -z "$name" ]; then setName "Generic"; fi
  if [ -z "$quality" ]; then setQuality "Normal"; fi
}

Storpel::setName() { name="$1"; }
Storpel::setQuality() { quality="$1"; }
Storpel::print() { echo "$name ($quality)"; }

# usage
new Storpel one "Storpilator 1000" Medium
new Storpel two
new Storpel three

two.setName "Storpilator 2000"
two.setQuality "Strong"

one.print
two.print
three.print

echo ""

echo "one: $one ($(typeof $one))"
echo "two: $two ($(typeof $two))"
echo "three: $three ($(typeof $two))"
