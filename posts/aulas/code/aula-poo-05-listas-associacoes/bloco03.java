@Override
boolean equals(Object obj) {
    if (this == obj) return true;
    if (!(obj instanceof Aluno)) return false;
    Aluno outro = (Aluno) obj;
    return this.matricula.equals(outro.matricula);
}
