#!/usr/bin/env bash

main() {
  local digits="$1"
  local len="${#digits}"
  local index=0
  local sum=0
  while true; do
    if [[ "$index" -ge "$len" ]]; then
      break
    else
      digit="${digits:${index}:1}"
      raised_digit=$((digit ** len))
      sum=$((sum + raised_digit))
      ((index++))
    fi
  done
  if [[ "$sum" -eq "$digits" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

main "$@"
