unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB,ComObj;

type
  TAdmissionCommittee = class(TForm)
    L_ModuleName: TLabel;
    L_Surname: TLabel;
    L_Name: TLabel;
    L_MiddleName: TLabel;
    L_Information1: TLabel;
    L_Information3: TLabel;
    L_Information7: TLabel;
    L_FullName: TLabel;
    Surname: TEdit;
    Name: TEdit;
    MiddleName: TEdit;
    Temp: TEdit;
    Fullname: TEdit;
    PrintCard: TButton;
    SaveDialog1: TSaveDialog;
    Query_Register: TADOQuery;
    L_University: TLabel;
    Background: TImage;
    L_Temp: TLabel;
    Label1: TLabel;
    Nos: TEdit;
    Diag: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Pharm: TEdit;
    Label4: TLabel;
    FK: TEdit;
    procedure PrintCardClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdmissionCommittee: TAdmissionCommittee;
  sr:integer;
  sb:real;
  pred:integer;
implementation

{$R *.dfm}




procedure TAdmissionCommittee.PrintCardClick(Sender: TObject);
 const
  wdAlignParagraphCenter = 1;
  wdAlignParagraphLeft = 0;
  wdAlignParagraphRight = 2;
var
  wdApp, wdDoc, wdRng : Variant;
  Res : Integer;
  Sd : TSaveDialog;
begin
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
wdRng.InsertBefore('ЕДИНАЯ ИНФОРМАЦИОННАЯ СИСТЕМА "ИНФОРМАЦИОННАЯ ШКОЛА"');
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 18;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
wdRng.InsertAfter(#13#10);
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
wdRng.InsertBefore('МЕДИЦИНСКИЙ КАБИНЕТ ');
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 18;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
wdRng.InsertAfter(#13#10);
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
wdRng.InsertBefore(' '+Surname.text+'  '+Name.text+'  '+MiddleName.text+'');
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := False;
wdRng.Font.Size := 14;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter(#13#10);
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
wdRng.InsertBefore('Осмотрен медсестрой');
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 18;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
wdRng.InsertAfter(#13#10);
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
wdRng.InsertAfter('Температура:'+Temp.text+'');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('Носоглотка:'+Nos.text+'');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('Диагноз (предварительный):'+Diag.text+'');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('Выданы лекарства:'+Pharm.text+'');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('Освобождение от физнагрузки:'+FK.text+'');
wdRng.InsertAfter(#13#10);
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := False;
wdRng.Font.Size := 14;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;;
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('Медсестра ОУ:'+FullName.text+'_______________');
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := False;
wdRng.Font.Size := 14;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;;
wdRng.Start := wdRng.End;
wdRng.ParagraphFormat.Reset;
wdRng.Font.Reset;
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

end.
