# Delivery Manager

- [Introdução](#introdução)

- [Quadro de tarefas do projeto](https://trello.com/b/ZI1ZXOuM/delivery-system)

- [Instruções](#instruções)

- [Ferramentas adicionais](#ferramentas-adicionais)

- [Resumo de Funcionalidades](#resumo-de-funcionalidades)

  - [Gestão de Transportadoras](#gestão-de-transportadoras)

  - [Usuários administradores e de transportadoras](#usuários-administradores-e-de-transportadoras)

  - [Cadastro de Veículos](#cadastro-de-veículos)

  - [Configuração de preços](#configuração-de-preços)

  - [Configuração de prazos](#configuração-de-prazos)

  - [Consulta de preços](#consulta-de-preços)

  - [Criar Ordem de Serviço](#criar-ordem-de-serviço)

  - [Atualizar Ordem de Serviço](#atualizar-ordem-de-serviço)

  - [Consulta de Entrega](#consulta-de-entrega)

## Introdução

Em cumprimento aos requisitos do curso e para avaliação da **Campus Code**, esse projeto foi desenvolvido de forma individual.
O objetivo é avaliar minha evolução durante o treinamento e capacidade de converter os requisitos de negócio em código, criando um projeto que atenda as necessidades e requisitos funcionais de um pequeno sistema de gestão de entregas.

## Instruções

Clone o projeto:

```sh
git clone https://github.com/Jhonny4975/delivery_manager.git
```

Instalação e execução:

```sh
bundle install               => instalar dependencias do projeto (o ruby 3.1.0 deve estar instalado)

bin/rails db:prepare db:seed => preparar e popular banco de dados

bundle exec rspec            => rodar testes

rails server                 => rodar servidor
```

com o servidor rodando acesse [localhost](http://localhost:3000/)

## Ferramentas Adicionais

Decidi adicionar algumas gems para melhorar a qualidade do projeto, tais como:

- [Simplecov](https://github.com/simplecov-ruby/simplecov), para ter um feedback da cobertura de testes.

- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers), para verificar se validações do rails foram definidas e aumentar a cobertura de testes.

- [FactoryBot](https://github.com/thoughtbot/factory_bot/), gera factories para facilitar na criação de testes.

- [Faker](https://github.com/faker-ruby/faker), para gerar dados aleatórios, evitando que os testes funcionem apenas com dados fixos.

- [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug), ferramenta de debug.

- [Rubocop](https://docs.rubocop.org/rubocop/1.29/index.html), é o linter mais utilizado para linguagem Ruby. Basicamente ele faz uma análise `estática` de código Ruby, baseado em um guia de estilo adotado pela comunidade. Também possui uma coleção de cops (tipo de policiais) para verificar e garantir otimizações no código em diversas frentes, como por exemplo: desempenho, estilo, layout, etc.

## Resumo de Funcionalidades

### **Gestão de Transportadoras**

Um administrador do sistema deve ser capaz de cadastrar novas transportadoras informando nome fantasia, razão social, domínio dos e-mails (exemplo: minhatransportadora.com.br), CNPJ e endereço para faturamento. Uma transportadora irá receber ordens de serviço para realizar entregas. Para isto é preciso que a transportadora possua uma tabela de preços e prazos configurados.

Uma transportadora pode ser desativada por um administrador do sistema. Neste caso, os usuários da transportadora seguem com acesso à plataforma, mas a transportadora não é mais considerada em novas consultas de preços e, consequentemente, não deve receber novas ordens de serviço.

- [ ] Concluido?

### **Usuários administradores e de transportadoras**

O acesso ao sistema é realizado através de um e-mail e uma senha e existem dois tipos de usuários: administradores e usuários de transportadoras. Administradores devem ser usuários com e-mail do domínio @sistemadefrete.com.br.

O usuário de uma transportadora deve ser capaz de acessar somente os dados da sua empresa. Ao criar uma conta no sistema, o sistema deve vincular automaticamente um novo usuário com sua transportadora através do domínio do e-mail informado pelo usuário.

- [x] Concluido?

### **Cadastro de Veículos**

Um usuário da transportadora deve ser capaz de cadastrar os veículos utilizados em suas entregas. Cada cadastro deve armazenar a placa de identificação, a marca e o modelo do veículo, o ano de fabricação e a capacidade máxima de carga (peso).

- [ ] Concluido?

### **Configuração de preços**

Cada transportadora deve fazer sua configuração de preços de acordo com as dimensões, peso e distância em km da entrega. Os preços devem considerar o volume em metros cúbicos e o peso do produto e devem ser cadastrados em intervalos. Por exemplo:

| Metros cúbicos | Peso            | Valor por km |
|:-------------- |:---------------:| ------------:|
| 0,001 a 0,500  | 0 a 10kg        | R$ 0,50      |
| 0,001 a 0,500  | 10 a 30 kg      | R$ 0,80      |
| 0,001 a 0,500  | Acima de 30kg   | R$ 1,00      |
| 0,501 a 1,000  | 0 a 10kg        | R$ 0,75      |

E assim em diante.

Além da configuração de preço de acordo com a tabela acima, a transportadora pode determinar um valor mínimo de cobrança de frete baseado exclusivamente na distância percorrida. Ou seja, durante o processo de cálculo de frete deve ser validado o valor mínimo de acordo com a quilometragem, evitando prejuízos.

- [ ] Concluido?

### **Configuração de prazos**

Cada transportadora deve fazer sua configuração de prazos de entrega de acordo com a distância entre a origem e o destino. O prazo pode ser calculado como um fator de dias úteis a partir da distância. O cadastro pode ser feito a partir de intervalos de distância, por exemplo: para entregas de 0 a 100km, o prazo é de 2 dias úteis; de 101km a 300km, o prazo é de 5 dias úteis etc.

- [ ] Concluido?

### **Consulta de preços**

A aplicação deve permitir aos administradores a realização de consultas de preço de frete. Para isso deverão ser informados: as dimensões do item a ser transportado, o peso e a distância a ser percorrida. Com estas informações deve ser feito o cálculo do frete e retornar todos as transportadoras com suas respectivas taxas de entrega e prazos.

Todas as transportadoras ativas devem ser consideradas, desde que possuam preço configurado que atenda as dimensões e a distância do pedido.

O resultado de uma consulta de preços deve ser armazenado para consultas futuras.

- [ ] Concluido?

### **Criar Ordem de Serviço**

Um administrador deve ser capaz de cadastrar uma nova ordem de serviço para uma transportadora. Devem ser informados os dados para retirada do produto (endereço completo, código identificador do produto a ser retirado, dimensões e peso) e as informações para entrega como endereço completo e dados do destinatário.

Uma ordem de serviço recém criada é considerada "pendente de aceite" pela transportadora. Toda ordem de serviço deve possuir um código identificador único gerado automaticamente. O código deve possuir 15 caracteres alfanuméricos e será utilizado para o rastreamento da entrega.

- [ ] Concluido?

### **Atualizar Ordem de Serviço**

Usuários da transportadora devem ver todos os pedidos encaminhados para a sua transportadora. Uma ordem de serviço pendente de aceite deve ser aprovada ou reprovada. Ao aprovar um pedido, o usuário deve vincular um veículo da transportadora à ordem de serviço.

Ordens de serviço aprovadas devem receber atualizações de rota. Cada atualização de rota deve conter uma data e hora, além de indicar uma coordenada geográfica de posição do caminhão responsável pela entrega. Ao fim da rota, a ordem de serviço deve ser atualizada como o status "finalizado".

- [ ] Concluido?

### **Consulta de Entrega**

Uma pessoa não autenticada deve ser capaz de consultar o status de uma entrega informando o código de rastreamento da entrega. Na página de resultado devem ser exibidos o endereço de saída, o endereço de entrega e todas as atualizações de trajeto existentes.

- [ ] Concluido?
