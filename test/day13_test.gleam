import gleeunit/should
import day13
import utils
import gleeunit
import gleam/result
import gleam/io

pub fn tests() {
  io.println("Day day13 - Part 1...")
  let input = utils.read_test_input_file(1)
    |> result.unwrap(_, "Missing test input")

  let output = day13.solve_part1(input)

  should.equal(output, 0)
  io.println("OK") 

  io.println("Day day13 - Part 2...")
  let input = utils.read_test_input_file(1)
    |> result.unwrap(_, "Missing test input")

  let output = day13.solve_part2(input)

  should.equal(output, 0)
  io.println("OK") 
}
