import gleeunit/should
import day12
import utils
import gleeunit
import gleam/result
import gleam/io

pub fn tests() {
  io.println("Day day12 - Part 1...")
  let input = utils.read_test_input_file(1)
    |> result.unwrap(_, "Missing test input")

  let output = day12.solve_part1(input)

  should.equal(output, 0)
  io.println("OK") 

  io.println("Day day12 - Part 2...")
  let input = utils.read_test_input_file(1)
    |> result.unwrap(_, "Missing test input")

  let output = day12.solve_part2(input)

  should.equal(output, 0)
  io.println("OK") 
}
