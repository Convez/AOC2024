import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub fn extract(input: String) -> List(List(Int)) {
  let res =
    input
    |> string.split("\n")
    |> list.map(fn(l) {
      l
      |> string.split(" ")
      |> list.filter(fn(s) { !string.is_empty(s) })
      |> list.map(int.parse)
      |> result.values
    })
    |> list.filter(fn(l) { !list.is_empty(l) })
  res
}

pub fn solve_part1(input: List(List(Int))) -> Int {
  let res =
    input
    |> list.map(is_ok_sorting)
    |> result.values
    |> list.map(is_ok_distance)
    |> list.filter(result.is_ok)
    |> list.length

  res
}

pub fn solve_part2(input: List(List(Int))) -> Int {
  input
  |> list.map(check_potential)
  |> list.count(result.is_ok)
}

fn is_ok_sorting(input: List(Int)) -> Result(List(Int), List(Int)) {
  let sorted =
    input
    |> list.sort(int.compare)
  case sorted == input || list.reverse(sorted) == input {
    True -> Ok(input)
    False -> Error(input)
  }
}

fn is_ok_distance(input: List(Int)) -> Result(List(Int), List(Int)) {
  let is_ok =
    input
    |> list.window_by_2
    |> list.map(fn(t) {
      let #(a, b) = t
      case int.absolute_value(a - b) == 0 || int.absolute_value(a - b) > 3 {
        True -> Error(int.absolute_value(a - b))
        False -> Ok(int.absolute_value(a - b))
      }
    })
    |> list.all(result.is_ok)
  case is_ok {
    True -> Ok(input)
    False -> Error(input)
  }
}

fn check_without_item(
  input: List(Int),
  remove_at: Int,
) -> Result(List(Int), List(Int)) {
  case remove_at >= list.length(input) {
    True -> Error(input)
    False -> {
      input
      |> list.index_map(fn(x, i) { #(i, x) })
      |> list.filter(fn(a) { a.0 != remove_at })
      |> list.map(fn(a) { a.1 })
      |> is_ok_sorting
      |> result.then(is_ok_distance)
      |> result.try_recover(fn(e) { check_without_item(input, remove_at + 1) })
    }
  }
}

fn check_potential(input: List(Int)) -> Result(List(Int), List(Int)) {
  input
  |> is_ok_sorting
  |> result.then(is_ok_distance)
  |> result.try_recover(fn(e) { check_without_item(input, 0) })
}

pub fn main() {
  let input =
    utils.read_input_file(02)
    |> result.unwrap("Failed to read input")
    |> extract
  io.println("Part 1: " <> int.to_string(solve_part1(input)))
  io.println("Part 2: " <> int.to_string(solve_part2(input)))
}
