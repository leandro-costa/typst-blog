import greenfoot.*;

public class Banana extends Alimento
{
    public Banana()
    {
        super(8);
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.YELLOW);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
