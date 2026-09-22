import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Personagem extends Actor
{
    public void act()
    {
        mover();
        comer();
    }

    private void mover()
    {
        if (Greenfoot.isKeyDown("left")) setLocation(getX() - 3, getY());
        if (Greenfoot.isKeyDown("right")) setLocation(getX() + 3, getY());
        if (Greenfoot.isKeyDown("up")) setLocation(getX(), getY() - 3);
        if (Greenfoot.isKeyDown("down")) setLocation(getX(), getY() + 3);
    }

    private void comer()
    {
        // Alimento é abstrata: nunca existe um objeto "Alimento puro" no
        // mundo. Ainda assim, isTouching(Alimento.class) detecta qualquer
        // subclasse concreta (Maca, Cenoura, Bolo...) — o polimorfismo não
        // liga se a classe do tipo passado é abstrata ou não.
        if (isTouching(Alimento.class)) {
            Alimento a = (Alimento) getOneIntersectingObject(Alimento.class);
            a.preparar(); // polimorfismo: cada subclasse prepara do seu jeito
            removeTouching(Alimento.class);
        }
    }
}
