import greenfoot.*;

public class Tomate extends Alimento
{
    public Tomate()
    {
        super(3);
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.RED);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
