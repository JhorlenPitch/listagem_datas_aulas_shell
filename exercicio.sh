#!/bin/bash

echo -e "Discentes: Jhorlen Souza Bianor, José Luiz, Marcos\n"

dataatual=$(date +"%d-%m-%Y_%H:%M:%S")
echo -e "Data de hoje: $dataatual\n"

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Questão do exercicio - Grupo 5"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "Todos os semestres a coordenação do sistema de informação exige que o professor repasse a ela, os dias em que será utilizado o laboratório 06, essas datas, baseiam se nos dias da semana em que são ministradas aulas. Como na disciplina exige o uso intensivo do lab, o professor repassa a coordenação todas as datas dos semestres letivos em que são ministradas aulas de T.I, para que possamos usar o lab 100% do tempo disponível. Esse é um processo trabalhoso, que envolve a busca dessas informações em um calendário e as transcrições das datas para o e-mail que é enviado à coordenação. Para minimizar esse problema, o professor quer que vocês desenvolvam um script que, a partir da informação dos dias da semana em que as aulas de TI ocorrem, produza todas as respectivas aulas do ano que será ministrada nossas aulas."

echo -e "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Iniciando o programa"
echo -e "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

sleep 3 && echo -e "\nDigite o nome do arquivo que será armazenado as datas(Ex:datasaulas)"
read nome #recebe o nome do arquivo

echo -e "\nDigite os dias da semana que haverá aula(Ex: segunda quarta)"
read dias #recebe dias que haverá aula

echo -e "\nO que haverá?(Ex: Aula, Evento)"
read evento #recebe evento

echo -e "\nQual sala?(Ex: Sala-00, Lab-00)"
read sala #recebe sala

read -ra dias <<< "$dias" #cria um array com os dias informados

echo -e "\n------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Segue o calendário Atual para usar como referência"                   
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
cal 2023
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

echo -e "\nDigite a data inicial(Ex: dia/mes/ano)"
read inicial #recebe a data inicial

echo -e "\nDigite a data final(Ex: dia/mes/ano)"
read final #recebe a data final

echo -e "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------" | tee -a $nome.txt

echo "Data atual: $dataatual" | tee -a $nome.txt

echo -e "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------" | tee -a $nome.txt 
echo "Lista $evento no(a) $sala entre os dias [$inicial] á [$final] |" | tee -a $nome.txt #mostra o "tema"
echo -e "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------" | tee -a $nome.txt 

nova_inicial=$(date -d "$(echo $inicial | awk -F/ '{print $3"-"$2"-"$1}')" +%Y-%m-%d) #transforma d/m/Y em Y-m-d
nova_final=$(date -d "$(echo $final | awk -F/ '{print $3"-"$2"-"$1}')" +%Y-%m-%d) #transforma d/m/Y em Y-m-d

tdata=$nova_inicial #salva temporario

nova_final2=$(date -d "$nova_final +1 days" +%Y-%m-%d) #add 1 dia a mais no intervalo

while [ "$tdata" != "$nova_final2" ]; do #condição while

    data=$(date -d "$tdata" +"%d/%m/%Y") #garante que sera impressa no formato dia/mes/ano
    tem_comp=0
    
    for dia in "${dias[@]}"; do #verifica se dia escolhido é igual a data
        if [ "$(date -d "$tdata" +"%A")" = "$dia" ]; then
            echo "$(date -d "$tdata" '+%A') - $data - $evento($sala)" | tee -a $nome.txt #Mostra os dias com os repectivos eventos
            tem_comp=1
        fi
    done
   
    tdata=$(date -d "$tdata +1 day" +"%Y-%m-%d") #add a data a mais um
done

echo -e "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------" | tee -a $nome.txt 


echo "O arquivo $nome.txt foi salvo em: $(realpath $nome.txt)"

echo -e "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------" | tee -a $nome.txt 

caminho="$( realpath $nome.txt )"

echo "Abrindo arquivo em 10 segundos"
sleep 10 && xdg-open $caminho


xdg-open /home/jhorlen/datas2.txt
