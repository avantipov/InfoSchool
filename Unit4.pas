unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DBCtrls, DB, ADODB, Grids, DBGrids;

type
  TRegisterDiplomas = class(TForm)
    RegisterDiplom: TButton;
    Background: TImage;
    L_Series: TLabel;
    Series: TEdit;
    L_number: TLabel;
    Number: TEdit;
    L_Date: TLabel;
    Date: TEdit;
    L_Surname: TLabel;
    L_Name: TLabel;
    L_MiddleName: TLabel;
    Surname: TEdit;
    Name: TEdit;
    MiddleName: TEdit;
    L_SpecialtyCode: TLabel;
    L_Specialty: TLabel;
    Specialty: TEdit;
    Specialty�ode: TListBox;
    L_ModuleName: TLabel;
    L_TDiplomas: TLabel;
    T_Diplomas: TDBGrid;
    Query_Diplomas: TADOQuery;
    DS_Diplomas: TDataSource;
    L_University: TLabel;
    Insert: TADOQuery;
    procedure Specialty�odeClick(Sender: TObject);
    procedure RegisterDiplomClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegisterDiplomas: TRegisterDiplomas;

implementation

uses Unit1,unit2;

{$R *.dfm}



procedure TRegisterDiplomas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
RegisterDiplomas.Hide;
MenuChoice.Show;
end;

procedure TRegisterDiplomas.Specialty�odeClick(Sender: TObject);
begin
if Specialty�ode.Selected[0]= true then
Specialty.Text:='������ �� ������������ ��������';
if Specialty�ode.Selected[1]= true then
Specialty.Text:='������-�����������';
if Specialty�ode.Selected[2]= true then
Specialty.Text:='������-�����������';
if Specialty�ode.Selected[3]= true then
Specialty.Text:='������ �� ������ ����������';
if Specialty�ode.Selected[4]= true then
Specialty.Text:='���������� �� ��������-������������� ����������';
if Specialty�ode.Selected[5]= true then
Specialty.Text:='���������� �� �������';
end;

procedure TRegisterDiplomas.RegisterDiplomClick(Sender: TObject);
begin
if MenuChoice.username.Caption='����������� �.�.'
then
  if  (Series.Text ='') or (Number.Text='') or (Date.Text ='') or (Surname.Text='') or (Name.Text='') or (MiddleName.Text='') or (Specialty.Text='')
  then
  showmessage('������ �3.������������ ���� �� ���������')
  else
  begin
    RegisterDiplomas.Insert.Close;
    RegisterDiplomas.Insert.SQL.Clear;
    RegisterDiplomas.Insert.SQL.Add('INSERT INTO �������([����� �������],[����� �������],[���� ������],�������,���,��������,�������������,������������,�����_�������)');
    RegisterDiplomas.Insert.SQL.Add('VALUES ('+Series.text+','+Number.Text+','''+Date.text+''',');
    RegisterDiplomas.Insert.SQL.Add(''''+Surname.Text+''','''+Name.Text+''','''+MiddleName.Text+'''');
    RegisterDiplomas.Insert.SQL.Add(','''+Specialty�ode.Items[Specialty�ode.ItemIndex]+''','''+Specialty.text+''',');
    RegisterDiplomas.Insert.SQL.Add(''''+T_Diplomas.DataSource.DataSet.Fields.Fields[0].AsString+''');');
    //showmessage(RegisterDiplomas.Insert.SQL.Text);
    RegisterDiplomas.Insert.ExecSQL;
    showmessage('������ ������� ���������������!');
    end
else
showmessage('������ �2.������������ ���� �������!');
end;

end.
