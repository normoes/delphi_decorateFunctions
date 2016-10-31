# delphi_decorateFunctions
how to decoratre functions using anonymous methods

 -  declare a type for passing a function as a parameter (TFuncType)
	e.g.: TFuncType = reference to procedure(aValue:Stirng);
 -  write function with a  parameter of type TFuncType
 -  this funtion has a result of type TFuncType
 -  within the function an anonymous function is defined and assigned as result
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
