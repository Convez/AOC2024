import day05
import gleam/io
import gleam/result
import gleeunit
import gleeunit/should
import utils

pub fn tests() {
  io.println("Day day05 - Part 1...")
  let input =
    utils.read_test_input_file(5)
    |> result.unwrap("Missing test input")

  let output = day05.solve_part1(input)

  should.equal(output, 143)
  io.println("OK")
  io.println("Day day05 - Part 2...")
  let input =
    utils.read_test_input_file(5)
    |> result.unwrap("Missing test input")

  let output = day05.solve_part2(input)

  should.equal(output, 123)
  io.println("OK")
}
