import greenfoot.*;

public class Abobora extends Alimento
{
    public Abobora()
    {
        super(5);
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.ORANGE);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
