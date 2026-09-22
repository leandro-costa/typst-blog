import greenfoot.*;  
public class MyWorld extends World
{

    int contador = 0;
    int velocidade = 100;
    public MyWorld()
    {    
        super(1300, 700, 1); 
        //getHeight()
        //getWidth()
        prepare();
    }
    
    private void prepare()
    {
        Personagem personagem = new Personagem();
        addObject(personagem,202,326);
        Banana banana = new Banana();
        addObject(banana,1020,141);
        Maca maca = new Maca();
        addObject(maca,1004,427);
        Banana banana2 = new Banana();
        addObject(banana2,1040,295);
        Abobora abobora = new Abobora();
        addObject(abobora,749,211);
        Bolo bolo = new Bolo();
        addObject(bolo,844,407);
    }
    
    public void act(){
        contador++;
        if(contador % 300 == 0){
            if(velocidade> 20){
                velocidade-=10;    
            }
            
        }
        
        if(contador % velocidade == 0){
            //showText(String.valueOf(contador), 200, 50); 
            int escolha = Greenfoot.getRandomNumber(4);
            Actor a = null; 
            switch (escolha){
                case 0: a = new Abobora();break;
                case 1: a = new Banana();break;
                case 2: a = new Maca();break;
                case 3: a = new Bolo();break;
            }
            int x = Greenfoot.getRandomNumber(getWidth());
            int y = Greenfoot.getRandomNumber(getHeight());
            addObject(a,x,y);
        }
        
    }
}
