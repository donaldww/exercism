#!/usr/bin/env bash

main() {
  local digits="$1"
  local len="${#digits}"
  local index=0
  local sum=0
  while [[ $index -lt $len ]]; do
    digit="${digits:${index}:1}"
    ((sum += digit ** len))
    ((index++))
  done
  [[ $sum -eq $digits ]] && echo "true" || echo "false"
}

main "$@"
