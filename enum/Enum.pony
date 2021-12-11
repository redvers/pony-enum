use "collections"

primitive Enum
  fun to_array[A: Any #read](iteratorin: Iterator[A]): Array[A] =>
    let rv: Array[A] = []
    for a in iteratorin do
      rv.push(a)
    end
    rv

  fun sort[A: Any #read, B: Comparable[B] #read](arrayin: Array[A], sortfunc: {(A): B}): Array[A] ? =>
    let temptuplemap: MapIs[B, Array[A]] = MapIs[B, Array[A]]
    for tuple in arrayin.values() do
      let comparable: B = sortfunc(tuple)
      let oldv: Array[A] = temptuplemap.get_or_else(comparable, [])
      oldv.push(tuple)
      temptuplemap.update(comparable, oldv)
    end

    let sorted: Array[B] = Sort[Array[B], B](Enum.to_array[B](temptuplemap.keys()))
    let rv: Array[A] = Array[A]
    for tempkey in sorted.values() do
      rv.concat(temptuplemap(tempkey)?.values())
    end
    rv

  fun filter[A: Any #read](arrayin: Array[A], filterfunc: {(A): Bool}): Array[A] =>
    let rv: Array[A] = Array[A]
    for tuple in arrayin.values() do
      if (filterfunc(tuple)) then rv.push(tuple) end
    end
    rv

  fun reject[A: Any #read](arrayin: Array[A], filterfunc: {(A): Bool}): Array[A] =>
    let rv: Array[A] = Array[A]
    for tuple in arrayin.values() do
      if (filterfunc(tuple)) then continue else rv.push(tuple) end
    end
    rv

  fun map[A: Any #read, B: Any #read](arrayin: Array[A], mapfunc: {(A): B}): Array[B] =>
    let rv: Array[B] = Array[B]
    for tuple in arrayin.values() do
      rv.push(mapfunc(tuple))
    end
    rv

  fun reduce[A: Any #read, B: Any #read](arrayin: Array[A], initial: B, reducefunc: {(A, B): B}): B =>
    var rv: B = initial
    for tuple in arrayin.values() do
      rv = reducefunc(tuple, rv)
    end
    rv

