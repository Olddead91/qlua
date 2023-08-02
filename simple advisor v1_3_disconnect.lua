function OnInit()

	tikers = {
	"AFKS" , "AFLT" , "AGRO" , "ALRS" , "CBOM" , "CHMF" , "ENPG" , "FEES" , "FIVE" , "FIXP" , "GAZP" , "GLTR" , "GMKN" , "HYDR" , "IRAO" , "LKOH" , "MAGN" , "MGNT" , "MOEX" , "MTSS" , "NLMK" , "NVTK" , "OZON" , "PHOR" , "PIKK" , "PLZL" , "POLY" , "ROSN" , "RTKM" , "RUAL" , "SBER" , "SBERP" , "SGZH" , "SNGS" , "SNGSP" , "TATN" , "TATNP" , "TCSG" , "TRNFP" , "VKCO" , "VTBR" , "YNDX"
	}
	
	progname = "simple advisor v.1.3 : "
	timeout  = 10000
	timeout2 = 25000 -- ����� 25 ������ ��� �������� ������ �������
	startind = 0 -- ������ ������ ������� (������ ��������)
	
	-- �������� ���������
	mBlack 	= RGB(0, 0, 0)
	mWhite 	= RGB(255, 255, 255)
	mRed 	= RGB(255, 204, 250)
	mGreen 	= RGB(199, 254, 236)
	mGray 	= RGB(226, 226, 226)
	mBlue 	= RGB(166, 220, 243)   
	
	starttime 		 = 100100
	nomorningtime 	 = 103000
	nonewsignalstime = 180000
	finishtime 		 = 184000
	
	discreport = 0
	
end


function OnStop()
	DestroyTable(m_t)
	do_it = false
	
	message(progname.." �����.")
end


function mprint(numb)
	return string.format("%.2f", numb)
end


function hhmmss(date_time)
	
	local Hour = date_time.hour
	if Hour<10 then Hour = "0"..Hour end
	
	local Min = date_time.min
	if Min<10 then Min = "0"..Min end
	
	local Sec=date_time.sec
	if Sec<10 then Sec="0"..Sec end
		
	return tonumber(Hour..Min..Sec)

end


function table_print(table_text, table_result_ind)

	if table_result_ind <=15 then 
		SetCell(table_result, table_result_ind, 1, table_text)
	else
		InsertRow(table_result,-1)
		SetCell(table_result, table_result_ind, 1, table_text)
	end
	
end

 
function main() 
	
	message(progname.." �����.")
	message(progname.." starttime = "..starttime)
	message(progname.." nomorningtime = "..nomorningtime)
	message(progname.." nonewsignalstime = "..nonewsignalstime)
	message(progname.." finishtime = "..finishtime)
		
	-- ��������� starttime
	while hhmmss(os.sysdate()) < starttime do
		local time1 = hhmmss(os.sysdate())
		message('������� ����� ������ ������� : '..starttime..", ������� �����: "..time1) 
		sleep(timeout2)
	end
	
	do_it = true
	
	size_table = 15 -- ���������� ����� �������
	table_result_ind = 1 -- ������ ������
	if table_result==nil then  
		table_result = AllocTable() 
		AddColumn(table_result, 1, "������� � ����������:", true, QTABLE_STRING_TYPE, 85) 
		CreateWindow(table_result) 
		SetWindowPos(table_result,0,440,600,320) 
		SetWindowCaption(table_result, progname.." ��������� �������")
		for u = 1, size_table do 
			InsertRow(table_result,-1)	
		end
	end
	
	if m_t==nil then     
		m_t = AllocTable() 
			AddColumn(m_t, 1, "�����", true, QTABLE_STRING_TYPE, 10) 
			AddColumn(m_t, 2, "������", true, QTABLE_STRING_TYPE, 20)
			AddColumn(m_t, 3, "���.����", true, QTABLE_DOUBLE_TYPE, 10)
			AddColumn(m_t, 4, "��������", true, QTABLE_DOUBLE_TYPE, 10)
			AddColumn(m_t, 5, "�������", true, QTABLE_INT64_TYPE, 10)
			AddColumn(m_t, 6, "�������", true, QTABLE_INT64_TYPE, 10)
			AddColumn(m_t, 7, "������", true, QTABLE_STRING_TYPE, 33)
		CreateWindow(m_t)  
		SetWindowPos(m_t,700,0,690,780) 
		SetWindowCaption(m_t, progname.." �������� ���������") -- �������� �������, ����� ���������
		
		-- ��������� ������ ������
		for u = 1, #tikers do 
			InsertRow(m_t,-1)	
		end
		
	end

	closeprice = {} -- ������� ������ ��� ��������
	signal = {}
	lots = {} -- ���� �� �����������
	buypos = {} -- �������
	sellpos = {} -- �������
	
	for x = 1, #tikers do 
		closeprice[x] = getParamEx("TQBR", tikers[x], "PREVLEGALCLOSEPR") -- ���� �������� ����������� ���
		signal[x] = 0 -- ������ ������� �� �����������
		
		lots[x] = getParamEx("TQBR", tikers[x], "LOTSIZE")
		buypos[x] = 0 -- ��������� ������� �������� � ������ ��� �������
		sellpos[x] = 0 -- � � ������ ��� ������
		
	end


	while do_it do

		-- ���������� �������
		for i = 1, #tikers do
			
			local tLast = getParamEx("TQBR", tikers[i], "LAST") 
			local tOffer = getParamEx("TQBR", tikers[i], "OFFERDEPTHT")  
			local tBid = getParamEx("TQBR", tikers[i], "BIDDEPTHT") 

			
			if startind == 0 then -- ����� ����������� ����� �������
										
				local tName = getParamEx("TQBR", tikers[i], "SHORTNAME") 
				
				SetCell(m_t, i, 1, tikers[i]) 
				SetCell(m_t, i, 2, tName.param_image)
				SetCell(m_t, i, 4, closeprice[i].param_image)
			end

			SetCell(m_t, i, 3, tLast.param_image)
			SetCell(m_t, i, 5, tOffer.param_image)
			SetCell(m_t, i, 6, tBid.param_image)
			
			
			time3 = hhmmss(os.sysdate())	
			
			connect = isConnected()
			
			if connect == 1 then 
						
				if discreport == 1 then
				
					discreport = 0
					
					textdisc = " ����� � �������� �������������"
				
					message(progname..textdisc)
					table_print(time3..textdisc, table_result_ind)
					table_result_ind = table_result_ind + 1
					
					startind = 0 -- ���.������� �� ������� ��� ���������� �����
					nomorningtime = time3 - 1
								
				end
			
				
				if tonumber(tOffer.param_value) > 2 * tonumber(tBid.param_value) then
				
					SetColor(m_t, i, 5, mRed, mBlack, mRed, mBlack)
					SetColor(m_t, i, 6, mWhite, mBlack, mWhite, mBlack)
					
					-- ��������� ��������
					if tonumber(tLast.param_value) < tonumber(closeprice[i].param_value) and signal[i] == 0 then 
						
						if startind == 0 and time3 > nomorningtime then
		
								SetCell(m_t, i, 7, "noSHORT (start pass)")
								table_text = "������� �� ������ SHORT ������� "..tikers[i].." �� ���� "..tLast.param_image
								signal[i] = -3 	
						
						else
		
							if time3 < nonewsignalstime then
							
								SetCell(m_t, i, 7, "SHORT")
								table_text = "������ SHORT �� "..tikers[i].." �� ���� "..tLast.param_image
								signal[i] = -1 
								
								sellpos[i] = tonumber(tLast.param_value)
								
							else
							
								SetCell(m_t, i, 7, "noSHORT (time out pass)")
								table_text ="���������� ������ �� SHORT �� ������� "..nonewsignalstime.." �� "..tikers[i].." �� ���� "..tLast.param_image
								signal[i] = -2 
								
							end	
						
						end
					
						message(progname..table_text)
						table_print(time3.." "..table_text, table_result_ind)
						table_result_ind = table_result_ind + 1
			 
					end
					
				elseif 2 * tonumber(tOffer.param_value) < tonumber(tBid.param_value) then

					SetColor(m_t, i, 5, mWhite, mBlack, mWhite, mBlack)
					SetColor(m_t, i, 6, mGreen, mBlack, mGreen, mBlack)	

					if tonumber(tLast.param_value) > tonumber(closeprice[i].param_value) and signal[i] == 0 then 
						
						if startind == 0 and time3 > nomorningtime then
								
								SetCell(m_t, i, 7, "noLONG (start pass)")
								table_text = "������� �� ������ LONG ������� �� "..tikers[i].." �� ���� "..tLast.param_image
								signal[i] = 3 
								
						else
						
							if time3 < nonewsignalstime then
							
								SetCell(m_t, i, 7, "LONG")
								table_text = "������ LONG �� "..tikers[i].." �� ���� "..tLast.param_image
								signal[i] = 1 
								
								buypos[i] = tonumber(tLast.param_value)
								
							else	
							
								SetCell(m_t, i, 7, "noLONG (time out pass)")
								table_text = "���������� ������ LONG �� ������� "..nonewsignalstime.." �� "..tikers[i].." �� ���� "..tLast.param_image
								signal[i] = 2 
								
							end
						end
						
						
						message(progname..table_text)
						table_print(time3.." "..table_text, table_result_ind)
						table_result_ind = table_result_ind + 1
						
					end
					
				else
		
					SetColor(m_t, i, 5, mWhite, mBlack, mWhite, mBlack)
					SetColor(m_t, i, 6, mWhite, mBlack, mWhite, mBlack)
					
					--��������� ������ �� ��������
					if signal[i] ~= 0 then 
					
						if math.abs(signal[i]) == 3 then
						
							if signal[i] > 0 then
								table_text = "������� �������� ������� LONG (nomorningtime) �� "..tikers[i].." �� ���� "..tLast.param_image
							else
								table_text = "������� �������� ������� SHORT (nomorningtime) �� "..tikers[i].." �� ���� "..tLast.param_image
							end
							
							textfinres = "��������� ������ �� "..tikers[i].." ����� ��������� �� ����"
						
						end
					
						if signal[i] == 1 then
						
							table_text = "�������� ������� LONG �� "..tikers[i].." �� ���� "..tLast.param_image
							
							sellpos[i] = tonumber(tLast.param_value)
							finres = (sellpos[i] - buypos[i]) * lots[i].param_value
							
							textfinres = tikers[i]..".LONG: ������� ��: "..buypos[i].." ������� ��: "..sellpos[i].." ���.��� = "..lots[i].param_image.." ��������� = "..mprint(finres).." ���." 
							
						end
						
						if signal[i] == -1 then
						
							table_text = "�������� ������� SHORT �� "..tikers[i].." �� ���� "..tLast.param_image
							
							buypos[i] = tonumber(tLast.param_value)
							finres = (sellpos[i] - buypos[i]) * lots[i].param_value
							
							textfinres = tikers[i]..".SHORT: ������� ��: "..sellpos[i].." ������� ��: "..buypos[i].." ���.��� = "..lots[i].param_image.." ��������� = "..mprint(finres).." ���." 
							
						end
						
						message(progname..table_text)
						table_print(time3.." "..table_text, table_result_ind)
						table_result_ind = table_result_ind + 1
						
						if math.abs(signal[i]) ~= 2 then
							message(progname..textfinres)
							table_print(textfinres, table_result_ind)
							table_result_ind = table_result_ind + 1
						end
						
						signal[i] = 0
						
					end
					
					SetCell(m_t, i, 7, " ")
				
				end			
			
			Highlight(m_t, i, QTABLE_NO_INDEX, mGray, mBlack, 500) -- ��������� ������ �������� ���������
			
			else
			
				if discreport == 0 then
					
					textdisc = " ������ ����� � ��������"
					
					message(progname..textdisc)
					table_print(time3..textdisc, table_result_ind)
					table_result_ind = table_result_ind + 1
		
					discreport = 1
					
					sleep(100)
					
				end
			
			end
			
			
			if startind == 0 and i == #tikers then startind = 1 end -- ������� ������ ������ ��������
			
			sleep(100)
			 
		end
 
 
		--��������� �� �������
		local time2 = hhmmss(os.sysdate())
			
		if time2>= finishtime then
			table_text = "������ ���������� �� �������: "..time2
			message(progname..table_text)
			SetCell(table_result, table_result_ind, 1, table_text)
			OnStop()
		end
		

		if IsWindowClosed(m_t) then OnStop() end
		
		sleep(timeout)
		
	end

end