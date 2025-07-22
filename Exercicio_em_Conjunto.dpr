program Exercicio_em_Conjunto;

{$APPTYPE CONSOLE}  // Define que o programa ser� executado no console (terminal)
{$R *.res}

uses
  System.SysUtils;  // Biblioteca necess�ria para fun��es do sistema, como manipula��o de strings, erros, etc.

// Procedimento que exibe o menu principal na tela
procedure MostrarMenu;
begin
  WriteLn('------- Menu -------');
  WriteLn('1 - Realizar Login ');
  WriteLn('2 - Realizar Cadastro ');
  WriteLn('9 - Sair');
  WriteLn('--------------------');
  WriteLn('Digite seu destino: ');
end;

function ValidaTamanho(Tamanho:Integer;Valor:string):Boolean;
begin
  if (Valor.Length < Tamanho) then begin
    Result:=False;
  end else begin
    Result:=True
  end;
end;

// Constantes com usu�rio e senha fixos (Admin)
const
  usuarioadmin: String = 'Admin';
  senhaadmin: String = 'Admin';


  function GerarSenhaTemporaria(tamanho: Integer): string;
const
  Caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
var i,posicao:Integer;
senha:string;

begin
  Randomize;
  senha := '';
  for i := 1 to  tamanho do begin
    posicao := Random(Length(Caracteres)) + 1 ;
    senha := senha+ Caracteres[posicao];
  end;

  Result := senha;

end;

// Procedimento para realizar o cadastro do usu�rio
procedure MenuCadastro;
var
  nome, numero, usuario, senha: String;
  idade: Integer;
  tamanhoValido: Boolean;
begin
  WriteLn('Informe Seu Nome Completo');
  Readln(nome);

  Writeln('Informe Seu n�mero telef�nico ');
  Readln(numero);

  Writeln('Informe Sua Idade');
  Readln(idade);

  while true do
  begin
    Writeln('Informe seu usu�rio');
    Readln(usuario);
    tamanhoValido := ValidaTamanho(5, usuario);
    if tamanhoValido then
      Break
    else
    begin
      Writeln('Obrigat�rio ter mais de 5 caracteres, digite novamente...');
      Sleep(1000);
    end;
  end;

  // Gerar a senha tempor�ria com 8 caracteres
  senha := GerarSenhaTemporaria(8);

  Writeln('Sua senha tempor�ria �: ', senha);
  Writeln('Use essa senha para fazer o primeiro login e depois altere sua senha.');

  // Aqui voc� pode salvar o nome, n�mero, usu�rio e senha em sua estrutura de dados
end;




// Fun��o que verifica se o login inserido � o do administrador
function LoginValido(usuario, senha: String): Boolean;
begin
  Result := (usuario = usuarioadmin) and (senha = senhaadmin);
end;

// Vari�veis principais usadas no programa
var
  usuario, senha, opcaoDoUsuario, validarsenha: String;
  destino: Boolean;

// Fun��o de valida��o b�sica para checar se usu�rio e senha t�m exatamente 5 caracteres
function Autenticacao(usuario, senha: String): Boolean;
begin
  result := (usuario.Length = 5) and (senha.Length = 5);
end;

begin
  try
    MostrarMenu;  // Exibe o menu pela primeira vez

    destino := true;  // Controla o la�o principal do programa

    while destino do
    begin
      ReadLn(opcaoDoUsuario);  // L� a op��o digitada pelo usu�rio

      // Op��o 1: Login
      if (opcaoDoUsuario = '1') then
      begin
        var destinoLogin: Boolean := true;

        while destinoLogin do
        begin
          WriteLn('Digite seu usu�rio');
          ReadLn(usuario);

          Writeln('Digite sua senha');
          ReadLn(senha);

          // Verifica se os dados t�m tamanho v�lido
          if Autenticacao(usuario, senha) then
            Write('Dados v�lidos')
          else
            WriteLn('Dados inv�lidos');

          // Verifica se o login bate com as credenciais do admin
          if LoginValido(usuario, senha) then
          begin
            WriteLn('Autenticado com sucesso.');
            destino := false;
            destinoLogin := false;
          end
          else
          begin
            WriteLn('Credenciais incorretas, tente novamente!');
            destino := false;  // Aqui voc� est� encerrando o loop principal mesmo se falhar
          end;
        end;
      end

      // Op��o 2: Cadastro
      else if (opcaoDoUsuario = '2') then
      begin
        MenuCadastro;
      end

      // Op��o 9: Encerrar programa
      else if (opcaoDoUsuario = '9') then
      begin
        WriteLn('Encerrando...');
        Sleep(1500);  // Aguarda 1,5 segundos
        exit;         // Encerra o programa
      end

      // Qualquer outra op��o
      else
      begin
        WriteLn('Op��o inv�lida, retornando o sistema...');
        MostrarMenu;
      end;

    end;

  except
    // Em caso de erro, exibe o tipo da exce��o
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;  // Aguarda usu�rio pressionar Enter antes de fechar
end.

