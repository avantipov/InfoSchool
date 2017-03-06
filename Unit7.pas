unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls,ComObj;

type
  TRating = class(TForm)
    Background: TImage;
    L_ModuleName: TLabel;
    Specialty: TListBox;
    L_Specialty: TLabel;
    Generate: TButton;
    Print: TButton;
    Query_Rating: TADOQuery;
    DS_Rating: TDataSource;
    T_Rating: TDBGrid;
    L_University: TLabel;
    SaveDialog1: TSaveDialog;
    procedure GenerateClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rating: TRating;
num_rows, num_columns:integer;
implementation

{$R *.dfm}

uses Unit2;

procedure TRating.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Rating.Hide;
MenuChoice.show;
end;

procedure TRating.GenerateClick(Sender: TObject);
begin
Query_Rating.Close;
Query_Rating.SQL.Clear;
Query_Rating.SQL.Add('SELECT [Средний балл],Фамилия,Имя,Отчество,Специальность FROM ПК ');
Query_Rating.SQL.Add('WHERE Специальность=:P1');
Query_Rating.SQL.Add('ORDER BY [Средний балл] DESC;');
Query_Rating.Parameters.ParamByName('P1').Value:=Specialty.Items[Specialty.ItemIndex];
//showmessage(ADOQuery1.SQL.Text);
Query_Rating.Open;
end;

procedure TRating.PrintClick(Sender: TObject);
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
  wdRng := wdDoc.Content;
  try
    if not Query_Rating.Active then Query_Rating.Open;
    begin
    //Добавляем таблицу MS Word. Пока создаём таблицу с двумя строками.
    wdTable := wdDoc.Tables.Add(wdRng.Characters.Last, 2, Query_Rating.Fields.Count);
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
    for i := 0 to Query_Rating.Fields.Count - 1 do
      wdTable.Cell(1, i + 1).Range.Text := Query_Rating.Fields[i].DisplayName;
    //Записываем данные таблицы.
    Query_Rating.DisableControls;
    Bm := Query_Rating.GetBookMark;
    Query_Rating.First;
    i:= 1;
     //Текущая строка в таблице MS Word.
    while not Query_Rating.Eof do begin
      Inc(i);
      //Если требуется, добавляем новую строку в конец таблицы.
      if i > 2 then wdTable.Rows.Add;
      //Записываем данные в строку таблицы MS Word.
      for j := 0 to Query_Rating.Fields.Count - 1 do
        wdTable.Cell(i, j + 1).Range.Text := Query_Rating.Fields[j].AsString;
      Query_Rating.Next;
    end;
    Query_Rating.GotoBookMark(Bm);
    Query_Rating.EnableControls;
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
end;
end.
