import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public abstract class Alimento extends Actor
{
    private int energia;

    public Alimento(int energia, Color cor)
    {
        this.energia = energia;
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(cor);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }

    public int getEnergia()
    {
        return energia;
    }

    public abstract void preparar();

    // Experimento: a linha abaixo NÃO compila, porque Alimento é abstrata.
    // Alimento a = new Alimento(10, Color.WHITE);
}
