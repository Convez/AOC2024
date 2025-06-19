import gleam/io
import utils
import gleam/result

pub fn solve_part1(input: String) -> Int {
  0
}

pub fn solve_part2(input: String) -> Int {
  0
}
pub fn main() {
  let input = utils.read_input_file(21)
    |> result.unwrap(_, "Failed to read input")

  io.println("Part 1: \\(solve_part1(input))")
  io.println("Part 2: \\(solve_part2(input))")
}
