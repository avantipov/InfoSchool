unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB;

type
  TRegisterStudent = class(TForm)
    BackGround: TImage;
    L_ModuleName: TLabel;
    T_RegisterStudent: TDBGrid;
    AddStudent: TButton;
    Search: TEdit;
    L_Search: TLabel;
    Query_RegisterStudent: TADOQuery;
    DS_RegisterStudent: TDataSource;
    Update: TButton;
    Generate: TButton;
    L_University: TLabel;
    procedure SearchChange(Sender: TObject);
    procedure AddStudentClick(Sender: TObject);
    procedure UpdateClick(Sender: TObject);
    procedure T_RegisterStudentEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegisterStudent: TRegisterStudent;

implementation

{$R *.dfm}

uses Unit2,Unit1, Unit8;


procedure TRegisterStudent.GenerateClick(Sender: TObject);
begin
RegisterStudent.hide;;
MenuGenerate.show;
MenuGenerate.Generate.Visible:=true;

end;

procedure TRegisterStudent.AddStudentClick(Sender: TObject);
begin
Query_RegisterStudent.Close;
Query_RegisterStudent.SQL.clear;
Query_RegisterStudent.SQL.Add('INSERT INTO Студенты(Фамилия,Имя,Отчество,ИД_группы)');
Query_RegisterStudent.SQL.Add('VALUES (NULL,NULL,NULL,0);');
Query_RegisterStudent.ExecSQL;
Query_RegisterStudent.Close;
Query_RegisterStudent.SQL.clear;
Query_RegisterStudent.SQL.Add('SELECT ИД_студента AS [Код студента],Фамилия, Имя, Отчество, Студенты.ИД_группы as [Номер группы],Специальность');
Query_RegisterStudent.SQL.Add('FROM Группа INNER JOIN Студенты ON Группа.ИД_группы=Студенты.ИД_группы');
Query_RegisterStudent.SQL.Add('ORDER BY ИД_Студента;');
Query_RegisterStudent.Open;
end;

procedure TRegisterStudent.UpdateClick(Sender: TObject);
begin
Query_RegisterStudent.Close;
Query_RegisterStudent.SQL.clear;
Query_RegisterStudent.SQL.Add('SELECT ИД_студента AS [Код студента],Фамилия, Имя, Отчество, Студенты.ИД_группы as [Номер группы],Специальность');
Query_RegisterStudent.SQL.Add('FROM Группа INNER JOIN Студенты ON Группа.ИД_группы=Студенты.ИД_группы');
Query_RegisterStudent.SQL.Add('ORDER BY ИД_Студента;');
Query_RegisterStudent.Open;
end;


procedure TRegisterStudent.T_RegisterStudentEnter(Sender: TObject);
begin
Query_RegisterStudent.Close;
Query_RegisterStudent.SQL.clear;
Query_RegisterStudent.SQL.Add('SELECT ИД_студента AS [Код студента],Фамилия, Имя, Отчество, Студенты.ИД_группы as [Номер группы],Специальность');
Query_RegisterStudent.SQL.Add('FROM Группа INNER JOIN Студенты ON Группа.ИД_группы=Студенты.ИД_группы');
Query_RegisterStudent.SQL.Add('ORDER BY ИД_Студента;');
Query_RegisterStudent.Open;
end;

procedure TRegisterStudent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
RegisterStudent.Hide;
MenuChoice.Show;
end;

procedure TRegisterStudent.SearchChange(Sender: TObject);
begin
Query_RegisterStudent.Close;
Query_RegisterStudent.SQL.clear;
Query_RegisterStudent.SQL.Add('SELECT ИД_студента AS [Код студента],Фамилия, Имя, Отчество, Студенты.ИД_группы as [Номер группы],Специальность');
Query_RegisterStudent.SQL.Add('FROM Группа INNER JOIN Студенты ON Группа.ИД_группы=Студенты.ИД_группы');
Query_RegisterStudent.SQL.Add('WHERE Фамилия LIKE '''+Search.Text+'%'';');
//showmessage(ADOQuery1.SQL.Text);
Query_RegisterStudent.Open;
end;

end.
