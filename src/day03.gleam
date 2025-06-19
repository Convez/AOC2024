import gleam/list
import gleam/int
import gleam/io
import utils
import gleam/result
import gleam/regexp
import gleam/option

pub fn sum_regex_outputs(match :regexp.Match) -> Int {
  match.submatches
  |> option.values
  |> list.map(int.parse)
  |> result.values
  |> list.reduce(fn(acc,x){acc*x})
  |> result.unwrap(0)
}

pub fn solve_part1(input: String) -> Int {
  "mul\\((\\d+),(\\d+)\\)" 
  |> regexp.from_string
  |> result.try(fn(r) {Ok(regexp.scan(r,input))})
  |> result.try(fn(l) {Ok(l |> list.map(sum_regex_outputs))})
  |> result.try(fn(l) {Ok(l |> list.reduce(fn(acc,x){acc+x}))})
  |> result.unwrap(Ok(0))
  |> result.unwrap(0)
  
}
pub fn process_do(dos: List(String)) -> Int{
  dos |> list.drop(1) |> list.map(solve_part1) |> list.reduce(fn(acc,x){acc+x})
  |> result.unwrap(0)
}

pub fn process_dont(donts: List(String)) -> Int {
  let first_to_do = donts |> list.first |> result.unwrap("default") |> solve_part1
  let to_evaluate = donts |> list.drop(1) 
  echo to_evaluate
  let do_regx = "do\\(\\)"
  |>regexp.from_string
  let evaluated = to_evaluate 
  |> list.map(fn(d){do_regx |> result.map(fn(r){r |> regexp.split(d)}) |> result.map(process_do)|>result.unwrap(0)})
  |> list.reduce(fn(acc,x){acc+x}) |> result.unwrap(0)
  first_to_do + evaluated
  }

pub fn solve_part2(input: String) -> Int {
  "don\\'t\\(\\)"
  |> regexp.from_string
  |> result.map(fn(r){regexp.split(r, input)})
  |> result.map(process_dont)
  |> result.unwrap(0)
}

pub fn main() {
  let input = utils.read_input_file(03)
    |> result.unwrap(_, "Failed to read input")
  echo input

  io.println("Part 1: "<>int.to_string(solve_part1(input)))
  io.println("Part 2: "<>int.to_string(solve_part2(input)))
}
