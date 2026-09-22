class Livro {
    String titulo;
    Autor autor;
    List<Categoria> categorias;

    Livro(String titulo, Autor autor, List<Categoria> categorias) {
        this.titulo = titulo;
        this.autor = autor;
        this.categorias = categorias;
    }

    void adicionarCategoria(Categoria categoria) {
        if (!categorias.contains(categoria)) {
            categorias.add(categoria);
        }
    }

    List<Categoria> getCategorias() {
        return categorias;
    }
}
