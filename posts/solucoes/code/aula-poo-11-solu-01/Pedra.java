import greenfoot.*;

// Experimento: Pedra NÃO implementa Comestivel — não assina o pacto.
// isTouching(Comestivel.class) nunca detecta uma Pedra, mesmo que ela
// caia junto com os outros alimentos e o Personagem passe bem em cima dela.
public class Pedra extends Actor
{
    public Pedra()
    {
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.GRAY);
        img.fillRect(0, 0, 20, 20);
        setImage(img);
    }

    public void act()
    {
        if (getY() + 10 > getWorld().getHeight()) {
            getWorld().removeObject(this);
        } else {
            setLocation(getX(), getY() + 1);
        }
    }
}
