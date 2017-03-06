unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TJournalReplacment = class(TForm)
    Background: TImage;
    L_JournalReplacment: TLabel;
    T_JournalReplacment: TDBGrid;
    Add: TButton;
    Query_Journalreplacement: TADOQuery;
    DS: TDataSource;
    L_University: TLabel;
    procedure AddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  JournalReplacment: TJournalReplacment;

implementation

{$R *.dfm}

uses Unit12;

procedure TJournalReplacment.AddClick(Sender: TObject);
begin
JournalReplacment.hide;
JornalReplace.Show;
end;

end.
