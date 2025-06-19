import day22
import gleam/io
import gleam/result
import gleeunit
import gleeunit/should
import utils

pub fn tests() {
  io.println("Day day22 - Part 1...")
  let input =
    utils.read_test_input_file(1)
    |> result.unwrap("Missing test input")

  let output = day22.solve_part1(input)

  should.equal(output, 0)
  io.println("OK")
  io.println("Day day22 - Part 2...")
  let input =
    utils.read_test_input_file(1)
    |> result.unwrap("Missing test input")

  let output = day22.solve_part2(input)

  should.equal(output, 0)
  io.println("OK")
}
