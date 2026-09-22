class Animal {
    private String nome;

    public Animal(String nome) {
        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void mover() {
        IO.println(nome + " se moveu de forma genérica.");
    }
}

class Peixe extends Animal {
    public Peixe(String nome) {
        super(nome);
    }

    @Override
    public void mover() {
        IO.println(getNome() + " nadou 2 metros!");
    }
}

class Anfibio extends Animal {
    public Anfibio(String nome) {
        super(nome);
    }

    @Override
    public void mover() {
        IO.println(getNome() + " pulou 1 metro!");
    }
}

class Passaro extends Animal {
    public Passaro(String nome) {
        super(nome);
    }

    @Override
    public void mover() {
        IO.println(getNome() + " voou 3 metros!");
    }
}
