# 💰 Despesas Pessoais FC

Um aplicativo Flutter moderno e intuitivo para controle de despesas pessoais, desenvolvido com foco na simplicidade e eficiência.

## 📱 Sobre o App

O **Despesas Pessoais FC** é uma solução completa para gerenciar suas finanças pessoais de forma prática e visual. Com uma interface limpa e funcionalidades essenciais, você pode acompanhar seus gastos e manter suas finanças organizadas.

## ✨ Funcionalidades

- 📊 **Gráfico de Gastos Semanais**: Visualize seus gastos dos últimos 7 dias
- 💸 **Adicionar Transações**: Registre suas despesas com título, valor e data
- 🗑️ **Remover Transações**: Delete transações desnecessárias com um toque
- 📅 **Seleção de Data**: Escolha a data específica de cada transação
- 🌍 **Localização Automática**: Datas formatadas automaticamente conforme o idioma do dispositivo
- ℹ️ **Informações do Desenvolvedor**: Acesse informações sobre o app e desenvolvedor
- 🔗 **Link para GitHub**: Acesso direto ao perfil do desenvolvedor

## 🎨 Design

- Interface moderna com Material Design
- Tema personalizado com cores roxo e âmbar
- Fontes customizadas (OpenSans e Quicksand)
- Responsivo e adaptável a diferentes tamanhos de tela
- Floating Action Button para acesso rápido

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento
- **Dart** - Linguagem de programação
- **Material Design** - Sistema de design
- **Intl** - Internacionalização e formatação de datas
- **URL Launcher** - Abertura de links externos

## 📋 Pré-requisitos

- Flutter SDK (versão 3.9.0 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

## 🚀 Como Executar

1. **Clone o repositório**
   ```bash
   git clone https://github.com/flcordis/fc_despesas.git
   cd fc_despesas
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**
   ```bash
   flutter run
   ```

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2
  url_launcher: ^6.2.2
  cupertino_icons: ^1.0.8
```

## 📱 Screenshots

*Em breve - Screenshots do aplicativo serão adicionadas*

## 🏗️ Estrutura do Projeto

```
lib/
├── components/
│   ├── chart.dart              # Gráfico de gastos semanais
│   ├── chart_bar.dart          # Barras individuais do gráfico
│   ├── transaction_form.dart   # Formulário de nova transação
│   └── transaction_list.dart   # Lista de transações
├── models/
│   └── transaction.dart        # Modelo de dados da transação
└── main.dart                   # Arquivo principal do app
```

## 🎯 Funcionalidades Futuras

- [ ] Categorização de despesas
- [ ] Relatórios mensais/anuais
- [ ] Backup na nuvem
- [ ] Modo escuro
- [ ] Notificações de lembretes
- [ ] Exportação de dados

## 🤝 Contribuição

Contribuições são sempre bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Desenvolvedor

**Flávio Cordis**

- GitHub: [@flcordis](https://github.com/flcordis)
- LinkedIn: [Flávio Cordis](https://linkedin.com/in/flcordis)

## 📞 Suporte

Se você encontrou um bug ou tem uma sugestão de melhoria, por favor:

1. Verifique se já existe uma [issue](https://github.com/flcordis/fc_despesas/issues) similar
2. Se não existir, crie uma nova issue com detalhes sobre o problema/sugestão

---

⭐ **Se este projeto te ajudou, considere dar uma estrela!** ⭐

*Copyright © 2025 Flávio Cordis. Todos os direitos reservados.*
