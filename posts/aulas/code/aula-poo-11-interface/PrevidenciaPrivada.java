public class PrevidenciaPrivada implements Conta {
    private double valorAcumulado;

    public PrevidenciaPrivada(double valorInicial) {
        this.valorAcumulado = valorInicial;
    }

    @Override
    public void deposita(double valor) {
        this.valorAcumulado += valor;
    }

    @Override
    public void saca(double valor) {
        this.valorAcumulado -= valor;
    }

    public double getValorAcumulado() {
        return valorAcumulado;
    }
}
