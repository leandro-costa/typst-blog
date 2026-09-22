// Classe selada
sealed class ClasseSelada permits SubClasse1, SubClasse2 {
    public void metodo() {
        IO.println("Método da classe selada");
    }
}   
// Subclasse permitida
final class SubClasse1 extends ClasseSelada {
    public void metodo() {
        IO.println("Método da SubClasse1");
    }
}
// Outra subclasse permitida
final class SubClasse2 extends ClasseSelada {
    public void metodo() {
        IO.println("Método da SubClasse2");
    }
}   
// Tentativa de estender a classe selada por uma classe não permitida
class SubClasseNaoPermitida extends ClasseSelada { // Isso causará um erro de compilação
    public void metodo() {
        IO.println("Método da SubClasseNaoPermitida");
    }
}
