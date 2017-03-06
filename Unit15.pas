unit Unit15;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,ComObj, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.Win.ADODB;

type
  TMethodicalCabinet = class(TForm)
    Background: TImage;
    L_ModuleName: TLabel;
    T_methodicalcabinet: TDBGrid;
    Discipline: TEdit;
    L_Discipline: TLabel;
    L_Teacher: TLabel;
    Teacher: TEdit;
    L_Date: TLabel;
    Date: TEdit;
    Loading: TButton;
    AddMaterial: TButton;
    OpenDialog1: TOpenDialog;
    filenametext: TEdit;
    L_FilenameText: TLabel;
    Query_MethodicalCabinet: TADOQuery;
    DS: TDataSource;
    L_University: TLabel;
    procedure LoadingClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddMaterialClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MethodicalCabinet: TMethodicalCabinet;

implementation

{$R *.dfm}

uses Unit2;

procedure TMethodicalCabinet.AddMaterialClick(Sender: TObject);
begin
if (Discipline.Text='') or (Teacher.Text='') or (Date.Text='') then
showmessage('Обнаружены незаполненные поля')
else
begin
  try
  Query_MethodicalCabinet.close;
  Query_MethodicalCabinet.SQL.Clear;
  Query_MethodicalCabinet.SQL.Add('INSERT INTO Методкабинет(Автор,Предмет,[Дата сдачи],Принял)');
  Query_MethodicalCabinet.SQL.Add('VALUES(:a2,:a1,:a3,:a4);');
  Query_MethodicalCabinet.Parameters.ParamByName('a1').Value:=Discipline.Text;
  Query_MethodicalCabinet.Parameters.ParamByName('a2').Value:=Teacher.Text;
  Query_MethodicalCabinet.Parameters.ParamByName('a3').Value:=Date.Text;
  Query_MethodicalCabinet.Parameters.ParamByName('a4').Value:=MenuChoice.username.Caption;
  Query_MethodicalCabinet.ExecSQL;
  Query_MethodicalCabinet.close;
  Query_MethodicalCabinet.SQL.Clear;
  Query_MethodicalCabinet.SQL.Add('SELECT *');
  Query_MethodicalCabinet.SQL.Add('FROM Методкабинет;');
  Query_MethodicalCabinet.open;
  finally
  Showmessage('Информация внесена!');
  Discipline.Text:='';
  Teacher.Text:='';
  Date.Text:='';
  end;
  end;
end;

procedure TMethodicalCabinet.LoadingClick(Sender: TObject);
var
  Excel:Variant;
  i:integer;
  v1:string;
  v2:string;
  row:integer;
  filename:string;
begin
 row:=30;
  try
      Excel := CreateOleObject('Excel.Application');//---создаем объект Excel и запускаем его
    except
      raise Exception.Create('Ошибка запуска Excel');
    end;
   filename:=Filenametext.text;
  Excel.Workbooks.Open['D:\Новая папка (2)\InfoCollegeD\Методический кабинет\'+filename+'.xlsx'];
  for i:=2 to row do
     begin
      v1:=Excel.ActiveWorkbook.ActiveSheet.Range['D20'];
      v2:=Excel.ActiveWorkbook.ActiveSheet.Range['D34'];
     end;
 Discipline.Text:=v1;
 Teacher.Text:=v2;
 Excel.Visible := False;
 Excel.Visible := True;
end;
procedure TMethodicalCabinet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
methodicalcabinet.hide;
Menuchoice.show;

end;

end.

