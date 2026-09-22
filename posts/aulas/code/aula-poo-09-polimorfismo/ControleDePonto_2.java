import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

class ControleDePonto {
    private DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

    public void registraEntrada(Funcionario f) {
        LocalDateTime agora = LocalDateTime.now();
        IO.println("ENTRADA: " + f.getCodigo());
        IO.println("DATA: " + agora.format(dtf));
    }

    public void registraSaida(Funcionario f) {
        LocalDateTime agora = LocalDateTime.now();
        IO.println("SAÍDA: " + f.getCodigo());
        IO.println("DATA: " + agora.format(dtf));
    }
}
