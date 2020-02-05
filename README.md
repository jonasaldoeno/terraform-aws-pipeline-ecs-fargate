# DevOps Challenge - Jonas Soares

## TL;DR

_O desafio consiste em construir uma stack de infraestrutura que provisione um ambiente para rodar uma aplicação backend rest hipotética, com duas réplicas respondendo em um Load Balancer, e uma aplicação frontend estática, ambas respondendo pelo mesmo DNS, porém com contextos distintos._

Ambiente e recursos utilizados:

- AWS Cloud provider Services
  - ALB
  - S3
  - ECS
  - ECR
  - Network Infrastructure
  - Pipeline
  - CodeCommit
- Terraform
- Github
- Docker

### Pre-requisitos:

- [Terraform](https://www.terraform.io/downloads.html) 0.12 ou superior;
- [git](https://git-scm.com/downloads);
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv1.html)
- Repositorio GIT com o nome "**_catalogo_**" no CodeCommit dentro da sua conta AWS com o [seguinte conteudo](https://github.com/jonasaldoeno/catalogo);
- Repositorio GIT com o nome "**_frontend_**" no CodeCommit dentro da sua conta AWS com o [seguinte conteudo](https://github.com/jonasaldoeno/frontend);

### Configurando acesso AWS

Configure as credencias de acesso AWS com permissao de administrador nos itens mencionados anteriormente.

_Informacoes necessarias_:

| Item                  | Descrição                                           |
| --------------------- | --------------------------------------------------- |
| AWS Access Key ID     | Sua IAM access **key ID** para este acesso.         |
| AWS Secret Access Key | Sua IAM **secret** access keys para este acesso     |
| Default region name   | Regiao AWS para criacao do recursos. _Ex.: sa-east_ |
| Default output format | Formato da saída padrão do aws cli. _Ex.: json_     |

Para tal, apos instalacao do **_"aws cli"_**, utilize o seguinte comando:

```sh
$ aws configure
```

Exemplo: _aws configure_
![aws cli - aws configure](https://geekylane.com/wp-content/uploads/2019/05/13-Run-aws-configure.png)

### Provisionando o ambiente

```sh
$ git clone https://github.com/jonaopower/terraform-aws-full-pipeline-ecs-fargate.git
$ cd terraform-aws-full-pipeline-ecs-fargate
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

### Acessando a aplicacao criada

- **Frontend**: _http://myapp.devopsteam.dev/frontend_ - under construction
- **Backend**: http://myapp.devopsteam.dev/api/values

---

## Arquitetura

A solução criada foi baseada na seguinte [Arquitetura de Referencia AWS para CD](https://aws.amazon.com/blogs/compute/continuous-deployment-to-amazon-ecs-using-aws-codepipeline-aws-codebuild-amazon-ecr-and-aws-cloudformation/).

![arquitetura proposta](https://github.com/awslabs/ecs-refarch-continuous-deployment/blob/master/images/architecture.png?raw=true)

## Terraform

O terraform foi utilizado para a provisionamento e configuracao de toda a infraestrutura.
Os modulos utilizados foram retirados de:

- [Terraform AWS modules - Github](https://github.com/terraform-aws-modules);
- [Terraform Registry](https://registry.terraform.io/modules/terraform-aws-modules);

O diretorio está estruturado conforme descrição abaixo.

Diretorio raiz / :

- **vpc.t f** --> _Declaracao do modulo terraform responsavel pela criacao da VPN e demais itens relacionados ao mesmo (subnet, AZs, etc..);_
- **ecs_cluster.tf** --> _Declaracao do modulo terraform para criar e configurar um novo cluster ECS_
- **ecs_services.tf** --> _Declaracao do modulo terraform para criar o service do ECS e recursos associados aos mesmo, como: task_definition, target_group, cloud_watch e ecr;_
- **route53_dns.tf** --> criacao de entrada DNS do tipo CNAME no route 53 chamando o nome do ALB recem criado;

Diretorio modules/ :

- vpc --> _estrutura de arquivos do modulo terraform para criar **infraestrutura de networking**;_
- ecs --> _estrutura de arquivos do modulo terraform para criar o **cluster ECS**;_
- service --> _estrutura de arquivos do modulo terraform para criar o **service que sera associado ao cluster ECS**;_
- pipeline --> _estrutura de arquivos do modulo terraform para criar e configurar uma **pipeline de tres estagios ( 1-source -> github repo, 2-build -> aws codebuild, 3-deploy --> aws ecs**;_

## Pipeline CI/CD

A Pipeline do projeto foi construída utilizando AWS Code Pipeline + AWS Code Build + ECS

1. Primeiro estágio: os códigos da aplicação foram obtidos através do repositório git AWS Code Commit;
2. Segundo estágio: Utilizando-se o AWS Code Build, nosso primeiro artefato é criado, uma imagem docker baseada nas instruções do Dockerfile do repo git;
3. Terceiro estágio: Feito o deploy da imagem gerada no AWS ECS, com duas replicas para o backend e uma para o frontend;

## DNS

Após criação de todo o ambiente, é criada uma entrada de DNS no AWS Route53, apontando para o nome DNS do ALB recém criado.
A configuração deste DNS é feito através do arquivo _route53_dns.tf_ no diretório do módulo padrão do Terraform.
