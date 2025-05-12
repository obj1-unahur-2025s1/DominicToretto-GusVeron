object toretto {
  const autos = [ferrari, flechaRubi, intocable]


  method comprarAuto(unAuto) {
    autos.add(unAuto)
  } 

  method autosFueraDeCondicion() {
    return autos.filter( {a => !a.enCondicion()} )
  }

  method autosEnCondiciones() {
    return autos.filter( {a => a.enCondicion()} )
  }

  method mandarAutosFueraDeCondicionAlTaller() {
    taller.recibirAutosDe(self.autosFueraDeCondicion())
  }

  method realizarPruebaDeVelocidad() {
    autos.forEach( {a => a.realizarPrueba()} )
  }

  method venderTodosLosAutos() {
    autos.clear()
  }

  method promedioDeVelocidad() {
    return autos.sum( {a => a.velocidadMaxima()} ) / autos.size()
  }

  method autoMasRapidoDisponible() {
    return self.autosEnCondiciones().max( {a => a.velocidadMaxima()} )
  }

  method hayUnAutoMuyRapido() {
    return self.autoMasRapidoDisponible().velocidadMaxima() > self.promedioDeVelocidad() * 2
  }
}

// Taller
object taller {
  const autosAReparar = []

  method recibirAutosDe(coleccionDeAutos) {
    autosAReparar.addAll(coleccionDeAutos)
  }

  method autosAReparar() = autosAReparar.asList()

  method repararAutos() {
    autosAReparar.forEach( {a => a.repararAuto()} )
    autosAReparar.clear()
  }
}

// Autos
object ferrari {
  var motor = 87


  method motor() = motor

  method repararAuto() {
    motor = 100
  }

  method enCondicion() = motor >= 65

  method velocidadMaxima() = if(motor > 75) 110 + 15 else 110

  method realizarPrueba() {
    motor = 0.max(motor - 30)
  }
}

object flechaRubi {
  var combustible = 100
  var tipoDeCombustible = gasolina
  var color = rojo


  method color() = color

  method combustible() = combustible

  method tipoDeCombustible() = tipoDeCombustible

  method enCondicion() = combustible > self.tipoDeCombustible().minimoDeUso() && color == rojo

  method repararAuto() {
    combustible = combustible * 2
    color = color.siguienteColor()
  }

  method realizarPrueba() {
    combustible = 0.max(combustible - 5)
  
  }
  
  method velocidadMaxima() = tipoDeCombustible.calculoAdicional(combustible)
}

object intocable {
  var enCondiciones = true

  method realizarPrueba() {
    enCondiciones = false
  }
  
  method enCondicion() = enCondiciones 

  method repararAuto() {
    enCondiciones = true
  }

  method velocidadMaxima() = 45
}


// Combustibles
object gasolina {
  method minimoDeUso() {
    return 85
  }

  method calculoAdicional(litros) {
    return (litros * 2) + 10
  }
}

object nafta {
  method minimoDeUso() {
    return 50
  }

  method calculoAdicional(litros) {
    return (litros * 2) - litros * 0.1
  }
}

object nitrogeno {
  method minimoDeUso() {
    return 0
  }

  method calculoAdicional(litros) {
    return (litros * 2) * 10
  }
}

// Colores
object azul {
  method siguienteColor() {
    return verde
  }
}

object verde {
  method siguienteColor() {
    return rojo
  }
}

object rojo {
  method siguienteColor() {
    return azul
  }
}