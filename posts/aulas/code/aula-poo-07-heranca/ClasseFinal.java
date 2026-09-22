// Classe final
final class ClasseFinal {
    public void metodo() {
        IO.println("Método da classe final");
    }
}   

// Tentativa de estender a classe final
class SubClasse extends ClasseFinal { // Isso causará um erro de compilação
    public void metodo() {
        IO.println("Método da subclasse");
    }       
}
