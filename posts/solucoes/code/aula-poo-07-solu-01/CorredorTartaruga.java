import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class CorredorTartaruga extends Corredor
{
    public CorredorTartaruga(){
        super(2, "Tartaruga"); // lenta
        GreenfootImage img = getImage();
        img.setColor(Color.GREEN);
        img.fill();
        setImage(img);
    }
}
