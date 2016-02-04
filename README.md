# delphi_decorateFunctions
how to decoratre functions using anonymous methods

1) declare a type for passing a function as a parameter (TFuncType)
	e.g.: TFuncType = reference to procedure(aValue:Stirng);
2) write function with a  parameter of type TFuncType
3) this funtion has a result of type TFuncType
4) within the function an anonymous function is defined and assigned as result
	e.g.:
    function decoratorFunc(aFunc: TFuncType):TFuncType;
    begin
	Result := procedure(aValue:String)
		begin
		    // do something before
		    aFunc();
		    // do something after
		end;
    end;
