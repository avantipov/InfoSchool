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
    SpecialtyСode: TListBox;
    L_ModuleName: TLabel;
    L_TDiplomas: TLabel;
    T_Diplomas: TDBGrid;
    Query_Diplomas: TADOQuery;
    DS_Diplomas: TDataSource;
    L_University: TLabel;
    Insert: TADOQuery;
    procedure SpecialtyСodeClick(Sender: TObject);
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

procedure TRegisterDiplomas.SpecialtyСodeClick(Sender: TObject);
begin
if SpecialtyСode.Selected[0]= true then
Specialty.Text:='Техник по компьютерным системам';
if SpecialtyСode.Selected[1]= true then
Specialty.Text:='Техник-программист';
if SpecialtyСode.Selected[2]= true then
Specialty.Text:='Техник-программист';
if SpecialtyСode.Selected[3]= true then
Specialty.Text:='Техник по защите информации';
if SpecialtyСode.Selected[4]= true then
Specialty.Text:='Специалист по земельно-имущественным отношениям';
if SpecialtyСode.Selected[5]= true then
Specialty.Text:='Специалист по рекламе';
end;

procedure TRegisterDiplomas.RegisterDiplomClick(Sender: TObject);
begin
if MenuChoice.username.Caption='Александров Р.В.'
then
  if  (Series.Text ='') or (Number.Text='') or (Date.Text ='') or (Surname.Text='') or (Name.Text='') or (MiddleName.Text='') or (Specialty.Text='')
  then
  showmessage('Ошибка №3.Обязательные поля не заполнены')
  else
  begin
    RegisterDiplomas.Insert.Close;
    RegisterDiplomas.Insert.SQL.Clear;
    RegisterDiplomas.Insert.SQL.Add('INSERT INTO Дипломы([Серия диплома],[Номер диплома],[Дата выдачи],Фамилия,Имя,Отчество,Специальность,Квалификация,Номер_приказа)');
    RegisterDiplomas.Insert.SQL.Add('VALUES ('+Series.text+','+Number.Text+','''+Date.text+''',');
    RegisterDiplomas.Insert.SQL.Add(''''+Surname.Text+''','''+Name.Text+''','''+MiddleName.Text+'''');
    RegisterDiplomas.Insert.SQL.Add(','''+SpecialtyСode.Items[SpecialtyСode.ItemIndex]+''','''+Specialty.text+''',');
    RegisterDiplomas.Insert.SQL.Add(''''+T_Diplomas.DataSource.DataSet.Fields.Fields[0].AsString+''');');
    //showmessage(RegisterDiplomas.Insert.SQL.Text);
    RegisterDiplomas.Insert.ExecSQL;
    showmessage('Диплом успешно зарегистрирован!');
    end
else
showmessage('Ошибка №2.Недостаточно прав доступа!');
end;

end.
