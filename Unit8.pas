unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
 ComObj, Vcl.Imaging.jpeg;

type
  TMenuGenerate = class(TForm)
    L_ModuleName: TLabel;
    L_University: TLabel;
    L_Surname: TLabel;
    L_Name: TLabel;
    Generate: TButton;
    SaveDialog1: TSaveDialog;
    Background: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure handbookClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuGenerate: TMenuGenerate;
  a:string;

implementation

{$R *.dfm}

uses Unit2, Unit6, Unit1;



procedure TMenuGenerate.handbookClick(Sender: TObject);
begin
Generate.hide;
RegisterStudent.show;
end;

procedure TMenuGenerate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Generate.Hide;
MenuChoice.show;
end;




end.
