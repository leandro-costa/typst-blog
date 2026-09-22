// ❌ Abordagem extensível apenas com polimorfismo
class ControleDePonto {
    public void registraEntrada(Gerente g) { /* ... */ }
    public void registraSaida(Gerente g) { /* ... */ }
    public void registraEntrada(Telefonista t) { /* ... */ }
    public void registraSaida(Telefonista t) { /* ... */ }
    // 30 cargos = 60 métodos!
}
