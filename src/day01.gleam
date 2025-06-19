import gleam/io
import utils
import gleam/result
import gleam/int
import gleam/string
import gleam/list

pub fn extract_lists(input: String) -> #(List(Int),List(Int)){
  let lines = string.split(input,"\n")
  let n = list.map(lines, fn(l){
      let chars = string.split(l, " ")
      list.filter(chars, fn(c){!string.is_empty(c)})
    })  
  let fil_n = list.filter(n, fn(c){!list.is_empty(c)})
  let num_n = list.map(fil_n, fn(c){list.map(c, fn(ch){result.unwrap(int.parse(ch),0)})})
  let first_list = list.map(num_n,fn(c){result.unwrap(list.first(c),0)})
  let sec_list = list.map(num_n, fn(c){result.unwrap(list.last(c),0)})
  let ret = #(first_list, sec_list)
  ret
}

pub fn solve_part1(input: String) -> Int {
  let #(firsts, secs) = extract_lists(input)
  let f_ord = list.sort(firsts,int.compare)
  let s_ord = list.sort(secs, int.compare)
  let z_ord = list.zip(f_ord,s_ord)
  let z_sub = list.map(z_ord, fn(a){
    let #(f,s)=a
    let sub = f-s
    int.absolute_value(sub)
  })
  z_sub 
  |> list.reduce(fn(acc,x){acc+x})
  |> result.unwrap(0)
}

pub fn solve_part2(input: String) -> Int {
  let #(firsts,secs) = extract_lists(input) 
  firsts 
  |> list.map(fn(f) {f*list.count(secs, fn(s){s==f})})
  |> list.reduce(fn(acc,x){acc+x})
  |> result.unwrap(0)
}


pub fn main() {
  let input = utils.read_input_file(01)
    |> result.unwrap(_, "Failed to read input")

  io.println("Part 1: "<> int.to_string(solve_part1(input)))
  io.println("Part 2: " <>int.to_string(solve_part2(input)))
}
