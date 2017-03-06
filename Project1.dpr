program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {MainForm},
  Unit2 in 'Unit2.pas' {MenuChoice},
  Unit3 in 'Unit3.pas' {Information},
  Unit4 in 'Unit4.pas' {RegisterDiplomas},
  Unit5 in 'Unit5.pas' {AdmissionCommittee},
  Unit6 in 'Unit6.pas' {RegisterStudent},
  Unit8 in 'Unit8.pas' {MenuGenerate},
  Unit9 in 'Unit9.pas' {workload},
  Unit10 in 'Unit10.pas' {Teacher},
  Unit11 in 'Unit11.pas' {JournalReplacment},
  Unit12 in 'Unit12.pas' {JornalReplace},
  Unit13 in 'Unit13.pas' {Table},
  Unit14 in 'Unit14.pas' {TaskBook},
  Unit15 in 'Unit15.pas' {MethodicalCabinet},
  Unit16 in 'Unit16.pas' {RegistInfo},
  Unit17 in 'Unit17.pas' {RegistrationTask};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ЕИС "Информационный колледж"';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TMenuChoice, MenuChoice);
  Application.CreateForm(TInformation, Information);
  Application.CreateForm(TRegisterDiplomas, RegisterDiplomas);
  Application.CreateForm(TAdmissionCommittee, AdmissionCommittee);
  Application.CreateForm(TRegisterStudent, RegisterStudent);
  Application.CreateForm(TMenuGenerate, MenuGenerate);
  Application.CreateForm(Tworkload, workload);
  Application.CreateForm(TTeacher, Teacher);
  Application.CreateForm(TJournalReplacment, JournalReplacment);
  Application.CreateForm(TJornalReplace, JornalReplace);
  Application.CreateForm(TTable, Table);
  Application.CreateForm(TTaskBook, TaskBook);
  Application.CreateForm(TMethodicalCabinet, MethodicalCabinet);
  Application.CreateForm(TRegistInfo, RegistInfo);
  Application.CreateForm(TRegistrationTask, RegistrationTask);
  Application.Run;
end.
