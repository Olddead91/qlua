tikers = {"GAZP", "SBER", "VKCO"}
 
if m_t==nil then     -- ���� ������� �� ������� �����, �� 
	m_t=AllocTable() -- ������� �������
		AddColumn(m_t, 1, "�����", true, QTABLE_STRING_TYPE, 10) 
		-- �������� 1 ������� ������� � 10 ��������
		AddColumn(m_t, 2, "������", true, QTABLE_STRING_TYPE, 20)
		-- �������� 2 ������� ������� � 20 ��������
		AddColumn(m_t, 3, "����", true, QTABLE_STRING_TYPE, 10)
		-- 3� ������� � ������� � 10
		AddColumn(m_t, 4, "��������� �����������", true, QTABLE_STRING_TYPE, 25)
		-- 4� � 5� ������� � ������� � 25  
		AddColumn(m_t, 5, "��������� �����", true, QTABLE_STRING_TYPE, 25)
	CreateWindow(m_t) -- �������� ���� �������
	SetWindowPos(m_t,100,430,700,110) -- ��������������� (x,y �� ������ �������� ����) 
	                                -- � ������� (������, ������)
	SetWindowCaption(m_t, "����� ������ ����� �������") -- �������� �������, ����� ���������
	for u = 1, #tikers do
		InsertRow(m_t,-1)	-- �������� ������
	end
end

-- ���������� �������
for i = 1, #tikers do
	local tName = getParamEx("TQBR", tikers[i], "SHORTNAME").param_image 
	local tLast = getParamEx("TQBR", tikers[i], "LAST").param_image 
	local tOffer = getParamEx("TQBR", tikers[i], "OFFERDEPTHT").param_image 
	local tBid = getParamEx("TQBR", tikers[i], "BIDDEPTHT").param_image 

	SetCell(m_t, i, 1, tikers[i])
	SetCell(m_t, i, 2, tName)
	SetCell(m_t, i, 3, tLast)
	SetCell(m_t, i, 4, tOffer)
	SetCell(m_t, i, 5, tBid)
end

 