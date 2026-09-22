import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class CorredorLebre extends Corredor
{
    public CorredorLebre(){
        super(8, "Lebre"); // rápida
        GreenfootImage img = getImage();
        img.setColor(Color.BLUE);
        img.fill();
        setImage(img);
    }
}
