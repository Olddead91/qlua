function main()

	message('[ = = = = = = = = = = start = = = = = = = = = = ]')
	
	datetime = os.date("!*t",os.time())
	message('����������� ������� ��������� ����� �� �������� ������')
	message(os.date("%d.%m.%Y"))
	message('������ ������ ������� '..os.date("%X",os.time()))
	

	DirectionSaveFile=tostring("C:\\files\\tickers.csv") 
	my_csv=io.open(DirectionSaveFile,"w") 
	
	sec_list = getClassSecurities("TQBR") -- ������ � ���� �������
	
	ind = 1 -- ������ �������� ���������� �����
	sprint = "" -- ������� �������� ��� ������
	
	-- �������� ������ � ��������
	for TIKER in string.gmatch(sec_list, "[^,]+") do
		-- ������ � ����
		my_csv:write(TIKER.."\n")
		sprint = sprint..tostring(ind).."/ "..TIKER.."  "
		ind = ind + 1 -- ������ ������
		if ind%5 == 1 then 
			message(sprint)
			sprint = ""
		end
		sleep(5)
	end
	
	if sprint ~= "" then message(sprint) end 
	
	-- -- �������� �����
	my_csv:flush()  
	my_csv:close() 

	message('���������� ������ ������� '.. os.date("%X",os.time()))
	message('����� ���������� ��������� ����� : '..tostring(ind - 1))
	message("[ = = = = = = = = = = end = = = = = = = = = =  ]")
	
end