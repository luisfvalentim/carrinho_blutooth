# Carrinho Teste

Este é um projeto Flutter que serve como um exemplo de aplicativo. A seguir estão as instruções para instalar e configurar o Flutter para executar este projeto.

## Pré-requisitos

Antes de começar, verifique se você tem os seguintes itens instalados:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) ou outra IDE de sua escolha (como VS Code)
- [JDK 8](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html)

## Instalação do Flutter

1. **Baixe e instale o Flutter**:
   - Siga as instruções para seu sistema operacional na [documentação oficial do Flutter](https://flutter.dev/docs/get-started/install).

2. **Configure a variável de ambiente**:
   - Adicione o caminho do Flutter ao seu `PATH`. Para isso, adicione a seguinte linha no seu arquivo de configuração do terminal (por exemplo, `.bashrc`, `.bash_profile` ou `.zshrc`):

     ```bash
     export PATH="$PATH:/path/to/flutter/bin"
     ```

   - Substitua `/path/to/flutter` pelo caminho onde você instalou o Flutter.

3. **Verifique a instalação**:
   - Execute o comando a seguir para verificar se o Flutter foi instalado corretamente:

     ```bash
     flutter doctor
     ```

   - Siga as instruções para resolver qualquer problema que o `flutter doctor` indicar.

## Clonando o projeto

Clone este repositório em sua máquina local:

```bash
git clone https://seu-repositorio-url/carrinho_teste.git
cd carrinho_teste
```

## Configurando o projeto

### 1. Instalar as dependências

Execute o seguinte comando para instalar as dependências do projeto:

```bash
flutter pub get
```

### 2. Configurar o Android

1. Abra o arquivo `android/app/build.gradle` e certifique-se de que as versões do `compileSdkVersion`, `targetSdkVersion` e `minSdkVersion` estão definidas conforme o seguinte:

   ```gradle
   compileSdkVersion 33
   minSdkVersion 21
   targetSdkVersion 33
   ```

2. Em seguida, no arquivo `android/build.gradle`, verifique se a versão do `kotlin_version` está correta:

   ```gradle
   ext.kotlin_version = '1.6.10'
   ```

## Executando o aplicativo

1. Conecte um dispositivo Android ou inicie um emulador.
2. Execute o seguinte comando no terminal para iniciar o aplicativo:

   ```bash
   flutter run
   ```



