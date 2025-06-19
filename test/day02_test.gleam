import gleeunit/should
import day02
import utils
import gleeunit
import gleam/result
import gleam/io

pub fn tests() {
  io.println("Day day02 - Part 1...")
  let input = utils.read_test_input_file(2)
    |> result.unwrap(_, "Missing test input")
    |> day02.extract

  let output = day02.solve_part1(input)

  should.equal(output, 2)
  io.println("OK") 

  io.println("Day day02 - Part 2...")
  let output = day02.solve_part2(input)

  should.equal(output, 4)
  io.println("OK") 
}
