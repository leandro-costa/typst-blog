class GeradorDeRelatorio {
    public void adiciona(EmpregadoDaFaculdade f) {
        IO.println(f.getInfo());
        IO.println("Gastos: " + f.getGastos());
    }
}
