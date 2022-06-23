
import wollok.game.*

object juego{
	
	method configurar(){
	
	
	  game.width(17)
	  game.height(12)
	  game.cellSize(50)
	  game.boardGround("pasteleriaFinal.jpg")
	  game.title("Cathambre")
	  game.addVisualCharacter(gato)
	  game.addVisual(pizza)
	  game.addVisual(pez)
	  game.addVisual(puntaje)
	  keyboard.left().onPressDo{gato.moverIzquierda()}
	  keyboard.right().onPressDo{gato.moverDerecha()}
	  //game.onTick(2000, "aparecerComida", {self.aparecerComida()})
	  game.onCollideDo(gato,{comida => gato.comer()})
	}
	
	method iniciar(){
	  pizza.iniciar()
	  pez.iniciar()
	}
	
	
	/* 
	method aparecerComida(){
		
		const vel=[100,200,300].anyOne()
		const val=[10,20,50].anyOne()
		
		//x=(0..game.width()-1).anyOne()
		game.addVisual(
			new Comida(
			x=(0..game.width()-1).anyOne(),
			valor=val,
			velocidad=vel
			)
		)
	}	
	*/
}	



object gato{
	
	var position = game.at(3,0)
	method image()="aburrido.png"
	
	
	method moverDerecha(){
		self.derecha()
	}
	
	method moverIzquierda(){
		self.izquierda()
	}
	
	method derecha() {
		position = position.right(1)
	}
	
	method izquierda() {
		position = position.left(1)
	} 
	
	method position(){
		return position
	} 
	
	method position(nueva){
		position=nueva
	}
	
	method comer(){
		game.say(self,"Que rico")
		puntaje.sumarPuntos()
	}
}	


object puntaje{
	var puntos = 0
	method image()="estrella.png"
	method position() = game.at(13, 10)
	method sumarPuntos(){
		puntos = puntos + 50
	}
	method puntosTotales(){
		return puntos
	}
	method text() = puntos.toString()
}

class Comida{
	
	var property valor
	var property velocidad
	var x
	var position=self.posicionInicial()
	
	//method image() = "comida"+valor+".png"
	
	
	method posicionInicial()=game.at(x,game.height()-1)
	
	
	method position(){
		return position
	}
	
	method position(nueva){	
		position=nueva
	}
	 
	method variarVelocidad(){
	velocidad=velocidad+50.randomUpTo(300)
	}
	
	method velocidad(){
		return velocidad
	}
	
	method velocidad(nueva){
		velocidad=nueva
	}
	
	method iniciar(){
		position = self.posicionInicial()
		game.onTick(velocidad,"moverPizza",{self.mover()})
	}
	
	method mover(){
		position = position.down(1)
		if (position.y() == -1){
			x=(0..game.width()-1).anyOne()
			position = self.posicionInicial()
			}
	}
	

}

object armarComidas{
	
}

object pizza inherits Comida(valor=10,velocidad=[50,100,150].anyOne(),x=(0..game.width()-1).anyOne()){
	method image() = "comida10.png"
}

object pez inherits Comida(valor=20,velocidad=[50,100,150].anyOne(),x=(0..game.width()-1).anyOne()){
	method image() = "comida20.png"
}


/* 
object pizza{
	
	var velocidad=150
	var position=self.posicionInicial()
	
	method image() = "pizza.png"
	
	
	method posicionInicial()=game.at(2,game.height()-1)
	
	method variarVelocidad(){
		velocidad=velocidad+50.randomUpTo(300)
	}
	
	method velocidad(){
		return velocidad
	}
	
	method velocidad(nueva){
		velocidad=nueva
	}
	
	method iniciar(){
		position = self.posicionInicial()
		game.onTick(velocidad,"moverPizza",{self.mover()})
	}
	
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
		
} 
 */