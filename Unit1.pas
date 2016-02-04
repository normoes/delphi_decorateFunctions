unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

// function's type definition
// 1. example: simply decorating with ShowMessage(...)
  TMyFunc_Ref = reference to procedure();
// 2. example: passing a parameter
  TMyFunc_Ref1 = reference to procedure(aValue : String; aMemo : TMemo);

//functions to be decorated
// 1. example: simply decorating with ShowMessage(...)
  procedure sayHello();
// 2. example: passing a parameter
  procedure sayHello1(aValue : String; aMemo : TMemo);

// anonymous method is defined as Result of the function
// --> the function returned is the decorated original function
// (--> can be decoreated n times)
// 1. example
  function sayHello_Decorator_Who(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
  function sayHello_Decorator_When(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
// 2. example
  function sayHello_Decorator1(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
  function sayHello_Decorator2(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
end;

// 1. example: simply decorating with ShowMessage(...)
procedure TForm1.Button1Click(Sender: TObject);
var
  aFunc : TMyFunc_Ref;
begin
  Memo1.Clear;
//  sayHello();
  aFunc := nil;
  aFunc := sayHello_Decorator_Who(sayHello);
//  aFunc();
  aFunc := sayHello_Decorator_When(aFunc);
  // calling the double decorated procedure
  aFunc();
end;

procedure sayHello();
begin
  ShowMessage('hello');
end;

function sayHello_Decorator_Who(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
begin
  Result := procedure()
    begin
      aMyFunc_Ref();
      showMessage('in decorator added at this beginning:'+sLinebreak+' ''out there''');
    end;
end;

function sayHello_Decorator_When(aMyFunc_Ref : TMyFunc_Ref):TMyFunc_Ref;
begin
  Result := procedure()
    begin
      aMyFunc_Ref();
      showMessage('in decorator added at the end:'+sLinebreak+' ''at this beautiful time of this day''');
    end;
end;

// 2. example: passing a parameter
procedure TForm1.Button2Click(Sender: TObject);
var
  aFunc : TMyFunc_Ref1;
begin
  Memo1.Clear;
  sayHello1('calling the procedure itself', Memo1);
  Memo1.Lines.Add('------------');
  aFunc := nil;
  aFunc := sayHello_Decorator1(sayHello1);
//  aFunc('1 --> ');
  aFunc := sayHello_Decorator2(aFunc);
  // calling the double decorated procedure
  aFunc('Hello', Memo1);
end;

procedure sayHello1(aValue : String; aMemo : TMemo);
begin
  if ( Assigned(aMemo) ) then
  begin
    aMemo.Lines.add(sLineBreak);
    aMemo.Lines.add(aValue);
    aMemo.Lines.add(sLineBreak);
  end
  else
    ShowMessage('no graphical component for output:'+sLineBreak+aValue);
end;

function sayHello_Decorator1(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
begin
  Result := procedure(aValue : String = ''; aMemo : TMemo = nil)
    begin
      if ( Assigned(aMemo) ) then
      begin
        aMemo.Lines.Add('  --> logging: in decorator added at the beginning');
        aMemo.Lines.Add('  -->          calling the decorated procedure with ''at this beautiful time of the day''');
      end;
      aMyFunc_Ref(aValue + ' ''at this beautiful time of the day''', aMemo);
      if ( Assigned(aMemo) ) then
      begin
        aMemo.Lines.Add('  --> logging: in decorator added at the beginning');
        aMemo.Lines.Add('  -->          after calling the procedure');
      end;
    end;
end;

function sayHello_Decorator2(aMyFunc_Ref : TMyFunc_Ref1):TMyFunc_Ref1;
begin
  Result := procedure(aValue : String = ''; aMemo : TMemo = nil)
    begin
      if ( Assigned(aMemo) ) then
      begin
        aMemo.Lines.Add('  --> logging: in decorator added at the end');
        aMemo.Lines.Add('  -->          calling the decorated procedure with ''out there''');
      end;
      aMyFunc_Ref(aValue + ' ''out there''', aMemo);
      if ( Assigned(aMemo) ) then
      begin
        aMemo.Lines.Add('  --> logging: in decorator added at the end');
        aMemo.Lines.Add('  -->          after calling the procedure');
      end;
    end;
end;

end.
