use "enum"
use "collections"

actor Main
  let env: Env
  new create(env': Env) =>
    env = env'
    let map: Map[String, U8] = Map[String, U8]
    map.insert("This", 0)
    map.insert("Is", 2)
    map.insert("A", 4)
    map.insert("List", 7)
    map.insert("Of", 19)
    map.insert("Random", 1)
    map.insert("Words", 1)
    map.insert("Just", 42)
    map.insert("Because", 19)

    try
      let a0:       Array[(String, U8)] = Enum.to_array[(String, U8)](map.pairs())
      let sorteda0: Array[(String, U8)] = Enum.sort[(String, U8), U8](a0, {(tuple: (String, U8)) => (_, let value: U8) = tuple ; value})?

      env.out.print("These are in numeric order:")
      display(sorteda0)

      env.out.print("\n\nEven:")
      let even:     Array[(String, U8)] = Enum.filter[(String, U8)](sorteda0, {(tuple: (String, U8)) => (_, let value: U8) = tuple ; if (value.mod(2) == 0) then true else false end})
      display(even)

      env.out.print("\n\nOdd:")
      let odd:      Array[(String, U8)] = Enum.reject[(String, U8)](sorteda0, {(tuple: (String, U8)) => (_, let value: U8) = tuple ; if (value.mod(2) == 0) then true else false end})
      display(odd)

      env.out.print("\n\nAdd \" World\" to every string:")
      let world:    Array[(String, U8)] = Enum.map[(String, U8), (String, U8)](sorteda0, {(tuple: (String, U8)) => (let str: String, let value: U8) = tuple ; (str + " World", value)  })
      display(world)

      env.out.write("\n\nSum all the numbers: ")
      let sum: USize = Enum.reduce[(String, U8), USize](sorteda0, USize(0), {(tuple: (String, U8), acc: USize) => (_, let value: U8) = tuple ; acc + value.usize()  })
      env.out.print(sum.string())
    end




  fun display(arrayin: Array[(String, U8)]) =>
    for tuple in arrayin.values() do
      (let string: String, let value: U8) = tuple
      env.out.print(string + ": " + value.string())
    end
