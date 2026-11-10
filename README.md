# 🖥️ Provisionamento Automatizado de VMs no GCP
Este repositório utiliza **Terraform** e **GitHub Actions** para provisionar instâncias de VM no Google Cloud Platform (GCP) de forma rápida, segura e com ciclo de vida automatizado (auto-deleção).

## 📽️ Passo a Passo em Vídeo
🔗 Disponível em: [Vídeo Tutorial](https://drive.google.com/file/d/1oN9LvpKarB39wvBioeRo-pGYF5sodf74/view?usp=sharing)

## 📋 Pré-requisitos
* Estar logado no GitHub com uma conta que tenha acesso ao repositório.
* Possuir a sua conta **Gmail/Google Workspace autorizada** no projeto GCP SB100 para conseguir acessar a máquina virtual.

## 🛠️ Passo a Passo para Executar
### 1. Acessar o Workflow
1. No seu repositório do GitHub, clique na aba **Actions**.
2. Na barra lateral esquerda, selecione o workflow **"Provisionar Maquina GCP"**.
3. Clique no botão **Run workflow** (Executar workflow).

### 2. Preencher as Informações (Inputs)
Preencha o formulário que aparecerá na tela com os seguintes dados:
* **Nome da sua Squad:** Identificação da sua equipe seguindo o padrão `squad-x` (ex: `squad-4`, `squad-2`).
* **Tipo de Máquina:** Escolha o hardware desejado, priorize `c4-standard-8` para melhor perfomance (ex: `e2-medium`, `n2-standard-4`, `c4-standard-8`).
* **Tempo máximo de execução (em segundos):** O tempo que a máquina ficará ligada antes de ser excluída automaticamente pelo GCP (ex: `3600` para 1 hora).

Clique no botão verde **Run workflow** para iniciar.

### 3. Aguardar o Status de Sucesso
* Acompanhe o progresso da execução na lista de actions.
* Assim que o status ficar **verde (Success)**, o provisionamento foi concluído e a máquina (junto com o Docker e o Ops Agent) está pronta para uso.

### 4. Acessar a VM
Abra os detalhes da execução concluída e role até a seção de **Job Summary** (Sumário). Lá você encontrará:
* **Previsão de exclusão automática** no Horário de Brasília.
* **Link Direto (Um clique):** Basta clicar em **[Abrir SSH no Browser]**. 
  > ⚠️ *Nota: Certifique-se de estar logado no navegador com a mesma conta **Gmail autorizada** no projeto GCP.*
