import Foundation

final class RetoCaso {
	
	// Atributos
	//---										
	private var listaCategorias: [(categoria: String, dinero: Double)] = [("D", 0.0), ("A", 0.0), ("M", 0.0), ("I", 0.0), ("C", 0.0)]
	
	// Métodos
	//---

	// Método que permite que el usuario introduzca información y devuelve una tupla con el nombre de la categoría y el dinero gastado en la misma.
	private func entrada() -> (categoria: String, dinero: Double) {
	
		while true {
		
			if let entradaCategoria = readLine() {
				let entradaDividida = entradaCategoria.components(separatedBy: " ")
				if entradaDividida.count > 1 {
					if let dineroCategoriaEntrada = Double(entradaDividida[1]) {
						if entradaDividida[0] == "D" || entradaDividida[0] == "A" || entradaDividida[0] == "M" || entradaDividida[0] == "I" || entradaDividida[0] == "C" {
							return (entradaDividida[0], dineroCategoriaEntrada)
						} else if entradaDividida[0] == "N" && dineroCategoriaEntrada == 0 {
							return ("N", 0)
						} else {
							print("Error en el formato. Recuerde que debe colocar en primer lugar el código de una categoría (D, A, M, I O C) y, a continuación, la cuantía económica producida por esa categoría a lo largo de la jornada.")
						}
					} else {
						print("Error en el formato. Recuerde que debe colocar en primer lugar el código de una categoría (D, A, M, I O C) y, a continuación, la cuantía económica producida por esa categoría a lo largo de la jornada.")
					}
				} else {
					print("Error en el formato. Recuerde que debe colocar en primer lugar el código de una categoría (D, A, M, I O C) y, a continuación, la cuantía económica producida por esa categoría a lo largo de la jornada.")
				}
			} else {
				print("Error en el formato. Recuerde que debe colocar en primer lugar el código de una categoría (D, A, M, I O C) y, a continuación, la cuantía económica producida por esa categoría a lo largo de la jornada.")
			}
		
		}
	
	}
	
	// Método que almacena en la lista de categorías la tupla que recibe como parámetro
	private func almacenarCategoriaRecogida(entradaTuplaCategoriaDinero: (categoria: String, dinero: Double)) {
	
		for (indice, elemento) in listaCategorias.enumerated() {
		
			if elemento.categoria == entradaTuplaCategoriaDinero.categoria {
				listaCategorias[indice].dinero = entradaTuplaCategoriaDinero.dinero
			} 
		
		}
		
	}

	// Método que devuelve la categoría que más dinero ha generado
	private func categoriaConMasBeneficio() -> String {

		var categoriaMasBeneficiada: (categoria: String, dinero: Double) = ("", 0)

		// Localizar dinero más elevado
		for elemento in listaCategorias {
			if categoriaMasBeneficiada.dinero == 0 && categoriaMasBeneficiada.categoria.isEmpty {
				categoriaMasBeneficiada = elemento
			} else if categoriaMasBeneficiada.dinero < elemento.dinero {
				categoriaMasBeneficiada = elemento
			}
		}

		// Localizar si la categoría más beneficiada identificada antes empata en cuestión de dinero con otra
		for elemento in listaCategorias {
			if categoriaMasBeneficiada != elemento && elemento.dinero > 0 && categoriaMasBeneficiada.dinero == elemento.dinero {
				return "EMPATE"
			}
		}

		// Si no hay empate, devolvemos el nombre de la categoría más beneficiada
		switch categoriaMasBeneficiada.categoria {
			case "D":
				return "DESAYUNOS"
			case "A":
				return "COMIDAS"
			case "M":
				return "MERIENDAS"
			case "I":
				return "CENAS"
			case "C":
				return "COPAS"
			default:
				return "ERROR"
		}

	}

	// Método que devuelve la categoría que menos dinero ha generado
	private func categoriaConMenosBeneficio() -> String {

		var categoriaMenosBeneficiada: (categoria: String, dinero: Double) = ("", 0)

		// Localizar dinero menos elevado
		for elemento in listaCategorias {
			if categoriaMenosBeneficiada.dinero == 0 && categoriaMenosBeneficiada.categoria.isEmpty {
				categoriaMenosBeneficiada = elemento
			} else if categoriaMenosBeneficiada.dinero > elemento.dinero {
				categoriaMenosBeneficiada = elemento
			}
		}

		// Localizar si la categoría menos beneficiada identificada antes empata en cuestión de dinero con otra
		for elemento in listaCategorias {
			if categoriaMenosBeneficiada != elemento && categoriaMenosBeneficiada.dinero == elemento.dinero {
				return "EMPATE"
			}
		}

		// Si no hay empate, devolvemos el nombre de la categoría menos beneficiada
		switch categoriaMenosBeneficiada.categoria {
			case "D":
				return "DESAYUNOS"
			case "A":
				return "COMIDAS"
			case "M":
				return "MERIENDAS"
			case "I":
				return "CENAS"
			case "C":
				return "COPAS"
			default:
				return "ERROR"
		}

	}

	// Método que analiza si la media gastada por los clientes en las comidas supera a la media de ventas del día
	private func superacionMedia() -> String {
		var gastoTotalClientes: Double = 0
		var mediaGastoTotal: Double = 0
		var categoriasIntroducidas: Double = 0
		let gastoComidas: Double = listaCategorias[1].dinero

		for elemento in listaCategorias {
			gastoTotalClientes = gastoTotalClientes + elemento.dinero
			if elemento.dinero > 0 {
				categoriasIntroducidas += 1
			}
		}

		mediaGastoTotal = gastoTotalClientes / categoriasIntroducidas

		return mediaGastoTotal < gastoComidas ? "SI" : "NO"
	}
	
	// Método que aplica la lógica principal del programa
	func casoDescrito() {
		var finPrograma: Bool = false
		while !finPrograma {
			let entradaTuplaCategoriaDinero = entrada()
			switch entradaTuplaCategoriaDinero {
				case (categoria: "N", dinero: 0.0):
					finPrograma = true
					let categoriaMasBeneficiada: String = categoriaConMasBeneficio()
					let categoriaMenosBeneficiada: String = categoriaConMenosBeneficio()
					let seHaSuperadoLaMedia: String = superacionMedia()
					print("\(categoriaMasBeneficiada)#\(categoriaMenosBeneficiada)#\(seHaSuperadoLaMedia)")
				default:
					almacenarCategoriaRecogida(entradaTuplaCategoriaDinero: entradaTuplaCategoriaDinero)
			}
		}
	}

}

// Main
var retoCaso: RetoCaso = RetoCaso()
retoCaso.casoDescrito()
