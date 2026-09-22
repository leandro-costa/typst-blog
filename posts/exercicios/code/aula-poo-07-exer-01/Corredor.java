import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Corredor extends Actor
{
    protected int velocidade;
    private String tipo;
    
    public Corredor(int velocidade, String tipo){
        this.velocidade = velocidade;
        this.tipo = tipo;
    }
    
    public String getTipo(){
        return tipo;
    }
    public void act()
    {
        move(this.velocidade);
    }
}