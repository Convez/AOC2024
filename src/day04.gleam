import gleam/bitwise
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

const to_find = "XMAS"

const mas = "MAS"

pub fn transpose(characters: List(String)) -> List(String) {
  characters
  |> list.map(fn(s) { s |> string.split("") })
  |> list.transpose
  |> list.map(fn(l) { l |> list.fold("", fn(b, a) { b <> a }) })
}

pub fn mirror(characters: List(String)) -> List(String) {
  characters
  |> list.map(string.reverse)
}

pub fn make_vertical_slices(
  characters: List(String),
  slice_size: Int,
) -> List(String) {
  characters
  |> transpose
  |> make_horizontal_slices(slice_size)
}

pub fn make_horizontal_slices(
  characters: List(String),
  slice_size: Int,
) -> List(String) {
  characters
  |> list.map(fn(l) { l |> string.split("") |> list.window(slice_size) })
  |> list.flatten
  |> list.map(fn(l) { l |> list.fold("", fn(b, a) { b <> a }) })
}

pub fn make_diagonal_slices(
  characters: List(String),
  row: Int,
  col: Int,
  slice_size: Int,
) -> List(String) {
  let chars_dir =
    characters |> list.index_map(fn(x, i) { #(i, x) }) |> dict.from_list
  list.range(0, row)
  |> list.map(fn(i) {
    list.range(0, col)
    |> list.map(fn(j) {
      list.range(0, slice_size - 1)
      |> list.map(fn(k) {
        chars_dir
        |> dict.get(i + k)
        |> result.unwrap("")
        |> string.slice(j + k, 1)
      })
      |> list.fold("", fn(b, a) { b <> a })
    })
  })
  |> list.flatten
}

pub fn make_reverse_diagonal_slices(
  characters: List(String),
  row: Int,
  col: Int,
  slice_size: Int,
) -> List(String) {
  characters
  |> mirror
  |> make_diagonal_slices(row, col, slice_size)
}

pub fn solve_part1(input: String) -> Int {
  let canonised =
    input
    |> string.split("\n")
    |> list.filter(fn(s) { !string.is_empty(s) })
    |> list.map(string.trim_end)
  let col = canonised |> list.first |> result.unwrap("") |> string.length
  let row = canonised |> list.length
  let to_find_size = to_find |> string.length

  let hor =
    canonised
    |> make_horizontal_slices(to_find_size)
    |> list.count(fn(s) { s == to_find || string.reverse(s) == to_find })
  let ver =
    canonised
    |> make_vertical_slices(to_find_size)
    |> list.count(fn(s) { s == to_find || string.reverse(s) == to_find })
  let diag =
    canonised
    |> make_diagonal_slices(row, col, to_find_size)
    |> list.count(fn(s) { s == to_find || string.reverse(s) == to_find })
  let rev_diag =
    canonised
    |> make_reverse_diagonal_slices(row, col, to_find_size)
    |> list.count(fn(s) { s == to_find || string.reverse(s) == to_find })
  hor + ver + diag + rev_diag
}

pub fn solve_part2(input: String) -> Int {
  let canonised =
    input
    |> string.split("\n")
    |> list.filter(fn(s) { !string.is_empty(s) })
    |> list.map(string.trim_end)
  let mas_size = mas |> string.length
  let col = canonised |> list.first |> result.unwrap("") |> string.length
  canonised
  |> list.map(fn(s) { s |> string.split("") })
  |> list.window(mas_size)
  |> list.map(fn(l) {
    l
    |> list.transpose
    |> list.window(3)
    |> list.map(list.transpose)
    |> list.map(fn(il) {
      let w =
        il
        |> list.map(fn(iil) { iil |> list.fold("", fn(a, b) { a <> b }) })
      let d =
        w
        |> make_diagonal_slices(mas_size, mas_size, mas_size)
        |> list.count(fn(s) { s == mas || string.reverse(s) == mas })
      let r =
        w
        |> make_reverse_diagonal_slices(mas_size, mas_size, mas_size)
        |> list.count(fn(s) { s == mas || string.reverse(s) == mas })
      bitwise.and(d, r)
    })
    |> list.fold(0, fn(a, b) { a + b })
  })
  |> list.fold(0, fn(a, b) { a + b })
}

pub fn main() {
  let input =
    utils.read_input_file(04)
    |> result.unwrap("Failed to read input")

  io.println("Part 1: " <> int.to_string(solve_part1(input)))
  io.println("Part 2: " <> int.to_string(solve_part2(input)))
}
