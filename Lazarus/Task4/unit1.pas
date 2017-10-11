unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TaboutProgram }

  TaboutProgram = class(TForm)
    NameAndVersion: TLabel;
    Description: TLabel;
    aboutAuthor: TLabel;
    procedure NameAndVersionClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  aboutProgram: TaboutProgram;

implementation

{$R *.lfm}

{ TaboutProgram }

procedure TaboutProgram.NameAndVersionClick(Sender: TObject);
begin

end;

end.

