import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Personagem extends Actor
{
    private int totalComido = 0;

    public void act()
    {
        mover();
        comer();
    }

    private void mover()
    {
        if (Greenfoot.isKeyDown("left")) setLocation(getX() - 3, getY());
        if (Greenfoot.isKeyDown("right")) setLocation(getX() + 3, getY());
        if (Greenfoot.isKeyDown("up")) setLocation(getX(), getY() - 3);
        if (Greenfoot.isKeyDown("down")) setLocation(getX(), getY() + 3);
    }

    private void comer()
    {
        // Detecção por tipo específico: só maçãs são capturadas,
        // mesmo que Banana ou Uva estejam colidindo.
        if (isTouching(Maca.class)) {
            totalComido++;
            removeTouching(Maca.class);
            getWorld().showText("Comidas: " + totalComido, 60, 20);
        }

        // Experimento de polimorfismo (comentado): trocar a linha acima por
        //
        //   if (isTouching(Fruta.class)) {
        //       totalComido++;
        //       removeTouching(Fruta.class);
        //       getWorld().showText("Comidas: " + totalComido, 60, 20);
        //   }
        //
        // passa a detectar QUALQUER fruta (Maca, Banana ou Uva) de uma vez,
        // sem precisar de um `if` para cada subclasse — isso é polimorfismo:
        // isTouching(Fruta.class) aceita qualquer objeto cuja classe real
        // seja Fruta OU QUALQUER SUBCLASSE dela.
    }
}
