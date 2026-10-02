import 'package:flutter_test/flutter_test.dart';
import 'package:simulador_frete/frete/calculadora_frete.dart';
import 'package:simulador_frete/model/tipo_frete.dart';

void main() {
  final calculadora = CalculadoraFrete();

  test('frete econômico deve calcular valor pelo peso e pela distância', () {
    // Arrange
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 300.0;

    // Act
    final resultado = calculadora.calcular(
      tipo: TipoFrete.economico,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra,
    );

    // Assert
    expect(resultado.valor, closeTo(22.0, 0.01));
  });

  test('frete expresso deve calcular valor pelo peso e distância', () {
    // Arrange
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 100.0;

    // Act
    final resultado = calculadora.calcular(
      tipo: TipoFrete.expresso,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra,
    );

    // Assert
    expect(resultado.valor, closeTo(48.0, 0.01));
  });

  test('peso zero deve gerar erro', () {
    expect(
      () => calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 0.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
      ),
      throwsArgumentError,
    );
  });

  test('peso negativo deve gerar erro', () {
    expect(
      () => calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: -1.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
      ),
      throwsArgumentError,
    );
  });

  test('distância negativa deve gerar erro', () {
    expect(
      () => calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: -10.0,
        valorCompra: 100.0,
      ),
      throwsArgumentError,
    );
  });

  test('compra de 300 deve possuir frete grátis', () {
    // Arrange
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 300.0;

    // Act
    final resultado = calculadora.calcular(
      tipo: TipoFrete.economico,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra,
    );

    // Assert
    expect(resultado.valor, closeTo(0.0, 0.01));
  });

  test('compra de 350 deve possuir frete grátis no econômico', () {
    // Arrange
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 350.0;

    // Act
    final resultado = calculadora.calcular(
      tipo: TipoFrete.economico,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra,
    );

    // Assert
    expect(resultado.valor, closeTo(0.0, 0.01));
  });

  test('compra de 299.99 deve pagar frete', () {
    // Arrange
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 299.99;

    // Act
    final resultado = calculadora.calcular(
      tipo: TipoFrete.economico,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra,
    );

    // Assert
    expect(resultado.valor, closeTo(22.0, 0.01));
  });
}
