unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DB, ADODB;

type
  TMainForm = class(TForm)
    Background: TImage;
    ProgramName: TLabel;
    L_University: TLabel;
    L_Auth: TLabel;
    Login: TEdit;
    Password: TEdit;
    L_Login: TLabel;
    L_Pass: TLabel;
    Auth: TButton;
    DB: TADOConnection;
    Query_Auth: TADOQuery;
    AuthDS1: TDataSource;
    INFO: TADOQuery;
    procedure AuthClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses Unit2, Unit4, Unit5, Unit6, Unit10, Unit11, Unit12, Unit13, Unit14, Unit15,
  Unit16, Unit8, Unit17;

{$R *.dfm}

procedure TMainForm.AuthClick(Sender: TObject);
begin
Query_Auth.Close;
Query_Auth.SQL.Clear;
Query_Auth.SQL.Add('SELECT *');
Query_Auth.SQL.Add('FROM Сотрудники INNER JOIN Должности ON Сотрудники.ИД_должности=Должности.ИД_должности');
Query_Auth.SQL.Add('WHERE Логин=:P1');
Query_Auth.SQL.Add('AND Пароль=:P2;');
Query_Auth.Parameters.ParamByName('P1').Value:=Login.Text;
Query_Auth.Parameters.ParamByName('P2').Value:=Password.Text;
Query_Auth.Open;
//showmessage(ADOQuery1.SQL.text);
if Query_Auth.RecordCount = 1 then
begin
MainForm.Hide;
MenuChoice.show;
MenuChoice.username.Caption:=AuthDS1.DataSet.FindField('Сокр_имя').AsString;
end
else
showmessage('Ошибка №1.Обнаруженая неправильная пара логин/пароль');
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
L_University.caption:=INFO.Fields[0].AsString;
MenuChoice.L_University.caption:=INFO.Fields[0].AsString;
MenuGenerate.L_University.caption:=INFO.Fields[0].AsString;
RegisterDiplomas.L_University.caption:=INFO.Fields[0].AsString;
AdmissionCommittee.L_University.caption:=INFO.Fields[0].AsString;
RegisterStudent.L_University.caption:=INFO.Fields[0].AsString;
Teacher.L_University.caption:=INFO.Fields[0].AsString;
JournalReplacment.L_University.caption:=INFO.Fields[0].AsString;
JornalReplace.L_University.caption:=INFO.Fields[0].AsString;
Table.L_University.caption:=INFO.Fields[0].AsString;
TaskBook.L_University.caption:=INFO.Fields[0].AsString;
MethodicalCabinet.L_University.caption:=INFO.Fields[0].AsString;
RegistInfo.L_University.caption:=INFO.Fields[0].AsString;
RegistrationTask.L_University.caption:=INFO.Fields[0].AsString;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

end.
