# 📍 RADARVAGAS (RadarEmprego Recife)
### *Geointeligência Hiperlocal, Prospecção B2B de Oportunidades & Disparo Inteligente de Apresentações Profissionais*

[![Live Demo](https://img.shields.io/badge/Live%20Demo-radarvagas--recife.vercel.app-emerald?style=for-the-badge&logo=vercel)](https://radarvagas-recife.vercel.app)
[![Pitch Deck](https://img.shields.io/badge/Pitch%20Deck-10%20Slides%20Executivos-cyan?style=for-the-badge)](https://radarvagas-recife.vercel.app/pitch_deck_radarvagas)
[![Database](https://img.shields.io/badge/Database-PostgreSQL%20%2B%20PostGIS-336791?style=for-the-badge&logo=postgresql)](https://postgis.net/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Produção%20Verificada-success?style=for-the-badge)]()

---

## 🚀 Links de Produção & Demonstração Oficial
* **Aplicação Pública no Ar:** [https://radarvagas-recife.vercel.app](https://radarvagas-recife.vercel.app)
* **Pitch Deck Executivo (HTML5 Interativo):** [https://radarvagas-recife.vercel.app/pitch_deck_radarvagas](https://radarvagas-recife.vercel.app/pitch_deck_radarvagas)
* **Repositório Oficial:** [https://github.com/luscaalvespereira/radarvagas-recife](https://github.com/luscaalvespereira/radarvagas-recife)

---

## 🎯 O Problema Real no Recife & A Tese dos 15 Minutos
O **RADARVAGAS** é uma plataforma concebida para romper com a ineficiência, a lentidão e a frieza dos sistemas de recrutamento convencionais (como Gupy, LinkedIn e InfoJobs), que descartam sistematicamente candidatos com perfis generalistas e multipotenciais através de triagens cegas por robôs.

Mais do que isso, as plataformas tradicionais ignoram solenemente a **mobilidade urbana do Recife**:
* Candidatos perdem de **3 a 4 horas por dia em ônibus superlotados** para vagas situadas a 20 km de distância;
* Isso gera um custo mensal de mais de R$ 300,00 em passagens e **45% de turnover em 90 dias** devido ao esgotamento físico e atrasos crônicos;
* Enquanto isso, no coração do Centro (Boa Vista e Santo Antônio), **centenas de pequenas e médias empresas em salas comerciais têm vagas abertas** e não conseguem contratar pessoas do próprio bairro.

O **RADARVAGAS** recupera a soberania territorial: conecta candidatos a empresas reais a passos de casa (**Cidade de 15 Minutos** com custo zero de passagem).

---

## 🗺️ A Tríade da Geointeligência Hiperlocal

A plataforma estrutura a busca de oportunidades sob três modos espaciais inéditos:

1. **🏢 Modo 1 · Micro-Densidade Vertical (Por Prédio Comercial Específico):**
   * Mapeamento de todas as salas, andares e empresas sediadas em um condomínio empresarial para abordagem andar por andar.
   * *Caso Piloto Real:* **Edifício Círculo Católico** (Rua do Riachuelo, 105 - Boa Vista, Recife), com 41 empresas documentadas e catalogadas em campo.
2. **🛣️ Modo 2 · Densidade Linear (Por Corredor Viário Bilateral):**
   * Filtragem de todas as empresas ao longo de uma via estruturante, com opção de selecionar ambos os lados da via ou restringir por sentido do fluxo viário (Par / Ímpar).
   * *Caso Piloto Real:* **Avenida Conde da Boa Vista** (do Cinema São Luiz ao Shopping Boa Vista, com buffer geodésico de 50 metros).
3. **⭕ Modo 3 · Densidade Radial (Por Raios Concêntricos de Mobilidade Urbana):**
   * **Raio de 1 km:** Zona de caminhabilidade pedonal (deslocamento a pé em 15 minutos, **custo financeiro zero de passagem**).
   * **Raio de 5 km:** Polo central metropolitano (Boa Vista, Bairro do Recife/Porto Digital, Ilha do Leite).
   * **Raio de 50 km:** Região Metropolitana do Recife (de Igarassu ao Porto de Suape).

---

## ⚡ Stack Tecnológica & Infraestrutura (Hackathon CreateOS × Stripe)

* **Camada de Execução em Nuvem (Agent Compute):** Micro-VMs Firecracker dedicadas do **CreateOS Sandbox** (shape s-1vcpu-1gb) com isolamento a nível de hardware e regras de firewall de saída eBPF (*egress allowlist*).
* **Monetização e Faturamento:** Integração com **Stripe Projects CLI** (stripe projects add createos/project) para cobrança fracionada pay-per-run em relatórios prediais customizados.
* **Pipeline ETL a Custo Zero:**
  * **Receita Federal do Brasil (CNPJs Abertos):** Extração de razão social, nome fantasia, CNAE econômico, telefones e e-mails institucionais do QSA.
  * **Portal Dados Recife (Prefeitura do Recife):** Validação de alvarás e funcionamento de empresas ativas mercantis.
  * **CNEFE / IBGE (Censo Demográfico 2022):** Injeção direta de latitude e longitude por face de quadra e número predial, viabilizando geocodificação gratuita sem custos de APIs pagas.
* **Banco de Dados Espacial:** PostgreSQL com extensão **PostGIS** nativa (ST_DWithin, índices espaciais GiST com respostas em menos de 5 milissegundos).

---

## 🛡️ Mecanismo Anti-Spam & Conformidade LGPD

Para garantir que a comunicação não seja classificada como lixo eletrônico nem viole a legislação brasileira:

* **Motor Spintax Dinâmico:** Geração de mensagens únicas com variação semântica de saudações e introduções, evitando repetição de hashes criptográficos.
* **Throttling Humano:** Delay randômico assíncrono entre 45 e 90 segundos entre cada envio.
* **Multi-Inbox Rotation:** Rotação entre múltiplas caixas de remetente (mantendo cada conta abaixo de 50 envios/dia).
* **Conformidade Estrita com a LGPD (Lei 13.709/2018):**
  * O envio destina-se exclusivamente a dados públicos de Pessoas Jurídicas (Arts. 1º e 5º, I — dados de PJ não são dados pessoais).
  * Base legal do Legítimo Interesse (Art. 7º, IX) voltada à oferta legítima de força de trabalho para a atividade econômica registrada.
  * Inclusão mandatória de link/instrução de **Opt-Out** imediato em 1 clique no rodapé de toda mensagem.

---

## 💻 Estrutura de Arquivos do Repositório

`	ext
├── index.html                    # Aplicação principal (SPA responsiva com mapa SVG e 3 modos espaciais)
├── pitch_deck_radarvagas.html    # Apresentação executiva em 10 slides (RECn'Play / GovTech)
├── schema_postgis_radarvagas.sql # Esquema completo do banco espacial PostgreSQL + PostGIS
├── vercel.json                   # Configuração de rotas de produção para a Vercel
├── .nojekyll                     # Desativação do processador Jekyll para entrega estrita
└── README.md                     # Documentação técnica e manifesto do projeto
`

---

## 👨‍💻 Autor & Proponente
* **Lucas Alves Pereira**
* Bacharel em Direito pela Faculdade de Direito do Recife (**FDR / UFPE**)
* Pesquisador Jurimétrico, Desenvolvedor de Software & Cientista de Dados Territoriais
* Contato: lucas.alvespereira@ufpe.br
* Ecossistema: Porto Digital • Edifício O NERD • Recife/PE