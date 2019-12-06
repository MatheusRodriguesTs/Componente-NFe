
{
Utilit�rio de exemplo para uso do componente TecnoSpeed NFe
para integra��o com o sistema de Notas Fiscais Eletr�nicas da Receita Federal,
em conjunto com as Secretarias de Fazenda estaduais.

@bold(Site oficial)
@br
http://www.tecnospeed.com.br

@author(TecnoSpeed - Consultoria em TI (http://www.tecnospeed.com.br))
@created(Julho/2010)
}

unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils,Classes, Graphics, Controls, Forms,inifiles,
  Dialogs,ShellAPI,StdCtrls, ComCtrls, jpeg, ExtCtrls, OleCtrls, SHDocVw, Buttons,
  NFeX_TLB, NFeDataSetX_TLB, uNFeEventos, uDistribuicaoDFe, uImportacaoXmlNFe;

const
  INI_FILE = 'nfeConfig.ini';

type
  TfrmExemplo = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtIdNFe: TEdit;
    edtNroRecibo: TEdit;
    edtNroProtocolo: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    edtArquivoServidores: TEdit;
    edtDiretorioEsquemas: TEdit;
    edtDiretorioLog: TEdit;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    edtCNPJ: TEdit;
    PageControl1: TPageControl;
    XMLNFe: TTabSheet;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    lbModo: TLabel;
    lbStatus: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtDiretorioTemplates: TEdit;
    Label13: TLabel;
    GroupBox1: TGroupBox;
    btnArqConfigINI_: TButton;
    btnAlteraCertificado_: TButton;
    btnStatusServico_: TButton;
    btnGeraXml_: TButton;
    btnAssinaXml_: TButton;
    btnEnviaXml_: TButton;
    btnConsultaRecibo_: TButton;
    btnConsultaNFe_: TButton;
    btnCancelaNFe_: TButton;
    btnInutilizaNumNFe_: TButton;
    btnVisualizaDANFE_: TButton;
    btnImprimiDANFE_: TButton;
    btnEditaDANFE_: TButton;
    btnExportaDANFE_: TButton;
    btnDANFE_: TButton;
    btnEnviaXmlDestinatario_: TButton;
    btnGeraXMLDest_: TButton;
    btnLogs_: TButton;
    pnlSplitter: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    memoXml: TMemo;
    lstCertificados: TListBox;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    GroupBox5: TGroupBox;
    edtModeloRTM: TEdit;
    btnModeloRTM: TButton;
    oplgModeloRTM: TOpenDialog;
    btnManifestarNFe: TButton;
    cbVersao: TComboBox;
    lblVersao: TLabel;
    cbConfigUF: TComboBox;
    btnDistribuicaoDFe: TButton;
    btnImportacaoXmlNFe: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnArqConfigINI_Click(Sender: TObject);
    procedure btnAlteraCertificado_Click(Sender: TObject);
    procedure btnStatusServico_Click(Sender: TObject);
    procedure lstCertificadosClick(Sender: TObject);
    procedure btnGeraXml_Click(Sender: TObject);
    procedure btnAssinaXml_Click(Sender: TObject);
    procedure btnEnviaXml_Click(Sender: TObject);
    procedure btnConsultaRecibo_Click(Sender: TObject);
    procedure btnConsultaNFe_Click(Sender: TObject);
    procedure btnCancelaNFe_Click(Sender: TObject);
    procedure btnInutilizaNumNFe_Click(Sender: TObject);
    procedure btnVisualizaDANFE_Click(Sender: TObject);
    procedure btnImprimiDANFE_Click(Sender: TObject);
    procedure btnEditaDANFE_Click(Sender: TObject);
    procedure btnExportaDANFE_Click(Sender: TObject);
    procedure btnDANFE_Click(Sender: TObject);
    procedure btnEnviaXmlDestinatario_Click(Sender: TObject);
    procedure btnGeraXMLDest_Click(Sender: TObject);

    procedure btnLogs_Click(Sender: TObject);
    procedure btnModeloRTMClick(Sender: TObject);
    procedure btnManifestarNFeClick(Sender: TObject);
    procedure cbVersaoExit(Sender: TObject);
    procedure btnDistribuicaoDFeClick(Sender: TObject);
    procedure btnImportacaoXmlNFeClick(Sender: TObject);
  private
    { Private declarations }
    { campo WideString respons�vel por conter os dados em XML gerado pelo componente spdNFeDatasets.}
    fXmlGerado : WideString;
    { campo WideString respons�vel por conter os dados em XML assinado pelo spdNFe.}
    fXmlAssinado : WideString;
    {fXmlDanfe que ser� utilizado para Imprimir, Visualizar, Exportar a Danfe}
    fXmlDanfe : WideString;
    { campo WideString respons�vel por armazenar o retorno do WebService .}
    fXmlRetorno : WideString;
    { Armazena o nome do certificado }
    fNomeCertificado : WideString;
    { Armazena local+arquivo XML da consulta do recibo }
    fXmlConsRec : string;
    fDirAplicacao: string;
    fArquivoIni, fCnpjSoftwareHouse : string;
    procedure LoadConfig;
    procedure ConfigEmail(const aEmailDestinatario:string); //Configurando email via c�digo
    function LoadXmlDestinatario(Const aChave : string) : WideString;
    procedure LoadListaCertificados;
    function GetFusoUF(const aIndexUf : integer): string;
    function GetCodigoUF(const aIndexUf : integer): string;
  public
    { Public declarations }

    { Armazena local+arquivo XML de envio }
    fXmlEnv : WideString;
  end;

var
  frmExemplo: TfrmExemplo;
  spdNFeX: TspdNFeX;
  spdNFeDatasetsX: TspdNFeDataSetX;

const
  versao_2_02a: Integer = 0;
  versao_3_0: Integer = 1;
  versao_4_0: Integer = 2;
  versao_5_0: Integer = 3;
  versao_5_0a: Integer = 4;
  versao_6_0: Integer = 5;

implementation

uses uDemoUtils, uWebBrowser;

{$R *.dfm}

{ Lista configura��es carregadas pelo m�todo LoadConfig do componente
  spdNFeX que busca informa��es do arquivo nfeConfig.ini}
procedure TfrmExemplo.LoadConfig;
var
  _versaoRtm: String;
begin
  fCnpjSoftwareHouse := '12345678901234';
  spdNFeX.ConfigurarSoftwareHouse(fCnpjSoftwareHouse,''); //***Configure com o CNPJ de sua Software House

  //Le as configura��es do arquivo nfeConfig.ini
  fDirAplicacao := ExtractFilePath(ParamStr(0));
  fArquivoIni := fDirAplicacao + INI_FILE;  
  if FileExists(fArquivoIni) then
    spdNFeX.LoadConfig(fArquivoIni);

 { Mostra as propriedades setadas para o componente }
  edtArquivoServidores.Text  := spdNFeX.ArquivoServidoresHom;
  edtDiretorioEsquemas.Text  := spdNFeX.DiretorioEsquemas;
  edtDiretorioTemplates.Text := spdNFeX.DiretorioTemplates;
  edtDiretorioLog.Text       := spdNFeX.DiretorioLog;
  edtCNPJ.Text               := spdNFeX.CNPJ;
  cbConfigUF.ItemIndex       := cbConfigUF.Items.IndexOf(spdNFeX.UF);

  //Vers�o Manual
  if spdNFeX.VersaoManual = '2.0' then
    cbVersao.ItemIndex := versao_2_02a
  else if spdNFeX.VersaoManual = '3.0' then
  begin
    cbVersao.ItemIndex := versao_3_0;
    spdNFeDataSetsX.VersaoEsquema := 'pl_005d';
    _versaoRtm := 'Vm30';
  end
  else if spdNFeX.VersaoManual = '4.0' then
  begin
    cbVersao.ItemIndex := versao_4_0;
    spdNFeDataSetsX.VersaoEsquema := 'pl_006j';
    _versaoRtm := 'Vm40';
  end
  else if spdNFeX.VersaoManual = '5.0' then
  begin
    cbVersao.ItemIndex := versao_5_0;
    spdNFeDataSetsX.VersaoEsquema := 'pl_006q';
    _versaoRtm := 'Vm50';
  end
  else if spdNFeX.VersaoManual = '5.0a' then
  begin
    cbVersao.ItemIndex := versao_5_0a;
    spdNFeDataSetsX.VersaoEsquema := 'pl_008h';
    _versaoRtm := 'Vm50a';
  end
  else if spdNFeX.VersaoManual = '6.0' then
  begin
    cbVersao.ItemIndex := versao_6_0;
    spdNFeDataSetsX.VersaoEsquema := 'pl_009';
    _versaoRtm := 'Vm60';
  end;

  spdNFeDatasetsX.DicionarioXML := spdNFeX.DiretorioTemplates + 'Conversor\NFeDataSets.xml'; //Apos setar vers�o do esquema

  LoadListaCertificados;
  lstCertificados.ItemIndex := lstCertificados.Items.IndexOf(Trim(spdNFeX.NomeCertificado));
end;

procedure TfrmExemplo.FormCreate(Sender: TObject);
begin
  { Inst�ncia os objetos declarados }
  spdNFeX := TspdNFeX.Create(nil);
  spdNFeDatasetsX := TspdNFeDataSetX.Create(nil);

  LoadConfig;
end;

//Botao 1 Configura Arquivo INI
procedure TfrmExemplo.btnArqConfigINI_Click(Sender: TObject);
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);

  with SEInfo do
  begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    lpFile := PChar(fArquivoIni);
    nShow := SW_SHOWNORMAL;
  end;

  if ShellExecuteEx(@SEInfo) then
  begin
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
      LoadConfig;
  end
  else
    Raise Exception.Create('Erro ao tentar abrir o arquivo ' + fArquivoIni
     + '. Verifique se o arquivo est� na mesma pasta que o execut�vel.');
end;

//Botao 2 - Altera Certificado
procedure TfrmExemplo.btnAlteraCertificado_Click(Sender: TObject);
begin
  LoadListaCertificados;

  //Mostra certificados
  PageControl2.ActivePage := TabSheet2;
end;

//Botao 3 - Verifica Status
procedure TfrmExemplo.btnStatusServico_Click(Sender: TObject);
begin
  { Verifica a se o WebService da Sefaz esta em opera��o }
  memoXml.Text := spdNFeX.StatusDoServico;
end;

procedure TfrmExemplo.lstCertificadosClick(Sender: TObject);
begin
  { Armasenando o nome do certificado numa vari�vel}
  if lstCertificados.ItemIndex = - 1 then
    fNomeCertificado := ''
  else
    fNomeCertificado := lstCertificados.Items[lstCertificados.ItemIndex];

  {Salva o nome do certificado no arquivo nfeConfig.ini}
  WriteToIni('NomeCertificado',fNomeCertificado);

  //Mostra lista de certificados
  PageControl2.ActivePage := TabSheet1;
end;

procedure TfrmExemplo.btnGeraXml_Click(Sender: TObject);

  { incluindo dados referentes a nota }
  procedure DadosDoNFe(aDs: TspdNFeDataSetX);
  var
    _NrNota: string;
    _TipoEmissao: string;
  begin
    Randomize;
    _NrNota := IntToStr(Random(10000));                 // Gera um n�mero rand�mico de NF para demonstra��o
    _TipoEmissao := '1';

    //aDs.SetCampo('Id_A03=');                          // Calcula Autom�tico. Essa linha � desnecess�ria
    aDs.SetCampo('cUF_B02='+GetCodigoUF(cbConfigUF.ItemIndex));// Codigo da UF
    aDs.SetCampo('cNF_B03=04640327');                   // C�digo Interno do Sistema que est� integrando com a NFe
    aDs.SetCampo('natOp_B04=VENDA MERC.ADQ.REC.TERC');  // Descri��o da(s) CFOP(s) envolvidas nessa NFe
    if cbVersao.ItemIndex < versao_6_0 then
      aDs.SetCampo('indPag_B05=1');                     // Indicador da Forma de Pgto (1- a Vista, 2 a Prazo)
    aDs.SetCampo('mod_B06=55');                         // C�digo do Modelo de Documento Fiscal
    aDs.SetCampo('serie_B07=121');                      // S�rie do Documento
    aDs.SetCampo('nNF_B08='+_NrNota);                   // N�mero da Nota Fiscal

    if cbVersao.ItemIndex >= versao_5_0a then
    begin
      aDs.SetCampo('dhEmi_B09='+FormatDateTime('YYYY-MM-DD"T"HH:MM:SS',now) + GetFusoUF(cbConfigUF.ItemIndex)); //  Data e Hora de Emiss�o da Nota Fiscal Seguido do Fuso Horario
      aDs.SetCampo('dhSaiEnt_B10=' +FormatDateTime('YYYY-MM-DD"T"HH:MM:SS',now) + GetFusoUF(cbConfigUF.ItemIndex)); // Data e Hora de Sa�da ou Entrada da Nota Fiscal Seguido do Fuso Horario
      aDs.SetCampo('idDest_B11a=1'); // Identificador de local de destino da opera��o (1-Opera��o Interna, 2-Opera��o Interestadual e 3-Opera��o com exterior)
      aDs.SetCampo('indFinal_B25a=0'); // Indica opera��o com Consumidor final (0-N�o, 1-Consumidor Final)
      aDs.SetCampo('indPres_B25b=0'); // Indicador de presen�a do comprador no estabelecimento comercial ( 0-N�o, 1-Opera��o presencial, 2-Opera��o n�o presencial, Internet, 3-Opera��o N�o presencial, teleatendimento, 9-Opera��o n�o presencial, outros.)
    end
    else
    begin
      aDs.SetCampo('dEmi_B09='+FormatDateTime('YYYY-MM-DD',now)); //  Data de Emiss�o da Nota Fiscal
      aDs.SetCampo('dSaiEnt_B10='+FormatDateTime('YYYY-MM-DD',now)); // Data de Sa�da ou Entrada da Nota Fiscal
      aDs.SetCampo('hSaiEnt_B10a='+FormatDateTime('HH:MM:SS',now)); // Hora de Sa�da ou Entrada da Nota Fiscal
    end;

    aDs.SetCampo('tpNF_B11=1');                         // Tipo de Documento Fiscal (0-Entrada, 1-Sa�da)
    aDs.SetCampo('cMunFG_B12=4115200');                 // C�digo do Munic�pio, conforme Tabela do IBGE
    aDs.SetCampo('tpImp_B21=1');                        // Tipo de Impress�o da Danfe (1- Retrato , 2-Paisagem)
    aDs.SetCampo('tpEmis_B22='+_TipoEmissao);           // Forma de Emiss�o da NFe (1 - Normal, 2 - FS, 3 - SCAN, 4 - DPEC, 4 - EPEC, 5 - FS-DA)
    aDs.SetCampo('cDV_B23=0');                          // Calcula Automatico - Linha desnecess�ria j� que o componente calcula o D�gito Verificador automaticamente e coloca no devido campo
    aDs.SetCampo('tpAmb_B24=2');                        // Identifica��o do Ambiente (1- Producao, 2-Homologa��o)
    aDs.SetCampo('finNFe_B25=1');                       // Finalidade da NFe (1-Normal, 2-Complementar, 3-de Ajuste)
    aDs.SetCampo('procEmi_B26=0');                      // Identificador do Processo de emiss�o (0-Emiss�o da Nfe com Aplicativo do Contribuinte). Ver outras op��es no manual da Receita.
    aDs.SetCampo('verProc_B27=000');                    // Vers�o do Aplicativo Emissor

    if ((_TipoEmissao = '2') or (_TipoEmissao = '5')) then //FS
    begin
      if cbVersao.ItemIndex >= versao_5_0a then
        aDs.SetCampo('dhCont_B28='+FormatDateTime('YYYY-MM-DD"T"HH:MM:SS',Now) + GetFusoUF(cbConfigUF.ItemIndex)) // Data e hora de entrada em conting�ncia no formato AAAA-MM-DDTHH:MM:SS
      else
        aDs.SetCampo('dhCont_B28='+FormatDateTime('YYYY-MM-DD"T"HH:MM:SS',Now)); // Data e hora de entrada em conting�ncia no formato AAAA-MM-DDTHH:MM:SS
      aDs.SetCampo('xJust_B29=Exemplo de justificativa de FS'); // Justificativa da conting�ncia
    end;

    //Para Nota Referenciada utilizar como no exemplo abaixo
    if cbVersao.ItemIndex >= versao_5_0a then
    begin
      aDs.IncluirParte('NRef');
      aDs.SetCampo('refNFe_BA02=43140394814886000150551210000021401046403278'); // Chave de acesso das NF-e referenciadas
      aDs.SalvarParte('NRef');
    end
    else
    begin
      aDs.IncluirParte('NRef');
      aDs.SetCampo('refNFe_B13=35100761367025000112550010000054241046403270'); // Chave de acesso das NF-e referenciadas
      aDs.SalvarParte('NRef');

      aDs.IncluirParte('NRef');
      aDs.SetCampo('refNFe_B13=35100761367025000112550010000054241046403270'); // Chave de acesso das NF-e referenciadas
      aDs.SalvarParte('NRef');
    end;

    // At� Manual 3.0
    if cbVersao.ItemIndex = versao_3_0 then
      aDs.SetCampo('versao_A02=1.10') // Vers�o do Layout que est� utilizando
    else if cbVersao.ItemIndex = versao_5_0 then
    begin
      aDs.SetCampo('CRT_C21=1'); // C�digo de Regime Tribut�rio
      aDs.SetCampo('versao_A02=2.00'); // Vers�o do Layout que est� utilizando - Manual 5.0
    end
    else if cbVersao.ItemIndex = versao_5_0a then
    begin
      // Novos campos do manual 4.0 - Obrigat�rio
      aDs.SetCampo('CRT_C21=1'); // C�digo de Regime Tribut�rio
      aDs.SetCampo('versao_A02=3.10'); // Vers�o do Layout que est� utilizando - Manual 4.0
    end
    else
    begin
      aDs.SetCampo('CRT_C21=1'); // C�digo de Regime Tribut�rio
      aDs.SetCampo('versao_A02=4.00'); // Vers�o do Layout que est� utilizando - Manual 6.0
    end;
  end;

  { incluir dados referentes ao emitente }
  procedure DadosDoEmitente(aDs:TspdNFeDataSetX);
  begin
    aDs.SetCampo('CNPJ_C02='+edtCNPJ.Text);             // CNPJ do Emitente
    aDs.SetCampo('xNome_C03=TECNOSPEED TECNOLOGIA DE INFORMACAO LTDA');                // Razao Social ou Nome do Emitente
    aDs.SetCampo('xFant_C04=TECNOSPEED TECNOLOGIA DE INFORMACAO LTDA');                     // Nome Fantasia do Emitente
    aDs.SetCampo('xLgr_C06=RUA DAS EMPRESAS');          // Logradouro do Emitente
    aDs.SetCampo('nro_C07=123');                        // Numero do Logradouro do Emitente
    aDs.SetCampo('xCpl_C08=LOJA 7');                    // Complemento
    aDs.SetCampo('xBairro_C09=CENTRO');                 // Bairro do Emitente
    aDs.SetCampo('cMun_C10=4115200');                   // C�digo da Cidade do Emitente (Tabela do IBGE)
    aDs.SetCampo('xMun_C11=MARINGA');                   // Nome da Cidade do Emitente
    aDs.SetCampo('UF_C12='+cbConfigUF.Text);            // Sigla do Estado do Emitente (Tabela do IBGE)
    aDs.SetCampo('CEP_C13=87500000');                   // Cep do Emitente
    aDs.SetCampo('cPais_C14=1058');                     // C�digo do Pa�s do Emitente (Tabela BACEN)
    aDs.SetCampo('xPais_C15=BRASIL');                   // Nome do Pa�s do Emitente
    aDs.SetCampo('fone_C16=4432222222');                // Fone do Emitente
    aDs.SetCampo('IE_C17=9044016688');                  // Inscri��o Estadual do Emitente
    //aDs.SetCampo('IEST_C18=');                        // IE do Substituto Tribut�rio
    //aDs.SetCampo('IM_C19=')               ;           // Inscri��o Municipal do Prestador de Servi�o
    //aDs.SetCampo('CNAE_C20=')                         // CNAE Fiscal -> Campo Opcional. Pode ser informado quando a Inscri��o Municipal (id:C19) for informada
    aDs.SetCampo('CRT_C21=3');                          // C�digo de Regime Tribut�rio 1=Simples Nacional; 2=Simples Nacional, excesso sublimite de receita bruta; 3=Regime Normal.     
  end;

  { incluir dados referentes ao destinatario}
  procedure DadosDoDestinatario(aDs: TspdNFeDataSetX);
  begin
    aDs.SetCampo('CNPJ_E02=08187168000160');   // CNPJ do Destinat�rio
    //aDs.SetCampo('idEstrangeiro_E03a=123456'); //Identifica��o do destinat�rio no caso de comprador estrangeiro
    aDs.SetCampo('xNome_E04=NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL');// Razao social ou Nome do Destinat�rio
    aDs.SetCampo('xLgr_E06=RUA DO CENTRO');    // Logradouro do Destinatario
    aDs.SetCampo('nro_E07=897');               // Numero do Logradouro do Destinatario
    aDs.SetCampo('xCpl_E08=APTO 21');          // Complemento
    aDs.SetCampo('xBairro_E09=CENTRO');        // Bairro do Destinatario
    aDs.SetCampo('cMun_E10=4115200');          // C�digo do Munic�pio do Destinat�rio (Tabela IBGE)
    aDs.SetCampo('xMun_E11=MARINGA') ;         // Nome da Cidade do Destinat�rio
    aDs.SetCampo('UF_E12=PR');                 // Sigla do Estado do Destinat�rio
    aDs.SetCampo('CEP_E13=87500000');          // Cep do Destinat�rio
    aDs.SetCampo('cPais_E14=1058');            // C�digo do Pais do Destinat�rio (Tabela do BACEN)
    aDs.SetCampo('xPais_E15=BRASIL');          // Nome do Pa�s do Destinat�rio
    aDs.SetCampo('fone_E16=445555555');        // Fone do Destinat�rio
    if cbVersao.ItemIndex >= versao_5_0a then
      aDs.SetCampo('indIEDest_E16a=1');         // Indicador da IE do Destinat�rio 1-Contribuinte ICMS/2-Contribuinte Isento de inscri��o/9- N�o contribuinte    
    aDs.SetCampo('IE_E17=9044016688');          // Inscri��o Estadual do Destinat�rio
    //aDs.SetCampo('ISUF_E18=');                // Inscri��o na SUFRAMA    
    aDs.SetCampo('email_E19=testedanfe@gmail.com'); // Email    
  end;

  //// Autorizados a baixar o XML
  //procedure DadosAutorizadosBaixarXML(aDs : TspdNFeDataSetX);
  //begin
  //  if Length(edtAutXMLCNPJCPF.Text) = 14 then
  //    aDs.SetCampo('CNPJ_GA02').Value := edtAutXMLCNPJCPF.Text // CNPJ do Autorizado
  //  else if Length(edtAutXMLCNPJCPF.Text) = 11 then
  //    aDs.SetCampo('CPF_GA03').Value := edtAutXMLCNPJCPF.Text; // CPF do Autorizado
  //end;

  { incluir os itens da nota }
  procedure DadosItem (aDs: TspdNFeDataSetX; aNumItem: Integer);
  begin
    aDs.SetCampo('nItem_H02='+IntToStr(aNumItem)); // N�mero do Item da NFe (1 at� 990)
    // Dados do Produto Vendido
    aDs.SetCampo('cProd_I02=0999');                // C�digo do PRoduto ou Servi�o
    aDs.SetCampo('cEAN_I03=8712581497668');        // EAN do Produto
    aDs.SetCampo('xProd_I04=MELAO');               // Descri��o do PRoduto
    aDs.SetCampo('NCM_I05=11081200');              // C�digo do NCM - informar de acordo com o Tabela oficial do NCM
    if cbVersao.ItemIndex >= versao_5_0a then
      aDs.SetCampo('CEST_I05c=0125457');           // C�digo especificador da substitui��o tribuit�ria - CEST;

    if cbVersao.ItemIndex >= versao_6_0 then
    begin
      aDs.SetCampo('indEscala_I05d=S');            // Indicador de Escala Relevante
      aDs.SetCampo('CNPJFab_I05e=');               // CNPJ do Fabricante da Mercadoria
      aDs.SetCampo('cBenef_I05f=');                // C�digo de Benef�cio Fiscal na UF aplicado ao item
    end;

    aDs.SetCampo('CFOP_I08=5102');                 // CFOP incidente neste Item da NF
    aDs.SetCampo('uCom_I09=CX');                   // Unidade de Medida do Item
    aDs.SetCampo('qCom_I10=1');                    // Quantidade Comercializada do Item
    aDs.SetCampo('vUnCom_I10a=0.0100');            // Valor Comercializado do Item
    aDs.SetCampo('vProd_I11=0.01');                // Valor Total Bruto do Item
    aDs.SetCampo('cEANTrib_I12=8712581497668');    // EAN Tribut�vel do Item
    aDs.SetCampo('uTrib_I13=CX');                  // Unidade de Medida Tribut�vel do Item
    aDs.SetCampo('qTrib_I14=1');                   // Quantidade Tribut�vel do Item
    aDs.SetCampo('vUnTrib_I14a=0.0100');           // Valor Tribut�vel do Item

    if cbVersao.ItemIndex >= versao_5_0a then
    begin
      aDs.SetCampo('xPed_I60=10123'); //N�mero do Pedido de Compra
      aDs.SetCampo('nItemPed_I61=321'); //Item do Pedido de Compra
    end;

    //if ((cbVersao.ItemIndex >= versao_5_0a) and (EnviarPartilhaFCP = True)) then
    //begin
    //  aDs.SetCampo('vBCUFDest_NA03=0.00'); // Valor da base de calculo do ICMS na UF do destinat�rio.
    //  if (cbVersao.ItemIndex >= versao_6_0) then
    //    aDs.SetCampo('vBCFCPUFDest_NA04=0.00'); //Valor da BC FCP na UF de destino
    //  aDs.SetCampo('pFCPUFDest_NA05=0.00'); //Percentual do ICMS relativo ao Fundo de Combate � Pobreza (FCP) na UF de destino
    //  aDs.SetCampo('pICMSUFDest_NA07=0.00'); //Aliquota adotada nas opera��es internas na UF do destinatario
    //  aDs.SetCampo('pICMSInter_NA09=00.00');  //Aliquota interestadual das UF envolvida
    //  aDs.SetCampo('pICMSInterPart_NA11=0.00'); //Percentual da partilha para a UF do destinat�rio
    //  aDs.SetCampo('vFCPUFDest_NA13=0.00'); //Valor do ICMS relativo ao Fundo de Combate � pobreza (FCP) da UF de destino
    //  aDs.SetCampo('vICMSUFDest_NA15=0.00'); // Valor do ICMS de partilha para a UF do destinat�rio
    //  aDs.SetCampo('vICMSUFRemet_NA17=0.00'); // Valor do ICMS da partilha para UF do remetente.
    //end;

    //////////////////// Aqui come�am os Impostos Incidentes sobre o Item////////////////////////
    /// Verificar Manual pois existe uma varia��o nos campos de acordo com Tipo de Tribuca��o ///
    // ICMS
    aDs.SetCampo('orig_N11=0');         // Origem da Mercadoria
                                        // 0 - Nacional, exceto as indicadas nos c�digos 3, 4, 5 e 8;
                                        // 1 - Estrangeira - Importa��o direta, exceto a indicada no c�digo 6;
                                        // 2 - Estrangeira - Adquirida no mercado interno, exceto a indicada no c�digo 7;
                                        // 3 - Nacional, mercadoria ou bem com Conte�do de Importa��o superior a 40% e inferior ou igual a 70%;
                                        // 4 - Nacional, cuja produ��o tenha sido feita em conformidade com os processos produtivos b�sicos de que tratam as legisla��es citadas nos Ajustes;
                                        // 5 - Nacional, mercadoria ou bem com Conte�do de Importa��o inferior ou igual a 40%;
                                        // 6 - Estrangeira - Importa��o direta, sem similar nacional, constante em lista da CAMEX e g�s natural;
                                        // 7 - Estrangeira - Adquirida no mercado interno, sem similar nacional, constante lista CAMEX e g�s natural.
                                        // 8 - Nacional, mercadoria ou bem com Conte�do de Importa��o superior a 70%;
    aDs.SetCampo('CST_N12=00');         // Tipo da Tributa��o do ICMS (00 - Integralmente) ver outras formas no Manual
    aDs.SetCampo('modBC_N13=0');        // Modalidade de determina��o da Base de C�lculo - ver Manual
    aDs.SetCampo('vBC_N15=0.01');       // Valor da Base de C�lculo do ICMS
    aDs.SetCampo('pICMS_N16=7.00');     // Al�quota do ICMS em Percentual
    aDs.SetCampo('vICMS_N17=0.01');     // Valor do ICMS em Reais
    //if ((cbVersao.ItemIndex >= versao_6_0) and (cbPartilhaFCP.Checked)) then
    //begin
    //  aDs.Campo('pFCP_N17b=0.00');      //Percentual do Fundo de Combate � Pobreza (FCP)
    //  aDs.Campo('vFCP_N17c=0.00');      //Valor do Fundo de Combate � Pobreza (FCP)
    //end;

    // PIS
    aDs.SetCampo('CST_Q06=01');         // Codigo de Situacao Tribut�ria - ver op��es no Manual
    aDs.SetCampo('vBC_Q07=0.01');       // Valor da Base de C�lculo do PIS
    aDs.SetCampo('pPIS_Q08=1.65');      // Al�quota em Percencual do PIS
    aDs.SetCampo('vPIS_Q09=0.01');      // Valor do PIS em Reais

    // COFINS
    aDs.SetCampo('CST_S06=01');         // C�digo de Situacao Tribut�ria - ver op��es no Manual
    aDs.SetCampo('vBC_S07=0.01');       // Valor da Base de C�lculo do COFINS
    aDs.SetCampo('pCOFINS_S08=7.60');   // Al�quota do COFINS em Percentual
    aDs.SetCampo('vCOFINS_S11=0.01');   // Valor do COFINS em Reais

    // Novo campo da 4.0 - para saber se o item totaliza na nota
    if (cbVersao.ItemIndex >= versao_4_0) then
       aDs.SetCampo('indTot_I17b=1');
  end;

  { incluir totalizadores da nota }
  procedure DadosTotalizadores(aDs: TspdNFeDataSetX);
  begin
    aDs.SetCampo('vBC_W03=0.01'); //Base de C�lculo do ICMS
    aDs.SetCampo('vICMS_W04=0.01'); // Valor Total do ICMS

    if cbVersao.ItemIndex >= versao_5_0a then
    begin
      if ((cbVersao.ItemIndex >= versao_6_0) and (aDs.GetCampo('vICMSDeson_N28a') = '0.01')) then
        aDs.SetCampo('vICMSDeson_W04a=0.01') // Valor Total do ICMS desonerado
      else if ((cbVersao.ItemIndex = versao_5_0a) and (aDs.GetCampo('vICMSDeson_N27a') = '0.01')) then
        aDs.SetCampo('vICMSDeson_W04a=0.01') // Valor Total do ICMS desonerado
      else
        aDs.SetCampo('vICMSDeson_W04a=0.00'); // Valor Total do ICMS desonerado
    end;

    if cbVersao.ItemIndex >= versao_5_0a then
    begin
      aDs.SetCampo('vFCPUFDest_W04c=0.00'); // Valor total do ICMS relativo Fundo de Combate � Pobreza (FCP) da UF de destino
      aDs.SetCampo('vICMSUFDest_W04e=0.00'); // Valor total do ICMS de partilha para a UF do destinatario
      aDs.SetCampo('vICMSUFRemet_W04g=0.00'); // Valor total do ICMS de partilha para a UF do destinatario
    end;

    if cbVersao.ItemIndex >= versao_6_0 then
      aDs.SetCampo('vFCP_W04h=0.00'); // Valor Total do FCP (Fundo de Combate � Pobreza)

    aDs.SetCampo('vBCST_W05=0.00'); // Base de C�lculo do ICMS Subst. Tribut�ria
    aDs.SetCampo('vST_W06=0.00'); // Valor Total do ICMS Sibst. Tribut�ria

    if cbVersao.ItemIndex >= versao_6_0 then
    begin
      aDs.SetCampo('vFCPST_W06a=0.00'); // Valor Total do FCP (Fundo de Combate � Pobreza) retido por substitui��o tribut�ria
      aDs.SetCampo('vFCPSTRet_W06b=0.00'); // Valor Total do FCP retido anteriormente por Substitui��o Tribut�ria
    end;    

    aDs.SetCampo('vProd_W07=0.01'); // Valor Total de Produtos
    aDs.SetCampo('vFrete_W08=0.00'); // Valor Total do Frete
    aDs.SetCampo('vSeg_W09=0.00'); // Valor Total do Seguro
    aDs.SetCampo('vDesc_W10=0.00'); // Valor Total de Desconto
    aDs.SetCampo('vII_W11=0.00'); // Valor Total do II
    aDs.SetCampo('vIPI_W12=0.00'); // Valor Total do IPI

    if cbVersao.ItemIndex >= versao_6_0 then
      aDs.SetCampo('vIPIDevol_W12a=0.00'); // Valor Total do IPI devolvido

    aDs.SetCampo('vPIS_W13=0.01'); // Valor Toal do PIS
    aDs.SetCampo('vCOFINS_W14=0.01'); // Valor Total do COFINS
    aDs.SetCampo('vOutro_W15=0.00'); // OUtras Despesas Acess�rias
    aDs.SetCampo('vNF_W16=0.01'); // Valor Total da NFe - Vers�o Trial s� aceita NF at� R$ 1.00

    ////ISSQNTot
    //if cbNotaConjugada.Checked then
    //begin
    //  aDs.SetCampo('vServ_W18=0.01'); // Valor Total dos servi�os n�o tributados pelo ICMS
    //  aDs.SetCampo('vBC_W19=0.01'); // Valor de Base de C�lculo do ISS
    //  aDs.SetCampo('vISS_W20=0.01'); // Valor Total ISS
    //  aDs.SetCampo('vPIS_W21=0.01'); // Valor do PIS sobre servi�os
    //  aDs.SetCampo('vCOFINS_W22=0.01'); // Valor do COFINS sobre servi�os
    //  if cbVersao.ItemIndex >= versao_5_0a then
    //  begin
    //    aDs.SetCampo('dCompet_W22a='+FormatDateTime('YYYY-MM-DD',now); // "Data da presta��o do servi�o
    //    aDs.SetCampo('vDeducao_W22b=0.01'); // Valor dedu��o para redu��o da Base de C�lculo
    //    aDs.SetCampo('vOutro_W22c=0.01'); // Valor outras reten��es
    //    aDs.SetCampo('vDescIncond_W22d=0.01'); // Valor desconto incondicionado
    //    aDs.SetCampo('vDescCond_W22e=0.01'); // Valor desconto condicionado
    //    aDs.SetCampo('vISSRet_W22f=0.01'); // Valor total reten��o ISS
    //    aDs.SetCampo('cRegTrib_W22g=1'); // C�digo do Regie especial de tributa��o
    //  end;
    //end;    
  end;

  { incluir dados referentes a transportadora }
  procedure DadosTransporte(aDs: TspdNFeDataSetX);
  begin
    aDs.SetCampo('modFrete_X02=9'); // Modalidade do Frete
                                    // 0=Contrata��o do Frete por conta do Remetente (CIF);
                                    // 1=Contrata��o do Frete por conta do Destinat�rio (FOB);
                                    // 2=Contrata��o do Frete por conta de Terceiros;
                                    // 3=Transporte Pr�prio por conta do Remetente;
                                    // 4=Transporte Pr�prio por conta do Destinat�rio;
                                    // 9=Sem Ocorr�ncia de Transporte.
  end;

  { incluir dados adicionais }
  procedure DadosAdicionais (aDs: TspdNFeDataSetX);
  begin
    aDs.SetCampo('infAdFisco_Z02=OBSERVACAO TESTE DA DANFE - FISCO'); // INteresse do Fisco
    aDs.SetCampo('infCpl_Z03=OBSERVACAO TESTE DA DANFE - CONTRIBUINTE'); // Interesse da Empresa
  end;

  procedure DadosCobranca (aDs: TspdNFeDataSetX);
  var
    i : integer;
    _Data :  TDateTime;  
  begin
    //Dados da Fatura //
    aDs.SetCampo('nFat_Y03=2000'); // N�mero da Farura
    aDs.SetCampo('vOrig_Y04=1000.00'); // Valor Original da Fatura
    aDs.SetCampo('vDesc_Y05=100.00'); // Valor do Desconto
    aDs.SetCampo('vLiq_Y06=900.00'); // Valor L�quido da Fatura

    _Data := Date;
    
    // 1 Fatura  - 3 Duplicatas //
    for i := 1 to 3 do
    begin
      // Duplicatas //
      aDs.IncluirCobranca;
      aDs.SetCampo('nDup_Y08='+IntToStr(i)); // N�mero da Duplicata
      aDs.SetCampo('dVenc_Y09='+FormatDateTime('YYYY-MM-DD',_Data)); // Data de Vencimento da Duplicata
      aDs.SetCampo('vDup_Y10=900.00'); // Valor da Duplicata
      aDs.SalvarCobranca; // Grava a Duplicata em quest�o.

      //Incrementa a data das duplicatas.
      _data := IncMonth(_Data,1);      
    end;
  end;

  //Informa��es de Pagamento
  //Obrigat�rio o preenchimento do Grupo Informa��es de Pagamento para NF-e e NFC-e.
  //Para as notas com finalidade de Ajuste ou Devolu��o o campo Forma de Pagamento deve ser preenchido com 90=Sem Pagamento.
  procedure DadosPagamento(aDs : TspdNFeDataSetX);
  begin
    aDs.IncluirParte('YA');
    //Grupo de Informa��es de Pagamento
    aDs.SetCampo('tPag_YA02=14'); //Forma de pagamento
                                  //01=Dinheiro
                                  //02=Cheque
                                  //03=Cart�o de Cr�dito
                                  //04=Cart�o de D�bito
                                  //05=Cr�dito Loja
                                  //10=Vale Alimenta��o
                                  //11=Vale Refei��o
                                  //12=Vale Presente
                                  //13=Vale Combust�vel
                                  //14=Duplicata Mercantil
                                  //15=Boleto Banc�rio
                                  //90= Sem pagamento 99=Outros
    aDs.SetCampo('vPag_YA03=0.01'); //Valor do Pagamento
    //Grupo de Cart�es
    aDs.SetCampo('tpIntegra_YA04a=2'); // Tipo de Integra��o para pagamento
    aDs.SetCampo('CNPJ_YA05='); // CNPJ da Credenciadora de cart�o de cr�dito e/ou d�bito
    aDs.SetCampo('tBand_YA06=01'); // Bandeira da operadora de cart�o de cr�dito e/ou d�bito
                                   //01=Visa
                                   //02=Mastercard
                                   //03=American Express
                                   //04=Sorocred
                                   //05=Diners Club
                                   //06=Elo
                                   //07=Hipercard
                                   //08=Aura
                                   //09=Cabal
                                   //99=Outros
    aDs.SetCampo('cAut_YA07=12345678901234567890'); // N�mero de autoriza��o da opera��o cart�o de cr�dito e/ou d�bito
    aDs.SalvarParte('YA');

    aDs.SetCampo('vTroco_YA09=0.00');
  end;


  var i : integer;
begin

  spdNFeDatasetsX.LoteNFe := ''; // Limpa Propriedade que armazena o LOTE de Notas XML geradas

  spdNFeDatasetsX.Incluir;       //Coloca o objeto instanciado em modo de inclus�o

  { chamada das procedures }
  DadosDoNFe(spdNFeDatasetsX);
  DadosDoEmitente(spdNFeDatasetsX);
  DadosDoDestinatario(spdNFeDatasetsX);

  for i := 1 to 1 do   //Experimente aumentar o numero de itera��es para ter mais itens na nota
  begin
    spdNFeDatasetsX.IncluirItem;

    DadosItem(spdNFeDatasetsX, i);

    spdNFeDatasetsX.SalvarItem;
  end;

  DadosTotalizadores(spdNFeDatasetsX);
  DadosTransporte(spdNFeDatasetsX);
  DadosAdicionais(spdNFeDatasetsX);
  DadosCobranca(spdNFeDatasetsX);
  if cbVersao.ItemIndex >= versao_6_0 then
    DadosPagamento(spdNFeDatasetsX);

  spdNFeDatasetsX.Salvar;

  fXmlGerado := spdNFeDatasetsX.LoteNFe;     // pego a nota e passo pra variavel

  memoXml.Text := fXmlGerado;                  //Apresentando o Xml sem assinar no Memo

  edtIdNFe.Text := ObterNotaID(memoXml.Text); // pega o id da nota gerada
end;

//Botao 5 - Assinando o XML Gerado pelo spdNFeDataset
procedure TfrmExemplo.btnAssinaXml_Click(Sender: TObject);
begin           
  if fXmlGerado <> '' then
  begin
    fXmlAssinado := spdNFex.AssinarNota(fXmlGerado);  //Assina o XML que esta armazenado na Variavel fNFe
    memoXml.Text := fXmlAssinado;                      // Mostra o Xml assinado no Memo1
  end
  else
    ShowMessage('Assine o XML!');
end;

//Botao 6 - Envia XML para WebService
procedure TfrmExemplo.btnEnviaXml_Click(Sender: TObject);
begin
  try
    fXmlRetorno := spdNFeX.EnviarNF('0001',fXmlAssinado, False); //Enviando o XmlAssinado

    memoXml.Text := fXmlRetorno;                            //Mostra o Xml de retorno WebService

    edtNroRecibo.Text := ObterNroRecibo(fXmlRetorno);    // Obtendo o numero do recibo do xml de retorno,
  except
    ShowMessage('Erro ao enviar o XML');
  end;

  {Observa��o :
  No m�todo de envio o componente requer dois par�metros (NroDoLote,XmlAssinado)
  Nro do Lote : A responsabilidade de gerar e controlar esse n�mero � exclusiva
              do contribuinte(Leia na pagina 26 do Manual de Integra��o do
              Contribuinte Vers�o2.0.2a T�pico 4.1.1)
  XmlAssinado : Neste par�metro deve passar o XML assinado

  Se o XmlEnviado estiver com a estrutura inv�lida ou dados inv�lidos de
  acordo com o esquema xml,n�o ser� aceito pelo WebService, sendo assim n�o
  obter� o numero do recibo para posteriormente consultar o recebimento do lote.}

  { O metodo UltimoLogEnvio recupera o local e o nome do log de envio (...env-lot.xml)
  e seta para a variavel fXmlEnv arquivo na qual ser� utilizado para gerar o xml do
  destinat�rio juntamente com o arquivo de retorno da consulta do recibo. Veja tamb�m
  o Bot�o7 ConsultaRecibo. Este log ser� utilizado para Gerar/Enviar o XMl do Destinat�rio.

  Os Logs gerados devem ser armazenados num per�odo minimo de 5 anos veja mais na
  pagina68 do Manual de Integra��o do Contribuinte vers�o2.02 }

  if (FileExists(spdNFeX.UltimoLogEnvio)) then
  begin
    Application.CreateForm(TfrmWebBrowser, frmWebBrowser);
    frmWebBrowser.UltimoLogEnvio := spdNFeX.UltimoLogEnvio;
    frmWebBrowser.ShowModal;
    frmWebBrowser.Free;

    fXmlEnv := spdNFeX.UltimoLogEnvio;
  end;
end;

//Botao 7 - Consulta Recibo NFe
procedure TfrmExemplo.btnConsultaRecibo_Click(Sender: TObject);
begin
  if edtNroRecibo.Text = '' then
    MessageDlg('N�o foi gerado o numero do recibo!'+#13#13+'Envie novamente o Xml ou verifique'+#13+'se a estrutura do xml est� v�lido',mtInformation,mbOKCancel,1)
  else
  begin
    memoXml.Text := spdNFeX.ConsultarRecibo(edtNroRecibo.Text); // Consulta o recebimento do Xml enviado
    edtNroProtocolo.Text := ObterNroProtocolo(memoXml.Text);
  end;

  {Observa��o:
  No retorno da consulta do recibo vir� o <cStat>000</cStat> do lote e das notas enviadas
  o desenvolvedor dever� tratar o xml de retorno verificando o cStat do lote e das notas
  caso tenha enviado mais de uma nota no lote o tratamento do xml de retorno deve ser
  individual para cada nota.

  O intervalo entre o envio e a consulta do recibo deve ser equivalente a
  15 Segundos conforme pagina 35 do Manual de Integra��o Item 4.2.3

  A tabela de c�digos de erros e descri��es de mensagens de erros encontra-se a partir
  da p�gina65 do manual de integra��o do contribuinte Item 5.1.1 }


  fXmlConsRec := fDirAplicacao+'Log\'+spdNFeX.UltimoLogConsRecibo; // local+arquivo de consulta do recibo
  { O metodo UltimoLogEnvio recupera o local e o nome do log de envio (...env-lot.xml)
  e seta para a variavel fXmlEnv arquivo na qual ser� utilizado para gerar o xml do
  destinat�rio juntamente com o arquivo de retorno da consulta do recibo. Veja tamb�m
  o Bot�o7 ConsultaRecibo. Este log ser� utilizado para Gerar/Enviar o XMl do Destinat�rio.

  Os Logs gerados devem ser armazenados num per�odo minimo de 5 anos veja mais na
  pagina68 do Manual de Integra��o do Contribuinte vers�o2.02 }
end;

//Botao 8 - Consultar NFe
procedure TfrmExemplo.btnConsultaNFe_Click(Sender: TObject);
begin
  { Consulta o status da NFe no webservice. Este recurso pode ser usado a
    qualquer momento que for necess�rio consultar a nota utilizando a chave
    da NFe como par�metro }
  memoXml.Text := spdNFeX.ConsultarNF(edtIdNFe.Text);
end;

//Botao 9 - Cancelar NFe Evento
procedure TfrmExemplo.btnCancelaNFe_Click(Sender: TObject);
var
  _formEventos: TfrmNFeEventos;
begin
  if Trim(edtNroProtocolo.Text) = EmptyStr then
    MessageDlg('N�o existe protocolo para o cancelamento!'
      +#13#13+'Consulte o recibo novamente ou e certifique que a nota foi aceita.',mtInformation,mbOKCancel,1)
  else
  begin
    _formEventos := TfrmNFeEventos.Create(Self);
    try
      _formEventos.pgNFeEventos.ActivePage := _formEventos.tbsCancelarNFeEvento;
      _formEventos.edtChaveCancelarNFeEvento.Text := edtIdNFe.Text;
      _formEventos.edtProtocoloCancelarNFeEvento.Text := edtNroProtocolo.Text;
      _formEventos.setSpdNFeXEventos(spdNFeX);
      _formEventos.ShowModal;
    finally
      _formEventos.Free;
    end;
  end;
end;

//Botao 10 - Inutilizar Faixa de Numera��o
procedure TfrmExemplo.btnInutilizaNumNFe_Click(Sender: TObject);
var
  _Ano, _Modelo, _Serie, _Ini, _Fim, _Justificativa : string;
begin
  _Ano           := InputBox('NFe', 'Insira o ano da NFe a ser inutilizada', FormatDateTime('YY',date()));
  _Modelo        := InputBox('NFe', 'Insira o modelo da NFe a ser inutilizada', '55');
  _Serie         := InputBox('NFe', 'Insira a s�rie da NFe a ser inutilizada', '1');
  _Ini           := InputBox('NFe', 'Insira o n�mero da NFe inicial a ser inutilizada', '1');
  _Fim           := InputBox('NFe', 'Insira o n�mero da NFe final a ser inutilizada', '1');
  _Justificativa := InputBox('NFe', 'Insira a justificativa (min. 15 caracteres)', 'Exemplo de inutilizacao da NFe');

  memoXml.Text  :=  spdNFex.InutilizarNF('',_Ano,edtCNPJ.Text,_Modelo,_Serie,_Ini,_Fim,_Justificativa);

  {Observa��o:
   Este m�todo ser� respons�vel por receber as solicita��es referentes � inutiliza��o de faixas
   de numera��o de notas fiscais eletr�nicas. Ao receber a solicita��o, o webservice  realiza
   o processamento da solicita��o e devolve o  resultado do processamento para o aplicativo do
   do emitente.                    Leia mais Pagina 45 do manual de integra��o do contribuinte}
end;

//Botao 11 - Visualizar DANFE
procedure TfrmExemplo.btnVisualizaDANFE_Click(Sender: TObject);
begin
  fXmlDanfe := LoadXmlDestinatario(edtIdNFe.Text);
  spdNFeX.VisualizarDanfe('0001',fXmlDanfe, edtModeloRTM.Text); // Visualizando o DANFE

  {Observa��o :
   O m�todo visualizar o danfe possui tr�s par�metros
   1� Parametro = pode ser passado zero
   2� Paranetro = O XmlAssinado
   3� Parametro = Arquivo do danfe que se encontra na pasta \Templates\Danfe\
                  se passar vazio o componente entende que deve ser usado o
                  arquivo modelo.rtm que � o modelo retrato do danfe

  Sendo assim � poss�vel visualizar o danfe somente com o xml assinado sendo assim
  o desenvolvedor dever� tratar o retorno da consulta do recibo e somente permitir
  a impress�o do danfe se o XML da NFe for validada pelo WebService }
end;

//Botao 12 - Imprimir DANFE
procedure TfrmExemplo.btnImprimiDANFE_Click(Sender: TObject);
begin
  fXmlDanfe := LoadXmlDestinatario(edtIdNFe.Text);
  spdNFeX.ImprimirDanfe('0000',fXmlDanfe,edtModeloRTM.Text,'');

  {Observa��o :
   O m�todo imprimir possui quatro par�metros para impress�o do DANFE
   1� Parametro = pode ser passado zero
   2� Paranetro = O XmlAssinado
   3� Parametro = Arquivo do danfe que se encontra na pasta \Templates\Danfe\
                  se passar vazio o componente entende que deve ser usado o
                  arquivo modelo.rtm que � o modelo retrato do danfe
   4� Parametro = O nome da impressora para imprimir direto para impressora desejada

  Sendo assim � poss�vel visualizar o danfe somente com o xml assinado sendo assim
  o desenvolvedor dever� tratar o retorno da consulta do recibo e somente permitir
  a impress�o do danfe se o XML da NFe for validada pelo WebService }
end;

//Botao 13 - Editar DANFE
procedure TfrmExemplo.btnEditaDANFE_Click(Sender: TObject);
begin
  fXmlDanfe := LoadXmlDestinatario(edtIdNFe.Text);
  spdNFeX.EditarModeloDanfe('0001',fXmlDanfe,edtModeloRTM.Text); // Editar o arquivo do .rtm do DANFE

  {Observa��o :
   O m�todo Editar danfe possui tr�s par�metros
   1� Parametro = pode ser passado zero
   2� Paranetro = O XmlAssinado
   3� Parametro = Arquivo do danfe que se encontra na pasta \Templates\Danfe\
                  Se passar vazio o componente entende que deve ser usado o
                  arquivo modelo.rtm que � o modelo retrato do danfe

  Sendo assim � poss�vel editar o layout do danfe somente com o xml assinado.

  O gerador de relat�rio em que se edita o DANFE � o ReportBuilder ao abrir  }
end;

//Botao 14 - Exportar DANFE para (.pdf)
procedure TfrmExemplo.btnExportaDANFE_Click(Sender: TObject);
begin
  fXmlDanfe := LoadXmlDestinatario(edtIdNFe.Text);

  spdNFeX.ExportarDanfe('0001',fXmlDanfe,edtModeloRTM.Text,1,InputBox(Application.Title,'Salvar arquivo em:\n '+fDirAplicacao+'\nComo:', fDirAplicacao+'Danfe.pdf'));

  {Observa��o:
   Este m�todo � um recurso do componente para exporta��o do danfe em formato .pdf.
   No terceiro par�metro pode informar o modelo do danfe retrato/paisagem setando o
   arquivo .rtm da pasta \Templates\Danfe. Se passar o valor vazio para o par�metro
   o componente entender� que deve ser usado o padr�o \Template\Danfe\modelo.rtm  }
end;

{Setando configura��es de email via programa��o}
procedure TfrmExemplo.ConfigEmail(const aEmailDestinatario:string);
begin
  {veja tamb�m como configurar no arquivo nfeConfig.ini}
  with spdNFeX do
  begin
    EmailServidor    := 'mail.exemplo.com.br';
    EmailRemetente   := 'exemplo@tecnospeed.com.br';
    EmailDestinatario:= aEmailDestinatario;
    EmailAssunto     := 'Danfe NFe em anexo';
    EmailUsuario     := 'exemplo@tecnospeed.com.br';
    EmailSenha       := 'senhaexemplo';
  end;
end;

//Botao 15 - Enviar DANFE(.pdf) por email
procedure TfrmExemplo.btnDANFE_Click(Sender: TObject);
begin
  fXmlDanfe := LoadXmlDestinatario(edtIdNFe.Text);
  {Setando configura��es de email via programa��o de um Control+Click para ver
   as configura��es veja tamb�m como configurar no arquivo nfeConfig.ini}

//  ConfigEmail('suporte@tecnospeed.com.br');

  spdNFeX.EnviarEmailDanfe('0001',fXmlDanfe,''); // Envia o arquivo .pdf do danfe

  {Observa��o:
   Este m�todo � um recurso do componente para o envio da danfe no formato pdf no
   email do destinat�rio. Este m�todo requer a configura��o das propriedades de email
   do componente spdNFe, podendo ser setadas via programa��o ou no arquivo nfeConfig.ini.}
end;

//Botao 15 - Enviar XML e DANFE(.pdf) para Destinat�rio
procedure TfrmExemplo.btnEnviaXmlDestinatario_Click(Sender: TObject);
var
  _IDNFe: string;
begin
  {Setando configura��es de email via programa��o de um Control+Click para ver
   as configura��es veja tamb�m como configurar no arquivo nfeConfig.ini}

//Ultimo Log de Envio de NF gerado
  fXmlEnv := spdNFeX.UltimoLogEnvio;
// Ultimo Log de Consulta de Recibo Gerado
  fXmlConsRec := spdNFeX.UltimoLogConsRecibo;

  _IDNFe := ObterNotaID(LoadFile(fXmlEnv));

  spdNFeX.EnviarNotaDestinatario(_IDNFe, fXmlEnv, fXmlConsRec);        //M�todo de envio do XmlDestinat�rio

  {Observa��o:
   Este m�todo gera  o XML do destinatario no formato compat�vel com o software
   visualizador da Receita, exporta o DANFE para o formato .pdf  e envia os arquivos
   anexados para o email do destinat�rio.

      Para que este m�todo funcione corretamente as propriedades de email do componente
   devem estar previamente configuradas no arquivo nfeConfig.ini ou setadas diretamente
   ao componente em tempo de execu��o.}
end;

procedure TfrmExemplo.btnGeraXMLDest_Click(Sender: TObject);
var
  _IDNFe: string;
begin
  //Ultimo Log de Envio de NF gerado
  fXmlEnv := spdNFeX.UltimoLogEnvio;
  // Ultimo Log de Consulta de Recibo Gerado
  fXmlConsRec := spdNFeX.UltimoLogConsRecibo;
  _IDNFe := ObterNotaID(LoadFile(fXmlEnv));

  spdNFeX.GeraXMLEnvioDestinatario(_IDNFe, fXmlEnv, fXmlConsRec, _IDNFe+'.xml');        //M�todo de envio do XmlDestinat�rio

  {Observa��o:
   Este m�todo gera � o XML do destinatario no formato compat�vel com o software
   visualizador da Receita, permitindo que o destinat�rio possa ver o conteudo da
   nota com maior clareza dos dados.


   Para que este m�todo funcione corretamente as propriedades de email do componente
   devem estar previamente configuradas ou no arquivo nfeConfig.ini ou setadas
   diretamente ao componente em tempo de execu��o.

   O XML do destinat�rio � gerado num formato compat�vel com o software visualizador
   da Receita, permitindo que o destinat�rio possa ver o conteudo da nota com maior
   clareza dos dados.}
end;

//Botao 18 - Mostra arqivos de Logs
//Botao 18 - Mostra arqivos de Logs
procedure TfrmExemplo.btnLogs_Click(Sender: TObject);
begin
  { O m�todo LerLog auxilia na leitura dos arquivos de  }
  memoXml.Text := spdNFeX.LerLog(spdNFeX.UltimoLogEnvio);
end;

function TfrmExemplo.LoadXmlDestinatario(const aChave: String): WideString;
var
  _file : TStringList;
  _fileName : String;
begin
  _file := TStringList.Create;
  _fileName := fDirAplicacao + 'XmlDestinatario\' + aChave + '-nfe.xml';
  try
    if Not FileExists(_fileName) then
       raise Exception.CreateFmt('N�o foi encontrado o arquivo: %s. Verifique se a NFe est� Autorizada.', [_fileName]);
    _file.LoadFromFile(_fileName);
    result := _file.Text;
  finally
    _file.Free;
  end;
end;

procedure TfrmExemplo.btnModeloRTMClick(Sender: TObject);
begin
  if oplgModeloRTM.Execute then
    edtModeloRTM.Text := oplgModeloRTM.FileName;
end;

procedure TfrmExemplo.btnManifestarNFeClick(Sender: TObject);
var
  _formEventos: TfrmNFeEventos;
begin
  _formEventos := TfrmNFeEventos.Create(Self);
  try
    _formEventos.pgNFeEventos.ActivePage := _formEventos.tbsManifestacao;
    _formEventos.setSpdNFeXEventos(spdNFeX);
    _formEventos.edtOrgao.Text := GetCodigoUF(cbConfigUF.ItemIndex);
    _formEventos.ShowModal;
  finally
    _formEventos.Free;
  end;
end;

function TfrmExemplo.GetCodigoUF(const aIndexUf: integer): string;
begin
  case aIndexUf of
    0 : Result := '12';//AC
    1 : Result := '27';//AL
    2 : Result := '13';//AM
    3 : Result := '16';//AP
    4 : Result := '29';//BA
    5 : Result := '23';//CE
    6 : Result := '53';//DF
    7 : Result := '32';//ES
    8 : Result := '52';//GO
    9 : Result := '21';//MA
    10 : Result := '31';//MG
    11 : Result := '50';//MS
    12 : Result := '51';//MT
    13 : Result := '15';//PA
    14 : Result := '25';//PB
    15 : Result := '26';//PE
    16 : Result := '22';//PI
    17 : Result := '41';//PR
    18 : Result := '33';//RJ
    19 : Result := '24';//RN
    20 : Result := '11';//RO
    21 : Result := '14';//RR
    22 : Result := '43';//RS
    23 : Result := '42';//SC
    24 : Result := '28';//SE
    25 : Result := '35';//SP
    26 : Result := '17';//TO
  end;
end;

function TfrmExemplo.GetFusoUF(const aIndexUf: integer): string;
begin
  case aIndexUf of
    0 : Result := '-04:00';//AC
    1 : Result := '-03:00';//AL
    2 : Result := '-04:00';//AM
    3 : Result := '-03:00';//AP
    4 : Result := '-03:00';//BA
    5 : Result := '-03:00';//CE
    6 : Result := '-03:00';//DF
    7 : Result := '-03:00';//ES
    8 : Result := '-03:00';//GO
    9 : Result := '-03:00';//MA
    10 : Result := '-03:00';//MG
    11 : Result := '-04:00';//MS
    12 : Result := '-04:00';//MT
    13 : Result := '-03:00';//PA
    14 : Result := '-03:00';//PB
    15 : Result := '-03:00';//PE
    16 : Result := '-03:00';//PI
    17 : Result := '-03:00';//PR
    18 : Result := '-03:00';//RJ
    19 : Result := '-03:00';//RN
    20 : Result := '-04:00';//RO
    21 : Result := '-04:00';//RR
    22 : Result := '-02:00';//RS
    23 : Result := '-03:00';//SC
    24 : Result := '-03:00';//SE
    25 : Result := '-03:00';//SP
    26 : Result := '-03:00';//TO
  end;
end;

procedure TfrmExemplo.cbVersaoExit(Sender: TObject);
begin
  if (cbVersao.ItemIndex = versao_3_0) then
  begin
    spdNFeX.VersaoManual := '3.0';
    spdNFeX.ModeloRetrato := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm30\Danfe\retrato.rtm';
    spdNFeX.ModeloPaisagem := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm30\Danfe\paisagem.rtm';
    spdNFeDatasetsX.VersaoEsquema := 'pl_005d';
    spdNFeDatasetsX.DicionarioXML := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm30\conversor\NFeDataSets.xml';
  end  
  else if (cbVersao.ItemIndex = versao_4_0) then
  begin
    spdNFeX.VersaoManual := '4.0';
    spdNFeX.ModeloRetrato := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm40\Danfe\retrato.rtm';
    spdNFeX.ModeloPaisagem := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm40\Danfe\paisagem.rtm';
    spdNFeDatasetsX.VersaoEsquema := 'pl_006j';
    spdNFeDatasetsX.DicionarioXML := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm40\conversor\NFeDataSets.xml';
  end
  else if (cbVersao.ItemIndex = versao_5_0) then
  begin
    spdNFeX.VersaoManual := '5.0';
    spdNFeX.ModeloRetrato := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm50\Danfe\retrato.rtm';
    spdNFeX.ModeloPaisagem := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm50\Danfe\paisagem.rtm';
    spdNFeDatasetsX.VersaoEsquema := 'pl_006j';
    spdNFeDatasetsX.DicionarioXML := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm50\conversor\NFeDataSets.xml';
  end  
  else if (cbVersao.ItemIndex = versao_5_0a) then
  begin
    spdNFeX.VersaoManual := '5.0a';
    spdNFeX.ModeloRetrato := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm50a\Danfe\retrato.rtm';
    spdNFeX.ModeloPaisagem := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm50a\Danfe\paisagem.rtm';
    spdNFeDatasetsX.VersaoEsquema := 'pl_006g';
    spdNFeDatasetsX.DicionarioXML := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm50a\conversor\NFeDataSets.xml';
  end
  else if (cbVersao.ItemIndex = versao_6_0) then
  begin
    spdNFeX.VersaoManual := '6.0';
    spdNFeX.ModeloRetrato := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm60\Danfe\retrato.rtm';
    spdNFeX.ModeloPaisagem := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm60\Danfe\paisagem.rtm';
    spdNFeDatasetsX.VersaoEsquema := 'pl_009';
    spdNFeDatasetsX.DicionarioXML := 'C:\Program Files\TecnoSpeed\NFe\arquivos\Templates\Vm60\conversor\NFeDataSets.xml';
  end;
end;

procedure TfrmExemplo.LoadListaCertificados;
var
  i : Integer;
  _Certificados:WideString;
  _Cert : String;
begin
   { Listando os nomes dos certificados e separando pelo delimitador pipe }
  _Certificados := spdNFeX.ListarCertificados('|');

  //Limpa conteudo do Listbox
  lstCertificados.Items.Clear;

  for i := 1 to Length(_Certificados) do
  begin
    if Copy(_Certificados, i,1) = '|' then
    begin
      lstCertificados.Items.Add(_Cert);
      _Cert := '';
    end
    else
      _Cert := _Cert + Copy(_Certificados, i,1);
  end;
end;

procedure TfrmExemplo.btnDistribuicaoDFeClick(Sender: TObject);
var
  _frmDistribuicaoDFe : TfrmDistribuicaoDFe;
begin
  _frmDistribuicaoDFe := TfrmDistribuicaoDFe.Create(nil);
  try
    _frmDistribuicaoDFe.fCnpjSoftwareHouse := fCnpjSoftwareHouse;
    _frmDistribuicaoDFe.ShowModal;
  finally
    _frmDistribuicaoDFe.Free;
  end;
end;

procedure TfrmExemplo.btnImportacaoXmlNFeClick(Sender: TObject);
var
  frmImportacaoXmlNFe : TfrmImportacaoXmlNFe;
begin
  frmImportacaoXmlNFe := TfrmImportacaoXmlNFe.Create(nil);
  try
    frmImportacaoXmlNFe.fCnpjSoftwareHouse := fCnpjSoftwareHouse;
    frmImportacaoXmlNFe.ShowModal;
  finally
    frmImportacaoXmlNFe.Free;
  end;
end;

end.


