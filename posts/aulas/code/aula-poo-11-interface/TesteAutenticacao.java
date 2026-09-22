public class TesteAutenticacao {
    public static void main(String[] args) {
        AutenticadorDeUsuario autenticador = new AutenticadorDeUsuario();

        Usuario gerente = new Gerente();
        Usuario empresa = new PessoaJuridica();

        autenticador.autentica(gerente);
        autenticador.autentica(empresa);
    }
}
