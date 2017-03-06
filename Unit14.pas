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
            showmessage('�������������� ������ �������!');
            TaskBook.Query_Information.Close;
            TaskBook.Query_Information.sql.Clear;
            TaskBook.Query_Information.SQL.Add('SELECT ��_����,�������,���,��������');
            TaskBook.Query_Information.SQL.Add('FROM ����������');
            TaskBook.Query_Information.SQL.Add('WHERE ������� =:k;');
            TaskBook.Query_Information.Parameters.ParamByName('k').Value:=InFam.Text;
            TaskBook.Query_Information.open;
            InImya.Text:=DS2.DataSet.FindField('���').AsString;
            InOtch.Text:=DS2.DataSet.FindField('��������').AsString;
            Query_Information.Close;
            Query_Information.sql.Clear;
            Query_Information.SQL.Add('SELECT ��_����,�������,���,��������');
            Query_Information.SQL.Add('FROM ����������');
            Query_Information.SQL.Add('WHERE ������� =:a;');
            Query_Information.Parameters.ParamByName('a').Value:=IsFam.Text;
            Query_Information.open;
            IsImya.Text:=DS2.DataSet.FindField('���').AsString;
            IsOtch.Text:=DS2.DataSet.FindField('��������').AsString;
            end
except
showmessage('���������� �������� ���������.��������� �������� ������');
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
            Query_TaskJournal.SQL.Add('INSERT INTO ��(��,��,��,��,�,��1,��1,��1)');
            Query_TaskJournal.SQL.Add('VALUES('''+InFam.Text+''','''+InImya.Text+''','''+InOtch.Text+''','''+KrInf.Text+''','''+Zadacha.Text+''','''+IsFam.Text+''','''+IsImya.text+''','''+IsOtch.Text+''');');
            Query_TaskJournal.ExecSQL;
            Query_TaskJournal.Close;
            Query_TaskJournal.SQL.Clear;
            Query_TaskJournal.SQL.Add('SELECT * FROM ��;');
            Query_TaskJournal.Open;
            showmessage('��������� ����������������!');
            end
except
showmessage('���������� �������� ���������.��������� �������� ������');
end;



end;

procedure TTaskBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TaskBook.Hide;
MenuChoice.show;
end;

end.
