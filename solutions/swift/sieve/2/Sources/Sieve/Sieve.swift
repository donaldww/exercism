/// sieve finds all prime numbers less than or equal to a given number.
func sieve(limit: Int) -> [Int] {
  guard limit >= 2 else { return [] }
  guard limit > 3 else { return Array(2...limit) }

  var isPrime = [Bool](repeating: true, count: limit + 1)
  isPrime[0] = false
  isPrime[1] = false

  let sqrtLimit = Int(Double(limit).squareRoot())
  for i in 2...sqrtLimit {
    if isPrime[i] {
      for j in stride(from: i * i, through: limit, by: i) {
        isPrime[j] = false
      }
    }
  }

  return (2...limit).filter { isPrime[$0] }
}
