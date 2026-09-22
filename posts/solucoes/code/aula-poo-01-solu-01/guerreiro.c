#include <stdio.h>
#include <string.h>

struct Guerreiro {
    char nome[50];
    int vida;
    int forca;
};

void atacar(struct Guerreiro *atacante, struct Guerreiro *alvo) {
    alvo->vida -= atacante->forca;
    if (alvo->vida < 0) alvo->vida = 0;
}

void exibirStatus(struct Guerreiro *g) {
    printf("%s | Vida: %d | Forca: %d\n", g->nome, g->vida, g->forca);
}

int main() {
    struct Guerreiro conan;
    strcpy(conan.nome, "Conan");
    conan.vida = 100;
    conan.forca = 25;

    struct Guerreiro thorin;
    strcpy(thorin.nome, "Thorin");
    thorin.vida = 100;
    thorin.forca = 20;

    printf("--- Antes do ataque ---\n");
    exibirStatus(&conan);
    exibirStatus(&thorin);

    atacar(&conan, &thorin);

    printf("--- Depois do ataque ---\n");
    exibirStatus(&conan);
    exibirStatus(&thorin);

    return 0;
}
