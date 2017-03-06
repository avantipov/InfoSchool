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

try
wdRng := wdDoc.Content; //��������, ������������ �� ���������� ���������.
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
wdRng.InsertAfter('������');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('�____�________ _______ �.                        �______________');
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
wdRng.InsertAfter('������������ �������� ��������������');
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter(#13#10);
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := False;
wdRng.Font.Size := 12;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter('� ����� � ������� ������ �������� ����.');
wdRng.Font.Bold := False;
wdRng.Font.Size := 14;
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter(#13#10);
wdRng.InsertAfter('����������:');
wdRng.ParagraphFormat.Alignment := wdAlignParagraphLeft;
wdRng.InsertAfter(#13#10);
wdRng.Font.Name := 'Times New Roman';
wdRng.Font.Bold := True;
wdRng.Font.Size := 18;
wdRng.InsertAfter('1.���������� ��������� �������������� �������� � 01.09.______ ����.');
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
    //��������� ������� MS Word. ���� ������ ������� � ����� ��������.
    wdTable := wdDoc.Tables.Add(wdRng.Characters.Last, 2, Query_workload.Fields.Count);
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
    for i := 0 to Query_workload.Fields.Count - 1 do
      wdTable.Cell(1, i + 1).Range.Text := Query_workload.Fields[i].DisplayName;
    //���������� ������ �������.
    Query_workload.DisableControls;
    Bm := Query_workload.GetBookMark;
    Query_workload.First;
    i:= 1;
     //������� ������ � ������� MS Word.
    while not Query_workload.Eof do begin
      Inc(i);
      //���� ���������, ��������� ����� ������ � ����� �������.
      if i > 2 then wdTable.Rows.Add;
      //���������� ������ � ������ ������� MS Word.
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
  wdRng.InsertAfter('�������� ��������                              '+MainForm.INFO.Fields[3].AsString+'');
  wdRng.Font.Bold := true;
  wdRng.Font.Size := 16;
  wdRng.ParagraphFormat.Alignment := wdAlignParagraphCenter;
  wdRng.Start := wdRng.End;
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

  //��������� �� ����� �������:

  //��������� ��������.
  //wdDoc.Close;
  //��������� MS Word.
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
Query_workload.SQL.Add('FROM �������������');
Query_workload.SQL.Add('ORDER BY �������;');
Query_workload.open;
T_workload.ReadOnly:=false;
end;
1:  begin
Query_workload.close;
Query_workload.SQL.clear;
Query_workload.SQL.Add('SELECT �������,���,��������,[������� ��������]');
Query_workload.SQL.Add('FROM �������������');
Query_workload.SQL.Add('ORDER BY �������;');
Query_workload.open;
T_workload.ReadOnly:=true;
end;
end;
end;
end.
