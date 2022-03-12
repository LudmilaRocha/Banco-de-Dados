/*Aula Normatização
Data:23/11/2021

Alunos(matricula, nome, {endereço}) apresentando um
elemento multivalorado.
é necessário normalizar apresentando valores em valores invisivel.
PRIMEIRA FORMA NORMAL
1Solução
Alunos(matricula, nome, endereço1, endereço2);
porém restringe somente dois campo como endereço, mas n
é generica

2Solução
Alunos (matricula, nome, endereco) 1 e 3 elemento como chaves primarias
problema voce inserindo mais de um endereço por aluno acaba tendo problema.


3Solução
Alunos(matricula, nome) SOMENTE CHAVE 
Alunos_Endereços(matricula, endereço) CHAVE COMPOSTA.


SEGUNDA FORMA NORMAL
Dependencia funcional total ocorre quando temos uma chabe primaria 
composta e o atributo em questao depende de toda a chave

os atributos que não pertence a chave primaria deve ter 
dependencia inteiramente da chave, ou seja, ter uma dependencia funcional dda 
chave primaria.alter
Ex: AlunosCurso(matricula, idCurso, PontuacaoObtida, local curso)

*/

/*1) Normalize a tabela Aluno(matrícula, nome,{endereços}) de 
modo a atender os requisitos da 1FN.


 Aluno (matrícula, nome);
 Aluno_Endereços(matricula, endereço);


2) Normalize a tabela Pedido(nroPedido, data, nroPeça, 
descrição, qntComprada, valorTotal) de modo a atender os 
requisitos da 2FN.


*/

/*
Data: 30/11/2021
 Forma Normal Boyce Codd - FNBC
  é a 3FN melhorada.
  mais simples porém mais rígida.
  são raros e somente ocorre quando as ocorrencias aparecem juntas:7
  chaves candidatas(pode ser usada como uma chave primária)
  as chaves sejam compostas. ( mais de um atributo, e compartilharem pelo menos um atributo)
  As chaves compostas compartilhem pelo menos um atrito.
  
  precisa esta na 3FN
  
  A --> B,A deve ser primária
  A n pode ser atributo não chave B ser chave primária ou compor a chave primaria
  
  
 Exercicio: 
Considere a seguinte tabela Projeto(idTutor, nomeProjeto, estudante), 
sendo (idTutor, estudante) e (idTutor, nomeProjeto) chaves candidatas. A 
tabela apresenta as seguintes dependências (idTutor, nomeProjeto) → 
estudante, (idTutor, estudante) → nomeProjeto e estudante → 
nomeProjeto. Então, diga se esta tabela atende ou não à FNBC, explique 
sua resposta. Caso não atenda, normalize a tabela de modo que ela atenda 
à FNBC.


*/