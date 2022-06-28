
import wollok.game.*

object juego{
	
	method pantallaInicial(){
	  game.width(17)
	  game.height(12)
	  game.boardGround("pasteleriaFinal.jpg")
	  game.addVisual(pantallaInicial)
	  keyboard.s().onPressDo{self.iniciar()}
	}
	
	method iniciar(){
	  game.clear()
	  game.width(17)
	  game.height(12)
	  game.cellSize(50)
	  game.boardGround("pasteleriaFinal.jpg")
	  game.title("CatGame")
	  game.addVisualCharacter(gato)
	  game.addVisual(pizza)
	  game.addVisual(pez)
	  game.addVisual(leche)
	  game.addVisual(hamburguesa)
	  game.addVisual(puntaje)
	  keyboard.left().onPressDo{gato.moverIzquierda()}
	  keyboard.right().onPressDo{gato.moverDerecha()}
	  game.onCollideDo(gato,{comida => gato.comer(comida)})
	
	  pizza.iniciar()
	  pez.iniciar()
	  leche.iniciar()
	  hamburguesa.iniciar()
	 }
	
	method ganaste(){
		game.clear()
		game.addVisual(pantallaGanaste)
	}
	
	method gameOver(){
		game.clear()
		game.addVisual(pantallaGameOver)
	}
	
}

object pantallaInicial{
	method position() = game.at(0,0)
	method image()="pasteleriaFinalInicio.jpg"	
}

object pantallaGameOver{
	method position() = game.at(0,0)
	method image()="pasteleriaGO.jpg"
}
	
object pantallaGanaste{
	method position() = game.at(0,0)
	method image()="pasteleriaGanaste.jpg"
}


object gatos{
	
	method tipo(puntos){
			if(puntos>200){
			return "gatoJugando.png"
		}else{
			if(puntos<200 and puntos>=0){
				return "aburrido.png"
			}else{
				return "dolor.png" 
			}
		}
	}
}

object gato{
	
	var position = game.at(0,0)
	method image(){
		return gatos.tipo(puntaje.puntosTotales())
	}
	
	method moverDerecha(){
		self.derecha()
	}
	
	method moverIzquierda(){
		self.izquierda()
	}
	
	method derecha() {
		position = position.right(0.5)
	}
	
	method izquierda() {
		position = position.left(-0.5)
	} 
	
	method position(){
		
		if (position.x()<16){
			return position
		}else{
			return game.at(15,0)
		}
		
	} 
	
	method position(nueva){
		position=nueva
	}
	
	method comer(comida){
		
		const frases=["que rico!","delicioso!","que sabroso!"]
		game.say(self,frases.anyOne())
		puntaje.sumarPuntos(comida)
	}
	
}	


object puntaje{
	var puntos = 0
	method image()="estrella.png"
	method position() = game.at(13, 10)
	method sumarPuntos(comida){
		puntos = puntos + comida.valor()
	}
	method puntosTotales(){
		return puntos
	}
	method text() = puntos.toString()
}

class Comida{
	
	var property valor
	var property velocidad
	var property  x
	var position=self.posicionInicial()
	
	method valor() = valor
	
	method posicionInicial()=game.at(x,game.height()-1)
	
	method position(){
		return position
	}
	
	method position(nueva){	
		position=nueva
	}
	 
	method variarVelocidad(){
	velocidad=velocidad+0.00005
	}

	method velocidad(){
		return velocidad
	}
	
	method velocidad(nueva){
		velocidad=nueva
	}
	
	method iniciar(){
		position = self.posicionInicial()
		game.onTick(velocidad,"moverAlimentos",{self.mover()})
	}
	
	method mover(){
		if (-100<puntaje.puntosTotales() && puntaje.puntosTotales()<200) {
		position = position.down(velocidad)
		self.variarVelocidad()
		if (position.y() < 0){
			x=(0..(game.width()-1)).anyOne().roundUp(0)
			position = self.posicionInicial()
			
			}
		}else{
			if ( puntaje.puntosTotales()<0){
				juego.gameOver()
			}else{
				juego.ganaste()
			}
		}
	}
	
}

object pizza inherits Comida(valor=-10,velocidad=0.07,x=((0..(game.width()-1)).anyOne()).roundUp(0)){
	method image() = "comida10.png"
}

object pez inherits Comida(valor=20,velocidad=0.05,x=((0..(game.width()-1)).anyOne()).roundUp(0)){
	method image() = "comida20.png"
}

object leche inherits Comida(valor=50,velocidad=0.03,x=((0..(game.width()-1)).anyOne()).roundUp(0)){
	method image() = "comida50.png"
}

object hamburguesa inherits Comida(valor=-20,velocidad=0.04,x=((0..(game.width()-1)).anyOne()).roundUp(0)){
	method image() = "comida30.png"
}
