unit saveOrNotForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TExitWithSave }

  TExitWithSave = class(TForm)
    yes: TButton;
    No: TButton;
    Label1: TLabel;
    procedure NoClick(Sender: TObject);
    procedure yesClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ExitWithSave: TExitWithSave;

implementation

{$R *.lfm}

{ TExitWithSave }

procedure TExitWithSave.yesClick(Sender: TObject);
begin

end;

procedure TExitWithSave.NoClick(Sender: TObject);
begin

end;

end.

