function OnInit()
	tikers = {"GAZP", "SBER", "VKCO"}
	progname = "mytable :"
	timeout = 5000
end


function OnStop()
	do_it = false
	DestroyTable(m_t)
	message(progname.." �����.")
end


-- ������ ��������� �� �������� � ��������
function table_callback(m_t,msg,par1,par2)   -- ������� ��� m_t - ��� �������� ������� ���������� OnStop()
	if msg==QTABLE_CLOSE then
		OnStop()
	end
end

function main() 

	message(progname.." �����.")
	do_it = true


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
	SetWindowPos(m_t,0,430,700,110) -- ��������������� (x,y �� ������ �������� ����) 
									-- � ������� (������, ������)
	SetWindowCaption(m_t, "����� ������ ����� �������") -- �������� �������, ����� ���������
		for u = 1, #tikers do
			InsertRow(m_t,-1)	-- �������� ������
		end
	end

 	-- �������� �� ������� ��� m_t
	SetTableNotificationCallback(m_t,table_callback) 


-- ������ � ������� ����������� ������
	for i = 1, #tikers do
		local tName = getParamEx("TQBR", tikers[i], "SHORTNAME").param_image
		SetCell(m_t, i, 1, tikers[i])
		SetCell(m_t, i, 2, tName)
	end


	while do_it do

		-- ���������� � ���������� ���������� �������
		for i = 1, #tikers do
			 
			local tLast = getParamEx("TQBR", tikers[i], "LAST").param_image 
			local tOffer = getParamEx("TQBR", tikers[i], "OFFERDEPTHT").param_image 
			local tBid = getParamEx("TQBR", tikers[i], "BIDDEPTHT").param_image 

			SetCell(m_t, i, 3, tLast)
			SetCell(m_t, i, 4, tOffer)
			SetCell(m_t, i, 5, tBid)
		end
	

	sleep(timeout)

	end

end
 