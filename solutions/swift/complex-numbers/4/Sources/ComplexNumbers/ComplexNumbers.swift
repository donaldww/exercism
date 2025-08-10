//
// Exercism
// ComplexNumbers.swift
// Sun Oct 27 2024
//

import Foundation

struct ComplexNumbers: Equatable {
  var realComponent: Double
  var imaginaryComponent: Double

  init(realComponent: Double, imaginaryComponent: Double?) {
    self.realComponent = realComponent
    self.imaginaryComponent = imaginaryComponent ?? 0.0
  }

  var real: Double {
    return realComponent
  }

  var imaginary: Double {
    return imaginaryComponent
  }

  private func getComponents(_ cn: ComplexNumbers) -> (Double, Double, Double, Double) {
    let a = self.realComponent
    let b = self.imaginaryComponent
    let c = cn.realComponent
    let d = cn.imaginaryComponent
    return (a, b, c, d)
  }

  func add(complexNumber: ComplexNumbers) -> ComplexNumbers {
    let (a, b, c, d) = getComponents(complexNumber)
    return ComplexNumbers(realComponent: a + c, imaginaryComponent: b + d)
  }

  func sub(complexNumber: ComplexNumbers) -> ComplexNumbers {
    let (a, b, c, d) = getComponents(complexNumber)
    return ComplexNumbers(realComponent: a - c, imaginaryComponent: b - d)
  }

  func mul(complexNumber: ComplexNumbers) -> ComplexNumbers {
    let (a, b, c, d) = getComponents(complexNumber)
    return ComplexNumbers(realComponent: (a * c - b * d), imaginaryComponent: (b * c + a * d))
  }

  func div(complexNumber: ComplexNumbers) -> ComplexNumbers {
    let (a, b, c, d) = getComponents(complexNumber)
    let denominator = pow(c, 2) + pow(d, 2)
    return ComplexNumbers(
      realComponent: (a * c + b * d) / denominator,
      imaginaryComponent: (b * c - a * d) / denominator)
  }

  func absolute() -> Double {
    return sqrt(pow(realComponent, 2) + pow(imaginaryComponent, 2))
  }

  func conjugate() -> ComplexNumbers {
    return ComplexNumbers(realComponent: realComponent, imaginaryComponent: -imaginaryComponent)
  }

  func exponent() -> ComplexNumbers {
    let expReal = exp(realComponent)
    return ComplexNumbers(
      realComponent: expReal * cos(imaginaryComponent),
      imaginaryComponent: expReal * sin(imaginaryComponent))
  }

  static func == (lhs: ComplexNumbers, rhs: ComplexNumbers) -> Bool {
    let tolerance = 1e-10
    return abs(lhs.realComponent - rhs.realComponent) < tolerance
      && abs(lhs.imaginaryComponent - rhs.imaginaryComponent) < tolerance
  }
}
