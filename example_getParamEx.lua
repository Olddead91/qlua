last_type = getParamEx("TQBR", "GAZP", "LAST").param_type
last_value = getParamEx("TQBR", "GAZP", "LAST").param_value
last_image = getParamEx("TQBR", "GAZP", "LAST").param_image

message("���� ��������� ������ �� ��������: ")
message("���: "..last_type)
message("�������� : "..last_value)
message("������: "..last_image)