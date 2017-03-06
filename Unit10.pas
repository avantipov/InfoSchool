unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids;

type
  TTeacher = class(TForm)
    Background: TImage;
    L_University: TLabel;
    L_ModuleName: TLabel;
    T_Teacher: TDBGrid;
    AddTeacher: TButton;
    DeleteTeacher: TButton;
    Query_Teacher: TADOQuery;
    DS: TDataSource;
    Query_DeleteTeacher: TADOQuery;
    procedure AddTeacherClick(Sender: TObject);
    procedure DeleteTeacherClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Teacher: TTeacher;
implementation

{$R *.dfm}

uses Unit2;

procedure TTeacher.AddTeacherClick(Sender: TObject);
begin
Query_Teacher.close;
Query_Teacher.SQL.Clear;
Query_Teacher.SQL.Add('INSERT INTO Преподаватели (Фамилия,Имя,Отчество)');
Query_Teacher.SQL.Add('VALUES (NULL,NULL,NULL);');
Query_Teacher.ExecSQL;
Query_Teacher.close;
Query_Teacher.SQL.Clear;
Query_Teacher.SQL.Add('SELECT ИД,Фамилия,Имя,Отчество,КК');
Query_Teacher.SQL.Add('FROM Преподаватели');
Query_Teacher.SQL.Add('ORDER BY Фамилия');
Query_Teacher.open;

end;

procedure TTeacher.DeleteTeacherClick(Sender: TObject);
begin
Query_Teacher.close;
Query_Teacher.SQL.Clear;
Query_Teacher.SQL.Add('DELETE FROM Преподаватели');
Query_Teacher.SQL.Add('WHERE ИД ='+inttostr(T_Teacher.Fields[0].AsInteger)+';');
Query_Teacher.ExecSQL;
Query_Teacher.Close;
Query_Teacher.Open;
end;

procedure TTeacher.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Teacher.Hide;
MenuChoice.show;
end;

end.
