import gleam/int
import gleam/io
import gleam/result
import gleam/string
import simplifile

pub fn read_input_file(day: Int) -> Result(String, String) {
  read_file("inputs", day)
}

pub fn read_test_input_file(day: Int) -> Result(String, String) {
  read_file("test_inputs", day)
}

fn read_file(folder: String, day: Int) -> Result(String, String) {
  let day_str = case day < 10 {
    True -> "0" <> int.to_string(day)
    False -> int.to_string(day)
  }

  let path = folder <> "/day" <> day_str <> ".txt"

  simplifile.read(path)
  |> result.map_error(fn(reason) {
    "Could not read file: " <> simplifile.describe_error(reason)
  })
}
