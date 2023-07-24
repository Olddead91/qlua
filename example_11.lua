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

 

-- ������ � ������� ����������� ������
	for i = 1, #tikers do
		local tName = getParamEx("TQBR", tikers[i], "SHORTNAME").param_image
		SetCell(m_t, i, 1, tikers[i])
		SetCell(m_t, i, 2, tName)
	end

	
	while do_it do

		-- ���������� � ���������� ���������� �������
		for i = 1, #tikers do
			 
			local tLast = getParamEx("TQBR", tikers[i], "LAST") 
			local tOffer = getParamEx("TQBR", tikers[i], "OFFERDEPTHT") 
			local tBid = getParamEx("TQBR", tikers[i], "BIDDEPTHT")

			SetCell(m_t, i, 3, tLast.param_image)
			SetCell(m_t, i, 4, tOffer.param_image)
			SetCell(m_t, i, 5, tBid.param_image)
			
			-- ������� ������ ������� ������������ �������, ������� ��� �����
			if tOffer.param_value>tBid.param_value then 
				SetColor(m_t, i, 4, RGB(255,204,250), RGB(0,0,0), RGB(255,204,250), RGB(0,0,0))
				SetColor(m_t, i, 5, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
			-- ������� ������ ������ ����������� �������, ������� ��� �����
			elseif tOffer.param_value<tBid.param_value then 
				SetColor(m_t, i, 4, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
				SetColor(m_t, i, 5, RGB(199,254,236), RGB(0,0,0), RGB(199,254,236), RGB(0,0,0))
			-- ������� ����� �������� ��������� ��� ���������� ��� ��������
			else
				SetColor(m_t, i, 4, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
				SetColor(m_t, i, 5, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
			end

		end
	
	if IsWindowClosed(m_t) then OnStop() end
	
	sleep(timeout)

	end

end
 