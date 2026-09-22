import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class MundoCorrida extends World
{
    public MundoCorrida()
    {
        super(600, 300, 1);

        desenharPista();

        addObject(new CorredorTartaruga(), 20, 60);
        addObject(new CorredorGato(), 20, 150);
        addObject(new CorredorLebre(), 20, 240);

        addObject(new Chegada(), 580, 150);
    }

    private void desenharPista()
    {
        GreenfootImage fundo = getBackground();
        fundo.setColor(Color.WHITE);
        fundo.fill();
        fundo.setColor(Color.BLACK);
        fundo.drawLine(0, 105, 600, 105);
        fundo.drawLine(0, 195, 600, 195);
        fundo.drawLine(580, 0, 580, 300);
    }
}
