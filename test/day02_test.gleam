import day02
import gleam/io
import gleam/result
import gleeunit
import gleeunit/should
import utils

pub fn tests() {
  io.println("Day day02 - Part 1...")
  let input =
    utils.read_test_input_file(2)
    |> result.unwrap("Missing test input")
    |> day02.extract

  let output = day02.solve_part1(input)

  should.equal(output, 2)
  io.println("OK")
  io.println("Day day02 - Part 2...")
  let output = day02.solve_part2(input)

  should.equal(output, 4)
  io.println("OK")
}
