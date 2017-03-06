unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Vcl.StdCtrls;

type
  TInformation = class(TForm)
    Background: TImage;
    L_Info3: TLabel;
    L_NameProgram: TLabel;
    L_University: TLabel;
    L_Info1: TLabel;
    L_Info2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Information: TInformation;

implementation
  uses unit2;
{$R *.dfm}

procedure TInformation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Information.Hide;
MenuChoice.show;
end;

end.
