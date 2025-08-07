#!/usr/bin/env bash

main() {
  local operation="$1"
  local number="$2"
  local sum=0
  local sum_of_squares=0

  for ((i = 1; i <= number; i++)); do
    ((sum += i))
    ((sum_of_squares += i * i))
  done

  case "$operation" in
  "square_of_sum")
    echo $((sum * sum))
    ;;
  "sum_of_squares")
    echo $((sum_of_squares))
    ;;
  "difference")
    echo $((sum * sum - sum_of_squares))
    ;;
  *)
    echo "Unknown operation"
    return 1
    ;;
  esac
}

main "$@"
