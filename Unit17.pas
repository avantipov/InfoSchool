unit Unit17;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids;

type
  TRegistrationTask = class(TForm)
    Background: TImage;
    L_ModuleName: TLabel;
    L_University: TLabel;
    Info: TEdit;
    L_Info: TLabel;
    L_InfoRuk: TLabel;
    Name: TEdit;
    RegistrTask: TButton;
    T_RegistrationTask: TDBGrid;
    Query_Task: TADOQuery;
    DS: TDataSource;
    Insert: TADOQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RegistrTaskClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegistrationTask: TRegistrationTask;
   a:integer;
implementation

{$R *.dfm}

uses Unit1, Unit2;

procedure TRegistrationTask.FormActivate(Sender: TObject);
begin
Name.Text:=MainForm.AuthDS1.DataSet.FindField('Сокр_имя').AsString;
end;

procedure TRegistrationTask.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
RegistrationTask.Hide;
MenuChoice.show;
end;

procedure TRegistrationTask.RegistrTaskClick(Sender: TObject);
begin
if (Info.Text='')or (Name.Text='') then
showmessage('Обнаружены незаполненные поля')
  else
  begin
  try
  Insert.Close;
  Insert.SQL.Clear;
  Insert.SQL.Add('SELECT * FROM Сотрудники WHERE Сокр_имя ='''+Name.Text+''';');
  Insert.Open;
  a:=Insert.Fields[0].Asinteger;
  Insert.Close;
  Insert.SQL.Clear;
  Insert.SQL.Add('INSERT INTO Приказ(Информация,ИД_сотрудника)');
  Insert.SQL.Add('VALUES(:a,'+inttostr(a)+');');
  Insert.Parameters.ParamByName('a').Value:=Info.Text;
  Insert.ExecSQL;
  Query_task.Close;
  Query_task.Open;
  finally
  showmessage('Приказ зарегистрирован!');
  Info.Text:='';
  end;
  end;
end;

end.
