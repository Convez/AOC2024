import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub fn solve_part1(input: String) -> Int {
  0
}

pub fn solve_part2(input: String) -> Int {
  0
}

pub fn main() {
  let input =
    utils.read_input_file(07)
    |> result.unwrap("Failed to read input")

  io.println("Part 1: \\(solve_part1(input))")
  io.println("Part 2: \\(solve_part2(input))")
}
