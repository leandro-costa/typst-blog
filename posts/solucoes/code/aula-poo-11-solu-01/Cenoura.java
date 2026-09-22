import greenfoot.*;

public class Cenoura extends Alimento
{
    public Cenoura()
    {
        super(4);
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.ORANGE);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
