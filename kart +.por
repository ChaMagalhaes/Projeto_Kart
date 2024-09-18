programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Tipos --> t
	inclua biblioteca Texto --> tx

	real precoPista = 0.00
	
	funcao inicio()
	{
        	menu()
	}

	funcao menu(){
		cadeia opcaoMenu = ""
		logico repetir = verdadeiro
		inteiro indice = 0
		cadeia karts[15][4]
	             
	    	faca{
	    		escreva("DIGITE UM NÚMERO\n" +
			"-----------------------\n" +
			"01- Cadastrar um Kart\n" +
			"02- Listar Karts Disponíveis\n" +
			"03- Listar Karts Locados\n" + 
			"04- Alugar um Kart\n" +
			"05- Devolver um Kart\n" +
			"06- Kart que mais gerou ganhos\n" +
			"07- Receita e lucro do dia, considerando karts locados\n" +
			"08- locação de circuito\n" + 
			"09- Atualizar dia\n" + 
			"10- Sair do programa\n" +
			"\n> ")
			leia(opcaoMenu)
	        
			aguardeExecucaoLimpa(2)
	        
			inteiro opcaoValido = verificarOpcao(opcaoMenu, 1, 10)
	
			 escolha(opcaoValido){
	        
				caso 1:
					cadastrarUmKart(indice, karts)
				pare
	
				caso 2:
					listarKartsDisponiveis(karts)
					aguardeExecucaoLimpa(5)
				pare
	
				caso 3:
					listaKartslocados(karts)
					aguardeExecucaoLimpa(5)
				pare
	
				caso 4:
					alugarUmKart(karts)
				pare
	
				caso 5:
					devolverUmKart(karts)
				pare
	
				caso 6:
					kartMaisGerouGanhos(karts)
				pare
	
				caso 7:
					receitaLucroDia(karts)
				pare
	
				caso 8:
					locacaoCircuito(precoPista,karts)
				pare
	
				caso 9:
					atualizarDia(karts)
				pare
	
				caso 10:
					escreva("Saindo do programa")
					repetir = falso
				pare
	
				caso contrario:
					escreva("Opção inválida, tente novamente.")
	        }    
		} enquanto(repetir)
	}

	funcao inteiro verificarOpcao(cadeia x, inteiro a, inteiro b){ // OK
		inteiro opcaoMenuInteiro = 0
		// verifica se texto e numero
		se(t.cadeia_e_inteiro(x, 10) == verdadeiro){
			opcaoMenuInteiro = t.cadeia_para_inteiro(x, 10)
			//Verifica se esta entre a e b
			se(opcaoMenuInteiro >= a e opcaoMenuInteiro <= b){
				retorne opcaoMenuInteiro
			}senao{
				escreva("O número que você digitou não está nas opções.")
			}
		}senao{
			se(tx.numero_caracteres(x) > 10 e t.cadeia_e_inteiro(x, 10)){ //verifica se o tamanho de caracter e mais que 10 casas ou se e letras
				escreva("Você digitou um número que excede o limite de caracteres permitido para este campo.")
			}senao{
				escreva("Você digitou letras ou números com letras.")
			}
		}	
		aguardeExecucaoLimpa(2)
		retorne -1
	}

	funcao aguardeExecucaoLimpa(inteiro multiplicador){ // OK
		u.aguarde(1000 * multiplicador)
		limpa()
	}

	funcao cadastrarUmKart(inteiro &i, cadeia &k[][]){ // OK 
		logico repete
		real opcaoVerificado
		
		se(i > 15){
			escreva("O número máximo de karts foi cadastrado")
			aguardeExecucaoLimpa(3)
		}senao{
			escreva("Cadastrar um kart\n\n")
			escreva("Qual modelo do kart? " + i +"\n\n> ")
			leia(k[i][0])
			aguardeExecucaoLimpa(2)
			
			faca{
				escreva("O valor da locação do kart\n\n> R$ ")
				leia(k[i][1])

				se(t.cadeia_e_real(k[i][1]) == verdadeiro  ou t.cadeia_e_inteiro(k[i][1], 10) == verdadeiro e t.cadeia_para_real(k[i][1]) >= 0){
					k[i][1] = k[i][1]
					repete = falso
				}senao{
					escreva("Você não digitou um valor valido.")
					repete = verdadeiro
				}
				aguardeExecucaoLimpa(2)
			}enquanto(repete != falso)
			
			k[i][2] = "0"
			k[i][3] = "falso"
			i++	
		}
	}

	funcao listarKartsDisponiveis(cadeia k[][]){ // OK
		logico kartDisponivel = falso
		escreva("Lista de Karts Disponíveis:\n\n")
		// Percorre a matriz para encontrar karts disponíveis
		para(inteiro linha = 0; linha < 15; linha++){
			// Verifica se o kart está cadastrado e não está locado
			se(k[linha][3] == "falso"){
				escreva("Kart ", linha, ":\n")
				escreva("Modelo: ", k[linha][0], "\n")
				escreva("Valor: R$ ", k[linha][1], "\n")
				escreva("Quantidade de Vezes Locado: ", k[linha][2], "\n")
				escreva("Disponível para locação\n")
				escreva("-----------------------------\n")
				kartDisponivel = verdadeiro
			}
		}
		// Se não encontrou nenhum kart disponível
		se(kartDisponivel == falso){
			escreva("Nenhum kart disponível no momento.\n")
		}
	}
		
	funcao listaKartslocados(cadeia k[][]){ // OK
		logico kartLocado = falso
		escreva("Karts Locados são:\n\n")
		// Percorrer a matriz de karts para encontrar e listar os karts locados
		para(inteiro linha = 0; linha < 15; linha++){
			se(k[linha][3] == "verdadeiro"){
				escreva("Kart ",linha, "\n")
				escreva("Modelo: ", k[linha][0], "\n")
				escreva("Valor: R$ ", k[linha][1], "\n")
				escreva("Quantidade de Vezes Locado: ", k[linha][2], "\n")
				escreva("Kars locado\n")
				escreva("-----------------------------\n")
				kartLocado = verdadeiro
			}
		}
		
		// Se nenhum kart estiver locado, exibir uma mensagem informando
		se(kartLocado == falso){
			escreva("Nenhum kart está locado no momento.\n")
		}
	}

	funcao alugarUmKart(cadeia k[][]){ // ok / analise
		cadeia escolhaKart
		logico kartEncontrado = falso, repetir = falso

		faca{
			repetir = verdadeiro
			escreva("Aluguel de Kart:\n\n")
			
			// Listar os karts disponíveis
			listarKartsDisponiveis(k)
			
			// Solicitar o kart que quer alugar
			escreva("\n\nDigite o número do kart que você deseja alugar:\n> ")
			leia(escolhaKart)

			se(verificarOpcao(escolhaKart,0,15) != -1){
				// Verificar se o kart escolhido está disponível
				para(inteiro linha = 0; linha < 15; linha++){
					se(linha == t.cadeia_para_inteiro(escolhaKart, 10) e k[linha][3] == "falso"){
						// Marcar o kart como locado
						k[linha][3] = "verdadeiro"
						// Incrementar a quantidade de vezes que o kart foi locado
						k[linha][2] = t.inteiro_para_cadeia(t.cadeia_para_inteiro(k[linha][2], 10) + 1, 10)
						escreva("O Kart ", k[linha][0], " foi locado com sucesso!\n")
						kartEncontrado = verdadeiro
						pare //quando verificar o kart se esta disponivel força a parada do laço de repetição
					}
				}
				repetir = falso
			}senao{
				escreva("Você digitou um número invalido ou letras.")
			}
			
			// Se o kart não foi encontrado ou não estava disponível
			se(kartEncontrado == falso){
				escreva("Kart não encontrado ou não está disponível para locação.\n")
			}
			aguardeExecucaoLimpa(3)
		}enquanto(repetir != falso)
	}

	funcao devolverUmKart(cadeia k[][]){ // ok / analise
		cadeia escolhaKart
		logico kartEncontrado = falso, repetir = falso
	
		faca{
			repetir = verdadeiro
			escreva("Devolução de Kart:\n\n")
			
			// Listar os karts que estão locados para o usuário escolher
			listaKartslocados(k)
			
			// Solicitar ao usuário o número do kart que ele deseja devolver
			escreva("\n\nDigite o número do kart que você deseja devolver:\n> ")
			leia(escolhaKart)
			
			se(verificarOpcao(escolhaKart,0,15) != -1){
				// Verificar se o kart escolhido está realmente locado
				para(inteiro linha = 0; linha < 15; linha++){
					se(linha == t.cadeia_para_inteiro(escolhaKart, 10) e k[linha][3] == "verdadeiro"){
						// Marcar o kart como disponível
						k[linha][3] = "falso"
						escreva("O Kart ", k[linha][0], " foi devolvido com sucesso!\n")
						kartEncontrado = verdadeiro
						pare
					}
				}
				repetir = falso
			}senao{
				escreva("Você digitou um número invalido ou digitou alguma letra.")
			}
			
			// Se o kart não foi encontrado ou não estava locado
			se(kartEncontrado == falso){
				escreva("Kart não encontrado ou não está locado.\n")
			}
		}enquanto(repetir != falso)
		aguardeExecucaoLimpa(3)
	}

	funcao kartMaisGerouGanhos(cadeia k[][]){
		inteiro indiceKartMaisRentavel = -1 // - 1 porque o indice de vetor ou matriz começa do 0
		real maiorReceita = 0.0
		real receitaAtual = 0.0
		
		// Percorrer a matriz de karts para calcular os ganhos de cada um
		para(inteiro linha = 0; linha < 15; linha++){
			se(k[linha][0] != ""){ //verifica se e diferente de vazio
				// Calcular receita atual do kart
				receitaAtual = t.cadeia_para_real(k[linha][1]) * t.cadeia_para_inteiro(k[linha][2], 10) // valor da locação x quantidade de locação do kart
				
				// Verificar se a receita atual é maior que a maior receita encontrada até agora
				se(receitaAtual > maiorReceita){
					maiorReceita = receitaAtual
					indiceKartMaisRentavel = linha
				}
			}
		}
		
		// Exibir o kart que mais gerou ganhos
		se(indiceKartMaisRentavel != -1){
			escreva("O Kart que mais gerou ganhos é:\n\n")
			escreva("Kart Número: ", k[indiceKartMaisRentavel][0], "\n")
			escreva("Modelo: ", k[indiceKartMaisRentavel][1], "\n")
			escreva("Valor de Locação: ", k[indiceKartMaisRentavel][2], "\n")
			escreva("Quantidade de Vezes Locado: ", k[indiceKartMaisRentavel][3], "\n")
			escreva("Receita Gerada: ", maiorReceita, "\n")
		} senao {
			escreva("Nenhum kart gerou receita ainda.\n")
		}
		
		aguardeExecucaoLimpa(5)
	}

	funcao receitaLucroDia(cadeia k[][]){ // OK 
		real receitaTotal = 0.0
		real lucroTotal = 0.0
		real valorLocacao = 0.0
		inteiro quantidadeLocado = 0
		
		para(inteiro i = 0; i < 15; i++){
			//vai percorrer apenas a linha na coluna 3 verificando se os card esta locado
			se(k[i][3] == "verdadeiro"){
				// Calcular a receita gerada por esse kart
				receitaTotal += t.cadeia_para_real(k[i][1]) * t.cadeia_para_inteiro(k[i][2], 10)
			}
		}
		// Calcular o lucro total (30% da receita total)
		lucroTotal = (receitaTotal + precoPista) * 0.30
		
		// Exibir a receita e o lucro do dia
		escreva("Receita Total do Dia: R$ ", receitaTotal, "\n")
		escreva("Lucro Total do Dia: 30% R$ ", lucroTotal, "\n")
		
		aguardeExecucaoLimpa(3)
	}

	funcao locacaoCircuito(real &pista, cadeia k[][]){
		cadeia valorLocacaoCircuito
    		real receitaAdicional = 0.0
		logico repete

		faca{
			repete = verdadeiro
			escreva("Digite o valor de locação do circuito:\n> R$ ")
	    		leia(valorLocacaoCircuito)

			se(t.cadeia_e_real(valorLocacaoCircuito) == verdadeiro  ou t.cadeia_e_inteiro(valorLocacaoCircuito, 10) == verdadeiro e t.cadeia_para_real(valorLocacaoCircuito) >= 0){
	        		pista = t.cadeia_para_real(valorLocacaoCircuito) * 0.70
	        		// Exibir informações sobre a locação do circuito
				escreva("O circuito foi locado com sucesso.\n")
				escreva("Valor de locação do circuito: ", valorLocacaoCircuito, "\n")
				escreva("Receita adicional devido à locação do circuito: \n\n")
				receitaLucroDia(k)
				repete = falso
	   	 	}senao{
	   	 		escreva("Valor de locação inválido. Deve ser um valor positivo.\n")
	   	 	}
	   	 	aguardeExecucaoLimpa(5)
		}enquanto(repete != falso)
	}

	funcao atualizarDia(cadeia k[][]){
		logico repetir, kartEncontrado = falso
		cadeia escolhaKart, novoValor
		
		para(inteiro i = 0; i < 15; i++){
			se(k[i][3] == "verdadeiro"){
				k[i][2] = "0"
				k[i][3] = "falso" 
			}
		}

		listarKartsDisponiveis(k)
		faca{
			repetir = verdadeiro
			escreva("\n\nEscolha o kart para novo aluguelt:\n\n")
		
			escreva("\nDigite o número do kart que você deseja trocar o valor:\n> ")
			leia(escolhaKart)

			se(verificarOpcao(escolhaKart,0,15) != -1){
				// Verificar se o kart escolhido está disponível
				para(inteiro linha = 0; linha < 15; linha++){
					se(linha == t.cadeia_para_inteiro(escolhaKart, 10) e k[linha][3] == "falso"){
						escreva("\n\nKart modelo ", k[linha][0], ", preço atual ", k[linha][1], "\n")
						escreva("Digite o novo valor: R$ ")
						leia(novoValor)
						
						se(t.cadeia_e_real(novoValor) == verdadeiro  ou t.cadeia_e_inteiro(novoValor, 10) e t.cadeia_para_real(novoValor) >= 0){
							repetir = falso
						}senao{
							escreva("Valor invalido.")
							repetir = verdadeiro
						}
						kartEncontrado = verdadeiro
						pare
					}
				}
				
			}senao{
				escreva("Você digitou um número invalido ou digitou alguma letra.")
				repetir = falso
			}
			
			se(kartEncontrado == falso){
				escreva("Kart não foi cadastrado ou não está disponível para locação.\n")
				repetir = falso
			}
			aguardeExecucaoLimpa(3)
		}enquanto(repetir != falso)
		
		escreva("O dia foi atualizado com sucesso.\n")

		aguardeExecucaoLimpa(3)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4567; 
 * @DOBRAMENTO-CODIGO = [90, 112, 117, 150, 194, 301];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
