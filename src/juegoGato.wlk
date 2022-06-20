
import wollok.game.*

object juego{
	
	method configurar(){
	
	
	  game.width(17)
	  game.height(12)
	  game.cellSize(50)
	  game.boardGround("pasteleriaFinal.jpg")
	  game.title("Cathambre")
	  game.addVisualCharacter(gato)
	  //game.addVisual(pizza)
	  keyboard.left().onPressDo{gato.moverIzquierda()}
	  keyboard.right().onPressDo{gato.moverDerecha()}
	  game.onTick(2000, "aparecerComida", {self.aparecerComida()})
	}
	
	method iniciar(){
	  //pizza.iniciar()	
	}
	
	
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
}


class Comida{
	
	var property valor=10
	var property velocidad=100
	var property x=1
	var position=self.posicionInicial()
	
	method image() = "comida"+valor+".png"
	
	
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
		if (position.y() == -1)
			position = self.posicionInicial()
	}

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