import greenfoot.*;

public class Chocolate extends Doce
{
    public Chocolate()
    {
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(new Color(101, 67, 33));
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
