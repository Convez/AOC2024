#!/usr/bin/env bash

set -e

mkdir -p src test inputs test_inputs

for i in $(seq -w 1 25); do
  day="day${i}"

  # test/dayXX_test.gleam
  cat > "test/${day}_test.gleam" <<EOF
import gleeunit/should
import ${day}
import utils
import gleeunit
import gleam/result
import gleam/io

pub fn tests() {
  io.println("Day ${day} - Part 1...")
  let input = utils.read_test_input_file(1)
    |> result.unwrap(_, "Missing test input")

  let output = ${day}.solve_part1(input)

  should.equal(output, 0)
  io.println("OK") 

  io.println("Day ${day} - Part 2...")
  let input = utils.read_test_input_file(1)
    |> result.unwrap(_, "Missing test input")

  let output = ${day}.solve_part2(input)

  should.equal(output, 0)
  io.println("OK") 
}
EOF

  touch "inputs/${day}.txt"
  touch "test_inputs/${day}.txt"
done

echo "✅ All 25 days initialized!"

