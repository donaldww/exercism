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
      ((sum += digit ** len))
      ((index++))
    fi
  done
  [[ $sum -eq $digits ]] && echo "true" || echo "false"
}

main "$@"
