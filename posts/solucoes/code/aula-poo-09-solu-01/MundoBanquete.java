import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class MundoBanquete extends World
{
    public MundoBanquete()
    {
        super(500, 400, 1);
        addObject(new Personagem(), 250, 200);
    }

    public void act()
    {
        if (Greenfoot.getRandomNumber(100) < 5) {
            spawnAlimento();
        }
    }

    private void spawnAlimento()
    {
        int x = Greenfoot.getRandomNumber(getWidth());
        int tipo = Greenfoot.getRandomNumber(9);
        Alimento alimento = switch (tipo) {
            case 0 -> new Maca();
            case 1 -> new Banana();
            case 2 -> new Uva();
            case 3 -> new Cenoura();
            case 4 -> new Brocolis();
            case 5 -> new Tomate();
            case 6 -> new Bolo();
            case 7 -> new Sorvete();
            default -> new Chocolate();
        };
        addObject(alimento, x, 0);
    }
}
