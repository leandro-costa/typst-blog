#include <stdio.h>
#include <string.h>

// Dados — soltos, expostos
struct Criatura {
    char nome[50];
    int vida;
};

// Funções — separadas dos dados
void receberDano(struct Criatura *c, int dano) {
    c->vida -= dano;
    if (c->vida < 0) c->vida = 0;
}

void exibirStatus(struct Criatura *c) {
    printf("Nome: %s | Vida: %d\n", c->nome, c->vida);
}

int main() {
    struct Criatura fenix;
    strcpy(fenix.nome, "Fenix");
    fenix.vida = 100;

    exibirStatus(&fenix);
    receberDano(&fenix, 30);
    exibirStatus(&fenix);

    // ⚠️ Qualquer um pode fazer isso:
    fenix.vida = 999999; // Ninguém impediu!
    exibirStatus(&fenix);

    return 0;
}
