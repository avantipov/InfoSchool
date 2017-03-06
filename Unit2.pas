unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, jpeg, ExtCtrls;

type
  TMenuChoice = class(TForm)
    L_Username: TLabel;
    username: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    L_University: TLabel;
    Background: TImage;
    Calendar: TMonthCalendar;
    procedure N7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N10Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuChoice: TMenuChoice;

implementation
    uses unit1,unit3, Unit4, Unit5, Unit7, Unit8, Unit6, Unit9, Unit10, Unit11,
  Unit13, Unit14, Unit15, Unit16, Unit17;
{$R *.dfm}

procedure TMenuChoice.N7Click(Sender: TObject);
begin
MenuChoice.Hide;
Information.show;
end;

procedure TMenuChoice.N8Click(Sender: TObject);
begin
MenuChoice.hide;
MainForm.show;
MainForm.Login.text:='';
MainForm.Password.text:='';
end;

procedure TMenuChoice.N9Click(Sender: TObject);
begin
MenuChoice.hide;
TaskBook.show;
end;

procedure TMenuChoice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
MenuChoice.Hide;
MainForm.Show;
end;

procedure TMenuChoice.N10Click(Sender: TObject);
begin
MenuChoice.Hide;
RegisterDiplomas.show;
end;

procedure TMenuChoice.N11Click(Sender: TObject);
begin
MenuChoice.hide;
RegistInfo.show;
end;

procedure TMenuChoice.N12Click(Sender: TObject);
begin
MenuChoice.hide;
RegistrationTask.show;
end;

procedure TMenuChoice.N13Click(Sender: TObject);
begin
MenuChoice.hide;
Teacher.show;
end;

procedure TMenuChoice.N14Click(Sender: TObject);
begin
MenuChoice.hide;
Workload.show;
end;

procedure TMenuChoice.N15Click(Sender: TObject);
begin
MenuChoice.hide;
Journalreplacment.show;
end;

procedure TMenuChoice.N16Click(Sender: TObject);
begin
MenuChoice.hide;
Table.show;
end;

procedure TMenuChoice.N17Click(Sender: TObject);
begin
MenuChoice.Hide;
AdmissionCommittee.show;
end;

procedure TMenuChoice.N18Click(Sender: TObject);
begin
MenuChoice.Hide;
Rating.show;
end;

procedure TMenuChoice.N19Click(Sender: TObject);
begin
MenuChoice.Hide;
MenuGenerate.show;
end;

procedure TMenuChoice.N20Click(Sender: TObject);
begin
MenuChoice.hide;
RegisterStudent.show;
end;

procedure TMenuChoice.N4Click(Sender: TObject);
begin
Menuchoice.hide;
methodicalcabinet.show;
end;

end.
