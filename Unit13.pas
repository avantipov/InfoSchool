unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TTable = class(TForm)
    Background: TImage;
    L_University: TLabel;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Period: TEdit;
    Label3: TLabel;
    Dobavit: TButton;
    Tabel: TADOQuery;
    DS: TDataSource;
    Label4: TLabel;
    Fam: TEdit;
    Time: TEdit;
    Label5: TLabel;
    procedure DobavitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Table: TTable;
   a:integer;
implementation

{$R *.dfm}

uses Unit10, Unit2;

procedure TTable.DobavitClick(Sender: TObject);
begin
if (Fam.Text='') or (Period.Text='') or (Time.Text='') then
showmessage('���������� ������������ ����')
else
  begin
  try
  Teacher.Query_Teacher.Close;
  Teacher.Query_Teacher.sql.Clear;
  Teacher.Query_Teacher.SQL.Add('SELECT ��,�������,���,��������');
  Teacher.Query_Teacher.SQL.Add('FROM �������������');
  Teacher.Query_Teacher.SQL.Add('WHERE ������� =:k;');
  Teacher.Query_Teacher.Parameters.ParamByName('k').Value:=Fam.Text;
  Teacher.Query_Teacher.open;
  a:=Teacher.DS.DataSet.FindField('��').AsInteger;
  Teacher.Query_Teacher.Close;
  Teacher.Query_Teacher.sql.Clear;
  Teacher.Query_Teacher.SQL.Add('INSERT INTO ������(��,������,����������)');
  Teacher.Query_Teacher.SQL.Add('VALUES(:b,:c,:d);');
  Teacher.Query_Teacher.Parameters.ParamByName('b').Value:=a;
  Teacher.Query_Teacher.Parameters.ParamByName('c').Value:=Period.Text;
  Teacher.Query_Teacher.Parameters.ParamByName('d').Value:=Time.Text;
  //showmessage(Form10.Teacher.SQL.Text);
  Teacher.Query_Teacher.execsql;
  Table.Tabel.Close;
  Table.Tabel.Open;

  finally
  showmessage('������ ���������!');
  Fam.Text:='';
  Period.Text:='';
  Time.Text:='';
  end;
  end;
end;

procedure TTable.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Table.Hide;
MenuChoice.show;
end;

end.
