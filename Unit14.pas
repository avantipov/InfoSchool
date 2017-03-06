unit Unit14;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TTaskBook = class(TForm)
    Background: TImage;
    Label1: TLabel;
    L_University: TLabel;
    DBGrid1: TDBGrid;
    KrInf: TEdit;
    Zadacha: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    InFam: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    InImya: TEdit;
    InOtch: TEdit;
    IsFam: TEdit;
    IsImya: TEdit;
    IsOtch: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Dobavit: TButton;
    Query_TaskJournal: TADOQuery;
    DS: TDataSource;
    Button1: TButton;
    Query_Information: TADOQuery;
    DS2: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure DobavitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TaskBook: TTaskBook;

implementation

{$R *.dfm}

uses Unit2;

procedure TTaskBook.Button1Click(Sender: TObject);
begin
try
if InFam.Text='%' then
  if InImya.Text='%' then
   if InOtch.Text='%' then
    if IsFam.Text='%' then
      if IsImya.Text='%' then
        if IsOtch.Text='%' then
          if Krinf.Text='%' then
            if Zadacha.Text='%' then
            begin
            showmessage('Автозаполнение прошло успешно!');
            TaskBook.Query_Information.Close;
            TaskBook.Query_Information.sql.Clear;
            TaskBook.Query_Information.SQL.Add('SELECT ИД_сотр,Фамилия,Имя,Отчество');
            TaskBook.Query_Information.SQL.Add('FROM Сотрудники');
            TaskBook.Query_Information.SQL.Add('WHERE Фамилия =:k;');
            TaskBook.Query_Information.Parameters.ParamByName('k').Value:=InFam.Text;
            TaskBook.Query_Information.open;
            InImya.Text:=DS2.DataSet.FindField('Имя').AsString;
            InOtch.Text:=DS2.DataSet.FindField('Отчество').AsString;
            Query_Information.Close;
            Query_Information.sql.Clear;
            Query_Information.SQL.Add('SELECT ИД_сотр,Фамилия,Имя,Отчество');
            Query_Information.SQL.Add('FROM Сотрудники');
            Query_Information.SQL.Add('WHERE Фамилия =:a;');
            Query_Information.Parameters.ParamByName('a').Value:=IsFam.Text;
            Query_Information.open;
            IsImya.Text:=DS2.DataSet.FindField('Имя').AsString;
            IsOtch.Text:=DS2.DataSet.FindField('Отчество').AsString;
            end
except
showmessage('Невозможно записать поручение.Проверьте введеные данные');
end;
end;

procedure TTaskBook.DobavitClick(Sender: TObject);
begin
try
if InFam.Text='%' then
  if InImya.Text='%' then
   if InOtch.Text='%' then
    if IsFam.Text='%' then
      if IsImya.Text='%' then
        if IsOtch.Text='%' then
          if Krinf.Text='%' then
            if Zadacha.Text='%' then
            begin
            TaskBook.Query_TaskJournal.Close;
            Query_TaskJournal.SQL.clear;
            Query_TaskJournal.SQL.Add('INSERT INTO ЖП(ИФ,ИИ,ИО,КИ,З,ИФ1,ИИ1,ИО1)');
            Query_TaskJournal.SQL.Add('VALUES('''+InFam.Text+''','''+InImya.Text+''','''+InOtch.Text+''','''+KrInf.Text+''','''+Zadacha.Text+''','''+IsFam.Text+''','''+IsImya.text+''','''+IsOtch.Text+''');');
            Query_TaskJournal.ExecSQL;
            Query_TaskJournal.Close;
            Query_TaskJournal.SQL.Clear;
            Query_TaskJournal.SQL.Add('SELECT * FROM ЖП;');
            Query_TaskJournal.Open;
            showmessage('Поручение зарегистрировано!');
            end
except
showmessage('Невозможно записать поручение.Проверьте введеные данные');
end;



end;

procedure TTaskBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TaskBook.Hide;
MenuChoice.show;
end;

end.
