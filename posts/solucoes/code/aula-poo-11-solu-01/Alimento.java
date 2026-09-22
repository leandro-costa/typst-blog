import greenfoot.*;
public abstract class Alimento extends Actor implements Comestivel
{
    private int energia;
    public Alimento(int energia){
        this.energia = energia;
    }
    public int getEnergia(){
        return energia;
    }
    
    public int preparo(){
        return getEnergia();
    }
    
    public void act()
    {
        if(getY()+10 > getWorld().getHeight()){
            getWorld().removeObject(this);
        }else{
            setLocation(getX(), getY()+1);
        }
    }

}
