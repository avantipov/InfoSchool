unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids,ComObj;

type
  Tworkload = class(TForm)
    L_workload: TLabel;
    T_Workload: TDBGrid;
    Query_workload: TADOQuery;
    DS1: TDataSource;
    Generate: TButton;
    L_University: TLabel;
    Background: TImage;
    SaveDialog1: TSaveDialog;
    CaseVersion: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GenerateClick(Sender: TObject);
    procedure CaseVersionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  workload: Tworkload;
  num_rows, num_columns:integer;
implementation

{$R *.dfm}

uses Unit2, Unit1;

procedure Tworkload.GenerateClick(Sender: TObject);
const
  wdAlignParagraphCenter = 1;
  wdAlignParagraphLeft = 0;
  wdAlignParagraphRight = 2;
   wdLineStyleSingle = 1;
    var
  table:variant;
wdApp, wdDoc, wdRng, wdTable : Variant;
  i, j, Res : Integer;
  D : TDateTime;
  Bm : TBookMark;
  Sd : TSaveDialog;
begin
num_rows:=0;
num_columns:=0;
 Sd :=SaveDialog1; //SaveDialog1 уже должен быть на форме.
  //Если начальная папка диалога не задана, то в качестве начальной берём ту папку,
  //в которой расположен исполняемый файл нашей программы.
  if Sd.InitialDir = '' then Sd.InitialDir := ExtractFilePath( ParamStr(0) );
  //Запуск диалога сохранения файла.
  if not Sd.Execute then Exit;
  //Если файл с заданным именем существует, то запускаем диалог с пользователем.
  if FileExists(Sd.FileName) then begin
    Res := MessageBox(0, 'Файл с заданным именем уже существует. Перезаписать?'
      ,'Внимание!', MB_YESNO + MB_ICONQUESTION + MB_APPLMODAL);
    if Res <> IDYES then Exit;
  end;
   //Попытка запустить MS Word.
  try
    wdApp := CreateOleObject('Word.Application');
  except
    MessageBox(0, 'Не удалось запустить MS Word. Действие отменено.'
      ,'Внимание!', MB_OK + MB_ICONERROR + MB_APPLMODAL);
    Exit;
  end;
   //На время отладки делаем видимым окно MS Word.
  wdApp.Visible := True; //После отладки: wdApp.Visible := False;
  //Создаём новый документ.
  wdDoc := wdApp.Documents.Add;
  //Отключение перерисовки окна MS Word, если wdApp.Visible := True.
  //Для ускорения обработки в случае больших текстов.
  wdApp.ScreenUpdating := False;

try
wdRng := wdDoc.Content; //Диапазон, охватывающий всё содержимое документа.
wdRng.InsertAfter(''+MainForm.INFO.Fields[0].AsString+'');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter(''+MainForm.INFO.Fields[2].AsString+'');
wdRng.InsertAfter(#13#10);
wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 14;
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
finally
end;
try
wdRng.Start := wdRng.End;
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('ПРИКАЗ');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('«____»________ _______ г.                        №______________');
wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
wdRng.InsertAfter(#13#10);
wdRng.Font.Bold := True;
wdRng.Font.Size := 18;
wdRng.Start := wdRng.End;
 wdRng.ParagraphFormat.Reset;
    wdRng.Font.Reset;
finally
end;
try
wdRng.Start := wdRng.End;
wdRng.InsertAfter('«Утверждение нагрузки преподавателей»');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter(#13#10);
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := False;
wdRng.Font.Size := 12;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter('В связи с началом нового учебного года.');
wdRng.Font.Bold := False;
wdRng.Font.Size := 14;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('ПРИКАЗЫВАЮ:');
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter(#13#10);
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 18;
wdRng.InsertAfter('1.Установить следующую педагогическую нагрузку с 01.09.______ года.');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter(#13#10);
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 14;
wdRng.Start := wdRng.End;
 wdRng.ParagraphFormat.Reset;
    wdRng.Font.Reset;
finally
end;
  try
    if not Query_workload.Active then Query_workload.Open;
    begin
    wdRng.InsertAfter(#13#10);
    //Добавляем таблицу MS Word. Пока создаём таблицу с двумя строками.
    wdTable := wdDoc.Tables.Add(wdRng.Characters.Last, 2, Query_workload.Fields.Count);
    //Параметры линий таблицы.
    wdTable.Borders.InsideLineStyle := wdLineStyleSingle;
    wdTable.Borders.OutsideLineStyle := wdLineStyleSingle;
    //Сброс параметров параграфа.
    wdRng.ParagraphFormat.Reset;
    //Выравнивание всей таблицы - по левому краю.
    wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
    //Оформление шапки.
    wdRng := wdTable.Rows.Item(1).Range; //Диапазон первой строки.
    wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
    wdRng.Font.Size := 14;
    wdRng.Font.Bold := True;
    //Оформление первой строки данных - это вторая строка в таблице.
    //При добавлении следующих строк, их оформление будет копироваться с этой строки.
    wdRng := wdTable.Rows.Item(2).Range; //Диапазон второй строки.
    wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
    wdRng.Font.Size := 14;
    wdRng.Font.Bold := False;
    //Записываем шапку таблицы
    end;
    for i := 0 to Query_workload.Fields.Count - 1 do
      wdTable.Cell(1, i + 1).Range.Text := Query_workload.Fields[i].DisplayName;
    //Записываем данные таблицы.
    Query_workload.DisableControls;
    Bm := Query_workload.GetBookMark;
    Query_workload.First;
    i:= 1;
     //Текущая строка в таблице MS Word.
    while not Query_workload.Eof do begin
      Inc(i);
      //Если требуется, добавляем новую строку в конец таблицы.
      if i > 2 then wdTable.Rows.Add;
      //Записываем данные в строку таблицы MS Word.
      for j := 0 to Query_workload.Fields.Count - 1 do
        wdTable.Cell(i, j + 1).Range.Text := Query_workload.Fields[j].AsString;
      Query_workload.Next;
    end;
    Query_workload.GotoBookMark(Bm);
    Query_workload.EnableControls;

     finally
  wdRng := wdDoc.Range.Characters.Last;;
  end;
  try
  wdRng.InsertAfter(#13#10);
  wdRng.InsertAfter(#13#10);
  wdRng.InsertAfter(#13#10);
  wdRng.InsertAfter('Директор колледжа                              '+MainForm.INFO.Fields[3].AsString+'');
  wdRng.Font.Bold := true;
  wdRng.Font.Size := 16;
  wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
  wdRng.Start := wdRng.End;
  finally
  //Включение перерисовки окна MS Word. В случае, если wdApp.Visible := True.
    wdApp.ScreenUpdating := True;
  end;
  //Отключаем режим показа предупреждений.
  wdApp.DisplayAlerts := False;
  try
    //Запись документа в файл.
    wdDoc.SaveAs(FileName:=Sd.FileName);
  finally
    //Включаем режим показа предупреждений.
    wdApp.DisplayAlerts := True;
  end;

  //Отключено на время отладки:

  //Закрываем документ.
  //wdDoc.Close;
  //Закрываем MS Word.
  //wdApp.Quit;
 end;
procedure Tworkload.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Workload.Hide;
MenuChoice.show;
end;

procedure Tworkload.CaseVersionClick(Sender: TObject);
begin
case CaseVersion.ItemIndex of
0: begin
Query_workload.close;
Query_workload.SQL.clear;
Query_workload.SQL.Add('SELECT *');
Query_workload.SQL.Add('FROM Преподаватели');
Query_workload.SQL.Add('ORDER BY Фамилия;');
Query_workload.open;
T_workload.ReadOnly:=false;
end;
1:  begin
Query_workload.close;
Query_workload.SQL.clear;
Query_workload.SQL.Add('SELECT Фамилия,Имя,Отчество,[Годовая нагрузка]');
Query_workload.SQL.Add('FROM Преподаватели');
Query_workload.SQL.Add('ORDER BY Фамилия;');
Query_workload.open;
T_workload.ReadOnly:=true;
end;
end;
end;
end.
