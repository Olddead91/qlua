offer = getParamEx("TQBR", "GAZP", "OFFER").param_value
bid = getParamEx("TQBR", "GAZP", "BID").param_value
change = getParamEx("TQBR", "GAZP", "CHANGE").param_value	
lastchange = getParamEx("TQBR", "GAZP", "LASTCHANGE").param_value
numoffers = getParamEx("TQBR", "GAZP", "NUMOFFERS").param_value
numbids = getParamEx("TQBR", "GAZP", "NUMBIDS").param_value
wprice  = getParamEx("TQBR", "GAZP", "WAPRICE").param_value

message("������ ���� ����������� OFFER: "..offer)
message("������ ���� ������ BID: "..bid)
message("������� ���� ��������� ������ � ���������� ������ CHANGE: "..change) 
message("% ��������� �� �������� LASTCHANGE: "..lastchange)
message("���������� ������ �� ������� NUMOFFERS: "..numoffers)
message("���������� ������ �� ������� NUMBIDS: "..numbids)
message("���������������� ���� WAPRICE: "..wprice)
 

 