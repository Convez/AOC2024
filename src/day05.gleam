import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/set
import gleam/string
import utils

pub fn extract_rules(
  input: String,
) -> #(dict.Dict(String, set.Set(String)), List(List(String))) {
  let #(rules, actions) =
    input
    |> string.split("\n")
    |> list.split_while(fn(s) { !string.is_empty(s) })
  let rules =
    rules
    |> list.map(fn(s) { s |> string.trim |> string.split("|") })
    |> list.group(fn(sp) { sp |> list.first |> result.unwrap("") })
    |> dict.map_values(fn(_k, sp) {
      sp
      |> list.map(fn(s) { s |> list.last |> result.unwrap("") })
      |> set.from_list
    })
  let actions =
    actions
    |> list.filter_map(fn(s) {
      case s |> string.is_empty {
        True -> Error("")
        False -> Ok(s |> string.split(","))
      }
    })
  #(rules, actions)
}

pub fn is_action_valid(
  action: List(String),
  rules: dict.Dict(String, set.Set(String)),
) -> Bool {
  let current = action |> list.first
  case current {
    // We can't pop anything. So Ok
    Error(_) -> True
    Ok(curr) -> {
      let next = action |> list.drop(1)
      is_action_valid(next, rules)
      && rules
      |> dict.get(curr)
      // If an element does not exist in the dict, it must be the last element
      // Always, so empty set
      |> result.try_recover(fn(_) { Ok(set.new()) })
      |> result.try(fn(rs) {
        case next |> list.all(fn(n) { rs |> set.contains(n) }) {
          False -> Error(Nil)
          True -> Ok(True)
        }
      })
      |> result.unwrap(False)
    }
  }
}

pub fn solve_part1(input: String) -> Int {
  let #(rules, actions) = input |> extract_rules
  actions
  |> list.filter(fn(a) { is_action_valid(a, rules) })
  |> list.map(fn(a) { a |> list.take(1 + list.length(a) / 2) |> list.last })
  |> result.values
  |> list.map(int.parse)
  |> result.values
  |> list.fold(0, fn(acc, x) { acc + x })
}

pub fn count_allowed(
  to_check: String,
  actions: List(String),
  rules: dict.Dict(String, set.Set(String)),
) -> Int {
  rules
  |> dict.get(to_check)
  |> result.try_recover(fn(_) { Ok(set.new()) })
  |> result.map(fn(r) { actions |> list.count(fn(a) { r |> set.contains(a) }) })
  |> result.unwrap(0)
}

pub fn fix_invalid(
  action: List(String),
  rules: dict.Dict(String, set.Set(String)),
) -> List(String) {
  action
  |> list.map(fn(a) { #(a, count_allowed(a, action, rules)) })
  |> list.sort(fn(a, b) {
    let #(_, ca) = a
    let #(_, cb) = b
    int.compare(cb, ca)
  })
  |> list.map(fn(a) {
    let #(s, _) = a
    s
  })
}

pub fn solve_part2(input: String) -> Int {
  let #(rules, actions) = input |> extract_rules
  actions
  |> list.filter(fn(a) { !is_action_valid(a, rules) })
  |> list.map(fn(a) { a |> fix_invalid(rules) })
  |> list.map(fn(a) { a |> list.take(1 + list.length(a) / 2) |> list.last })
  |> result.values
  |> list.map(int.parse)
  |> result.values
  |> list.fold(0, fn(acc, x) { acc + x })
}

pub fn main() {
  let input =
    utils.read_input_file(05)
    |> result.unwrap("Failed to read input")
  io.println("Part 1:" <> int.to_string(solve_part1(input)))
  io.println("Part 2:" <> int.to_string(solve_part2(input)))
}
