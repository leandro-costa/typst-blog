import greenfoot.*;

public class Uva extends Alimento
{
    public Uva()
    {
        super(6);
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.MAGENTA);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
