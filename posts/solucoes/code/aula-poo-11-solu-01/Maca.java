import greenfoot.*;

public class Maca extends Alimento
{
    public Maca()
    {
        super(10);
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.RED);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
