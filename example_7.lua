function mprint(numb)
  return math.floor(numb*100)/100
end

offer = getParamEx("TQBR", "GAZP", "OFFER").param_value
bid = getParamEx("TQBR", "GAZP", "BID").param_value
change = getParamEx("TQBR", "GAZP", "CHANGE").param_value	
lastchange = getParamEx("TQBR", "GAZP", "LASTCHANGE").param_value
numoffers = getParamEx("TQBR", "GAZP", "NUMOFFERS").param_value
numbids = getParamEx("TQBR", "GAZP", "NUMBIDS").param_value
wprice  = getParamEx("TQBR", "GAZP", "WAPRICE").param_value

message("������ ���� ����������� OFFER: "..mprint(offer))
message("������ ���� ������ BID: "..mprint(bid))
message("������� ���� ��������� ������ � ���������� ������ CHANGE: "..mprint(change)) 
message("% ��������� �� �������� LASTCHANGE: "..mprint(lastchange))
message("���������� ������ �� ������� NUMOFFERS: "..mprint(numoffers))
message("���������� ������ �� ������� NUMBIDS: "..mprint(numbids))
message("���������������� ���� WAPRICE: "..mprint(wprice))
 

