unit Unit12;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TJornalReplace = class(TForm)
    Background: TImage;
    L_University: TLabel;
    Label9: TLabel;
    FO: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    FZ: TEdit;
    IO: TEdit;
    IZ: TEdit;
    OO: TEdit;
    OZ: TEdit;
    Disp: TEdit;
    KCH: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    AutoD: TButton;
    InsertTab: TButton;
    Label10: TLabel;
    InsertJZ: TADOQuery;
    procedure AutoDClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InsertTabClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  JornalReplace: TJornalReplace;

implementation

{$R *.dfm}

uses Unit10, Unit11;

procedure TJornalReplace.AutoDClick(Sender: TObject);
begin
Teacher.Query_Teacher.close;
Teacher.Query_Teacher.sql.Clear;
Teacher.Query_Teacher.SQL.Add('SELECT ИД,Фамилия,Имя,Отчество');
Teacher.Query_Teacher.SQL.Add('FROM Преподаватели');
Teacher.Query_Teacher.SQL.Add('WHERE Фамилия =:k;');
Teacher.Query_Teacher.Parameters.ParamByName('k').Value:=FO.Text;
Teacher.Query_Teacher.open;
IO.Text:=Teacher.DS.DataSet.FindField('Имя').AsString;
OO.Text:=Teacher.DS.DataSet.FindField('Отчество').AsString;
Teacher.Query_Teacher.Close;
Teacher.Query_Teacher.sql.Clear;
Teacher.Query_Teacher.SQL.Add('SELECT ИД,Фамилия,Имя,Отчество');
Teacher.Query_Teacher.SQL.Add('FROM Преподаватели');
Teacher.Query_Teacher.SQL.Add('WHERE Фамилия =:a;');
Teacher.Query_Teacher.Parameters.ParamByName('a').Value:=FZ.Text;
Teacher.Query_Teacher.open;
IZ.Text:=Teacher.DS.DataSet.FindField('Имя').AsString;
OZ.Text:=Teacher.DS.DataSet.FindField('Отчество').AsString;
showmessage('Автозаполнение прошло успешно!');
end;

procedure TJornalReplace.FormClose(Sender: TObject; var Action: TCloseAction);
begin
JornalReplace.Hide;
JournalReplacment.show;
end;

procedure TJornalReplace.InsertTabClick(Sender: TObject);
begin
if (FO.Text='') or (IO.Text='') or (OO.Text='') or (FZ.Text='') or (IZ.Text='') or (OZ.Text='') or (Disp.Text='') or (KCH.Text='') then
showmessage('Обнаружены незаполенные поля')
else
  begin
  try
  InsertJZ.Close;
  InsertJZ.SQL.Clear;
  InsertJZ.SQL.Add('INSERT INTO ЖЗ(ФО,ИО,ОО,ФЗ,ИЗ,ОЗ,Дисциплина,[Кол-во часов])');
  InsertJZ.SQL.Add('VALUES('''+FO.Text+''','''+IO.Text+''','''+OO.Text+''','''+FZ.text+''','''+IZ.text+''','''+OZ.Text+''','''+Disp.Text+''','''+KCH.Text+''');');
  //showmessage(InsertJZ.SQL.Text);
  InsertJZ.ExecSQL;
  JournalReplacment.Query_Journalreplacement.Close;
  JournalReplacment.Query_Journalreplacement.open;
  finally
  showmessage('Информация зарегистрирована');
  FO.Text:='';
  IO.Text:='';
  OO.Text:='';
  FZ.Text:='';
  IZ.Text:='';
  OZ.Text:='';
  Disp.Text:='';
  KCH.Text:='';
  end;
  end;
end;

end.
