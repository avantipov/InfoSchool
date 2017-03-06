unit Unit16;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.Win.ADODB;

type
  TRegistInfo = class(TForm)
    Background: TImage;
    L_ModuleName: TLabel;
    L_Surname: TLabel;
    L_Name: TLabel;
    L_MiddleName: TLabel;
    Surname: TEdit;
    Name: TEdit;
    Middlename: TEdit;
    RegistrationInfo: TButton;
    L_Group: TLabel;
    Group: TEdit;
    DBGrid1: TDBGrid;
    Insert_Info: TADOQuery;
    DS: TDataSource;
    Query_RegistInfo: TADOQuery;
    L_University: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RegistrationInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegistInfo: TRegistInfo;

implementation

{$R *.dfm}

uses Unit2;

procedure TRegistInfo.RegistrationInfoClick(Sender: TObject);
begin
if (Surname.Text='') OR (Name.Text='') OR (MiddleName.Text='') OR (Group.Text='')  then
showmessage('Обнаружены незаполненные поля')
  else
  begin
    try
    Insert_info.Close;
    Insert_info.SQL.Clear;
    Insert_info.SQL.Add('INSERT INTO ЖС(Фамилия,Имя,Отчество,Группа)');
    Insert_info.SQL.Add('VALUES (:a,:b,:c,:d);');
    Insert_info.Parameters.ParamByName('a').Value:=Surname.Text;
    Insert_info.Parameters.ParamByName('b').Value:=Name.Text;
    Insert_info.Parameters.ParamByName('c').Value:=MiddleName.Text;
    Insert_info.Parameters.ParamByName('d').Value:=Group.Text;
    Insert_info.ExecSQL;
    Query_RegistInfo.Close;
    Query_RegistInfo.open;
    Surname.Text:='';
    Name.Text:='';
    MiddleName.Text:='';
    Group.Text:='';
    finally

    end;
  end;
end;

procedure TRegistInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
RegistInfo.Hide;
MenuChoice.show;
end;

end.
