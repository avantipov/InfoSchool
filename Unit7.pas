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
Query_Rating.SQL.Add('SELECT [������� ����],�������,���,��������,������������� FROM �� ');
Query_Rating.SQL.Add('WHERE �������������=:P1');
Query_Rating.SQL.Add('ORDER BY [������� ����] DESC;');
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
 Sd :=SaveDialog1; //SaveDialog1 ��� ������ ���� �� �����.
  //���� ��������� ����� ������� �� ������, �� � �������� ��������� ���� �� �����,
  //� ������� ���������� ����������� ���� ����� ���������.
  if Sd.InitialDir = '' then Sd.InitialDir := ExtractFilePath( ParamStr(0) );
  //������ ������� ���������� �����.
  if not Sd.Execute then Exit;
  //���� ���� � �������� ������ ����������, �� ��������� ������ � �������������.
  if FileExists(Sd.FileName) then begin
    Res := MessageBox(0, '���� � �������� ������ ��� ����������. ������������?'
      ,'��������!', MB_YESNO + MB_ICONQUESTION + MB_APPLMODAL);
    if Res <> IDYES then Exit;
  end;
   //������� ��������� MS Word.
  try
    wdApp := CreateOleObject('Word.Application');
  except
    MessageBox(0, '�� ������� ��������� MS Word. �������� ��������.'
      ,'��������!', MB_OK + MB_ICONERROR + MB_APPLMODAL);
    Exit;
  end;
   //�� ����� ������� ������ ������� ���� MS Word.
  wdApp.Visible := True; //����� �������: wdApp.Visible := False;
  //������ ����� ��������.
  wdDoc := wdApp.Documents.Add;
  //���������� ����������� ���� MS Word, ���� wdApp.Visible := True.
  //��� ��������� ��������� � ������ ������� �������.
  wdApp.ScreenUpdating := False;
  wdRng := wdDoc.Content;
  try
    if not Query_Rating.Active then Query_Rating.Open;
    begin
    //��������� ������� MS Word. ���� ������ ������� � ����� ��������.
    wdTable := wdDoc.Tables.Add(wdRng.Characters.Last, 2, Query_Rating.Fields.Count);
    //��������� ����� �������.
    wdTable.Borders.InsideLineStyle := wdLineStyleSingle;
    wdTable.Borders.OutsideLineStyle := wdLineStyleSingle;
    //����� ���������� ���������.
    wdRng.ParagraphFormat.Reset;
    //������������ ���� ������� - �� ������ ����.
    wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
    //���������� �����.
    wdRng := wdTable.Rows.Item(1).Range; //�������� ������ ������.
    wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
    wdRng.Font.Size := 14;
    wdRng.Font.Bold := True;
    //���������� ������ ������ ������ - ��� ������ ������ � �������.
    //��� ���������� ��������� �����, �� ���������� ����� ������������ � ���� ������.
    wdRng := wdTable.Rows.Item(2).Range; //�������� ������ ������.
    wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
    wdRng.Font.Size := 14;
    wdRng.Font.Bold := False;
    //���������� ����� �������
    end;
    for i := 0 to Query_Rating.Fields.Count - 1 do
      wdTable.Cell(1, i + 1).Range.Text := Query_Rating.Fields[i].DisplayName;
    //���������� ������ �������.
    Query_Rating.DisableControls;
    Bm := Query_Rating.GetBookMark;
    Query_Rating.First;
    i:= 1;
     //������� ������ � ������� MS Word.
    while not Query_Rating.Eof do begin
      Inc(i);
      //���� ���������, ��������� ����� ������ � ����� �������.
      if i > 2 then wdTable.Rows.Add;
      //���������� ������ � ������ ������� MS Word.
      for j := 0 to Query_Rating.Fields.Count - 1 do
        wdTable.Cell(i, j + 1).Range.Text := Query_Rating.Fields[j].AsString;
      Query_Rating.Next;
    end;
    Query_Rating.GotoBookMark(Bm);
    Query_Rating.EnableControls;
   finally
  //��������� ����������� ���� MS Word. � ������, ���� wdApp.Visible := True.
    wdApp.ScreenUpdating := True;
  end;
  //��������� ����� ������ ��������������.
  wdApp.DisplayAlerts := False;
  try
    //������ ��������� � ����.
    wdDoc.SaveAs(FileName:=Sd.FileName);
  finally
    //�������� ����� ������ ��������������.
    wdApp.DisplayAlerts := True;
  end;
end;
end.
