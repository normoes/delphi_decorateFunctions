unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMyFunc_Ref = reference to procedure();
  TMyFunc_Ref1 = reference to procedure(aValue : String);

function sayHello_Decorator_Who(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
function sayHello_Decorator_When(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
function sayHello_Decorator1(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
function sayHello_Decorator2(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
procedure sayHello();
procedure sayHello1(aValue : String);

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  aFunc : TMyFunc_Ref;
  aFunc1 : TMyFunc_Ref1;
begin
//  sayHello();
  aFunc := nil;
  aFunc := sayHello_Decorator_Who(sayHello);
//  aFunc();
  aFunc := sayHello_Decorator_When(aFunc);
  aFunc();

  aFunc1 := nil;
  aFunc1 := sayHello_Decorator1(sayHello1);
//  aFunc1('1 --> ');
  aFunc1 := sayHello_Decorator2(aFunc1);
  aFunc1('2 --> ');
end;

function sayHello_Decorator_Who(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
begin
  Result := procedure()
    begin
      aMyFunc_Ref();
      showMessage('out there');
    end;
end;

function sayHello_Decorator_When(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
begin
  Result := procedure()
    begin
      aMyFunc_Ref();
      showMessage('at this beautiful time of teh day');
    end;
end;

procedure sayHello();
begin
  ShowMessage('hello');
end;


// overlaoded versions --> generic versions
procedure sayHello1(aValue : String);
begin
  ShowMessage(aValue);
end;

function sayHello_Decorator1(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
begin
  Result := procedure(aValue : String = '')
    begin
      aMyFunc_Ref(aValue + ' out there');
    end;
end;

function sayHello_Decorator2(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
begin
  Result := procedure(aValue : String = '')
    begin
      aMyFunc_Ref(aValue + ' at this beautiful time of the day');
    end;
end;

end.
