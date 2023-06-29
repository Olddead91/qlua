-- To read comments, use the encoding:: Windows-1251

--[[
������ �������� ��������� ��� OHLC, Value (������ � ���.), LegalClosePrice (�������� ������� ������ �18:50); ClosePrice (�������� � 23:50), 
���� LegalClosePrice � ClosePrice ���������� �������� ������.

C����� ����������� �� ������� (HTimeOut � ��� �������� �� ���, MTimeOut � ������),
������ �������� ���� ����������� ���������� �� ������� ������� ������. 
������ ������� �� ������ ��� ����������� ����� C:\files\tickers.csv (��� ������� ������ moextickers.lua  https://github.com/morefinances/qlua). 

� �������� ����������� 2 �������� �������, ���� ������ �������� � 18:55 ��� �������� �������� ������, 
����� ���� ��� �����������, ������ � 23:55 � ����� �����������.

���� ���������� ���� �� ������� ����� �������� �� �� ������ ��������� � logs.csv.

� �������� �������� ���� �������� ������� ��������, �� ������ ������� 100 �� � ��������������� ������, 
���� �� 10 �������� ������ �� �������� (������ ������ � ���), �� ��������� �����. 

� ������ (tickers) ������ ���� ������, �� ������� ����� �� ����������, �� ����� �� ��� ���� �������� ��� ��������� (����� iss ������� ��� ���������� ����������� � �������� ��������, �� ������������� ������).

�������������, ��� ����� ����������� ������, ������ ���� �������������� �����. 
���� ����� ����� �������������� ������ ���������� ���������� ������� ������� � ������ ������ ��������. 

���� ����� 7 ����� ����� ������ (� �������� � ������ 6��) �������� �� ���������� ������ �� ������� (indTimer) ��������� ������. ���� ��� ��������� ������ � ������ �����, �� ������ ����� � �������� ���������. ������� � ���� ����� � ���������� ������� �� ������� � ������ �����, ����� �� ��������� ��������.

���������� ������������ � ����� downloads � ����� � �������� �������� � �������� ����� �� � ��� �� C:\files\ ����������.

������� ������� ��������� ������ �������� ��������� � ��������� ��������.
]]--

function OnInit()

	--��������� �������:
	HTimeOut=15 -- ��� �� ��� �
	MTimeOut=15 -- ������ ������� 
				-- ��������� �������� ������
	
	-- ������������ ������� ������� ������� ������ �������
	NameTableColumns = {'�����', '������', '������� ������', '����� ������ ��������'} 
	QCTanbles = {9, 7, 55, 33}
	
	-- ���������� �� Y ������������ ������ �������. 
	YPosConsts = {447, 526}
	
	-- ��� ��� �� 19 ����������� ����� ���� ����.
	if HTimeOut <= 19 then 
		YPosTables = YPosConsts[1] 
	else
		YPosTables = YPosConsts[2]
	end
	
	indTimer = 1680 -- ������ �������� ������ ����� 7 ����� (4*60*7=1680)
	
	--�������������� ���� ��� ����������� ������ �������
	if HTimeOut < 10 then 
		otxt = "0"
	else
		otxt = ""
	end
	
	if MTimeOut < 10 then
		ttxt = "0"
	else
		ttxt = ""
	end
	
	WorkPath="C:\\files\\"  -- ������� ����������, ��� ��������� tickers.csv 
							-- � ���� ����� ����������� ���� (logs.csv) � ���� � �����������.
	
	-- ������ ������� ��� ����� � ������� ���������
	-- �������� �������, ����� �������� ���������
	ProgramSmallName="dwnlds "..otxt..HTimeOut..":"..ttxt..MTimeOut
	ProgramName="�������� ��� �������� � ������� ������"
	ProgramVersion="1.0.6. �� 29.06.2023"
	
end



function OnStop()

	DirectionSaveFile=tostring(WorkPath.."logs.csv") 
	my_csv=io.open(DirectionSaveFile,"a+") 

	if ind == 1 then
		message("������ "..ProgramSmallName.." ���������� �� ���������� ������", 2)
		my_csv:write("������ "..ProgramSmallName.." ���������� �� ���������� ������\n")
		SetCell(m_t, 1, 3, "������ ���������� �� ���������� ������")
		Highlight(m_t, 1, 3, RGB(149, 200, 216), RGB(0,0,0), 600)
		SetColor(m_t, 1, QTABLE_NO_INDEX, RGB(166, 220, 243), RGB(0,0,0), RGB(149,200,216), RGB(0,0,0))
		end 
		
	if ind == 0 then	
		message("������ "..ProgramSmallName.." ���������� �������������")	
		my_csv:write("������ "..ProgramSmallName.." ���������� �������������\n")
		SetCell(m_t, 1, 3, "������ ���������� �������������")
		Highlight(m_t, 1, 3, RGB(149, 200, 216), RGB(0,0,0), 600)
		SetColor(m_t, 1, QTABLE_NO_INDEX, RGB(197, 220, 243), RGB(0,0,0), RGB(149,200,216), RGB(0,0,0))
		end
		
	if ind == -1 then
		message("������ "..ProgramSmallName.." ���������� � ������ ������� ����������", 3)
		my_csv:write("������ "..ProgramSmallName.." ���������� � ������ ������� ����������\n")
		SetCell(m_t, 1, 3, "������ ���������� � ������ ������� ����������")
		Highlight(m_t, 1, 3, RGB(160, 160, 160), RGB(0,0,0), 600)
		SetColor(m_t, 1, QTABLE_NO_INDEX, RGB(224, 224, 224), RGB(0,0,0), RGB(149,200,216), RGB(0,0,0))
		end
	
	if ind == 2 then
		message("������ "..ProgramSmallName.." ���������� �� ������� [ n >= "..indtre.." ] ", 3)
		my_csv:write("������ "..ProgramSmallName.." ���������� �� ������� [ n >= "..indtre.." ] \n")
		SetCell(m_t, 1, 3, "������ ���������� �� ������� [ n >= "..indtre.." ]")
		Highlight(m_t, 1, 3, RGB(160, 160, 160), RGB(0,0,0), 600)	
		SetColor(m_t, 1, QTABLE_NO_INDEX, RGB(224, 224, 224), RGB(0,0,0), RGB(149,200,216), RGB(0,0,0))		
		end
		
	myRun=false
	message("<--- ���������� "..ProgramSmallName..": "..ProgramName.." --->")
	message("===========================================")
	my_csv:write("<--- ���������� "..ProgramSmallName..": "..ProgramName.." --->\n")
	my_csv:write("===========================================\n")

	my_csv:flush()  
	my_csv:close() 
	sleep(10)
	
end


function downloadsdata()

	message("<-- "..ProgramSmallName.." -->")
	message("<-- �������� ������ -->")
	message("��������� ������� � "..WorkPath.."tickers.csv")

	-- �������� ������� �:\files\moextickers.csv
	t = {}
	DirectionOpenFile=tostring(WorkPath.."tickers.csv") 
	f = io.open(DirectionOpenFile, "r");
	for i=1, 300 do
		t[i] = f:read("*l")
		if t[i]==nil then break end
		end
	f:close()

	message(ProgramSmallName.." ��������� "..tostring(#t).." �������")

	
	
	-- �������� �����
		datetime = os.date("!*t",os.time())
	
	Hou_one = datetime.hour
	Min_one = datetime.min
	Sec_one = datetime.sec
	Total_one = Hou_one * 60 * 60 + Min_one * 60 + Sec_one
	
	mdate=getTradeDate()
	
	if mdate.day<10 then
		clockdate = " 0"..mdate.day
	else
		clockdate = mdate.day
	end	
	
	if mdate.month < 10 then
		clockdate = clockdate.." 0"..mdate.month.." "..mdate.year
	else
		clockdate = clockdate.." "..mdate.month.." "..mdate.year
	end
	
	if (Hou_one + 3) < 10 then
		clocknamefile = "0"..tostring(Hou_one + 3)
	else
		clocknamefile = tostring(Hou_one + 3)
	end
	
	if Min_one < 10 then
		clocknamefile = clocknamefile.." ".."0"..Min_one
	else
		clocknamefile = clocknamefile.." "..Min_one
	end	
	
	if Sec_one < 10 then
		clocknamefile = clocknamefile.." ".."0"..Sec_one
	else
		clocknamefile = clocknamefile.." "..Sec_one
	end	
	
 
	DirectionSaveFile=tostring(WorkPath.."downloads "..clockdate.." "..clocknamefile..".csv") 
	my_csv=io.open(DirectionSaveFile,"a+") 
	
	--LEGALCLOSEPRICE 	18:45 /  ���� �������� �������� ������ 
	--CLOSE 			23:50 /  ���� �������� ������� ����� (+ �������� ������, ���� ����)
	
	if (Hou_one + 3) < 23 then
		my_csv:write("�����; OPEN; HIGH; LOW; LASTPRICE; ������ (�� 18:50); LCP; preLCP; preCP; LCP = LegalClosePrice (18:50); CP = ClosePrice (23:50) \n")
	else
		my_csv:write("�����; Open; High; Low; LastPrice; ������ (�� 23:50); LCP; CP ; preCP; LCP = LegalClosePrice (18:50); CP = ClosePrice (23:50)\n")
	end
		
	
	openprice = {}
	highprice={}
	lowprice = {}
	lastprice = {}
	closeprice = {}
	legalcloseprice = {}
	prevlegalcloseprice = {}
	value = {}
	
	
	for i = 1, #t do
	
		-- �������� �� �����������
		if getParamEx("TQBR",t[i],'STATUS').param_value == 0 then
			message(ProgramSmallName..' ����� '..t[i]..' �� ���������')
			my_csv:write(t[i].."; �� ���������;\n")
			sleep(5)
		else
			openprice[i] = tonumber(getParamEx("TQBR",t[i],'OPEN').param_value)
	
			if openprice[i] == 0 then
				for u=1, 10 do
					sleep(100)
					openprice[i] = tonumber(getParamEx("TQBR",t[i],'OPEN').param_value)
					message(ProgramSmallName.." "..t[i]..": openprice_"..u)
					if openprice[i]~=0 then break end
				end
			end
			
			highprice[i] = tonumber(getParamEx("TQBR",t[i],'HIGH').param_value)
			
			if highprice[i] == 0 then
				for u=1, 10 do
					sleep(100)
					highprice[i] = tonumber(getParamEx("TQBR",t[i],'HIGH').param_value)
					message(ProgramSmallName.." "..t[i]..": highprice_"..u)
					if highprice[i]~=0 then break end
				end
			end
			
			lowprice[i] = tonumber(getParamEx("TQBR",t[i],'LOW').param_value)
			
			if lowprice[i] == 0 then
				for u=1, 10 do
					sleep(100)
					lowprice[i] = tonumber(getParamEx("TQBR",t[i],'LOW').param_value)
					message(ProgramSmallName.." "..t[i]..": lowprice_"..u)
					if lowprice[i]~=0 then break end
				end
			end
			
			lastprice[i] = tonumber(getParamEx("TQBR",t[i],'LAST').param_value)
			
			if lastprice[i] == 0 then
				for u=1, 10 do
					sleep(100)
					lastprice[i] = tonumber(getParamEx("TQBR",t[i],'LAST').param_value)
					message(ProgramSmallName.." "..t[i]..": lastprice_"..u)
					if lastprice[i]~=0 then break end
				end
			end
			
			legalcloseprice[i] = tonumber(getParamEx("TQBR",t[i],'LCLOSEPRICE').param_value)
			
			if legalcloseprice[i] == 0 and (Hou_one + 3) >= 18 then
				for u=1, 10 do
					sleep(1000)
					legalcloseprice[i] = tonumber(getParamEx("TQBR",t[i],'LCLOSEPRICE').param_value)
					message(ProgramSmallName.." "..t[i]..": legalcloseprice_"..u)
					if tonumber(legalcloseprice[i]~=0) then break end
				end
			end

			closeprice[i] = tonumber(getParamEx("TQBR",t[i],'PREVPRICE').param_value)
			
			-- ������ and ((Hou_one + 3) < 10 or (Hou_one + 3) >= 23),
			-- �.�. �� � �������� ������ ������ ���� ����������� ���  
			if closeprice[i] == 0 then 
				for u=1, 10 do
					sleep(1000)
					closeprice[i] = tonumber(getParamEx("TQBR",t[i],'PREVPRICE').param_value)
					message(ProgramSmallName.." "..t[i]..": prevprice~close"..u)
					if closeprice[i]~=0 then break end
				end
			end
			
			prevlegalcloseprice[i] = tonumber(getParamEx("TQBR",t[i],'PREVLEGALCLOSEPR').param_value)
			
			-- and ((Hou_one + 3) < 10 or (Hou_one + 3) >= 23)
			if prevlegalcloseprice[i] == 0  then
				for u=1, 10 do
					sleep(1000)
					prevlegalcloseprice[i] = tonumber(getParamEx("TQBR",t[i],'PREVLEGALCLOSEPR').param_value)
					message(ProgramSmallName.." "..t[i]..": prevlegalcloseprice"..u)
					if closeprice[i]~=0 then break end
				end
			end
			
			value[i] = tonumber(getParamEx("TQBR",t[i],'VALTODAY').param_value)
			
			if value[i] == 0 then
				for u=1, 10 do
					sleep(250)
					value[i] = tonumber(getParamEx("TQBR",t[i],'VALTODAY').param_value)
					message(ProgramSmallName.." "..t[i]..": value_"..u)
					if tonumber(value[i]~=0) then break end
				end
			end
			
			message(ProgramSmallName.." "..t[i].." : OPEN="..tostring(myint(openprice[i],2)).." / HIGH="..tostring(myint(highprice[i],2)).." / LOW="..tostring(lowprice[i]).."/ LAST= "..tostring(myint(lastprice[i],0)))
			message(ProgramSmallName.." "..t[i].." : legalCP="..tostring(myint(legalcloseprice[i],2)).." / CP="..tostring(myint(closeprice[i],2)).." / PLCP="..tostring(prevlegalcloseprice[i]).."/ V= "..tostring(myint(value[i],0)))
			my_csv:write(t[i]..";"..openprice[i]..";"..highprice[i]..";"..lowprice[i]..";"..lastprice[i]..";"..value[i]..";"..legalcloseprice[i]..";"..prevlegalcloseprice[i]..";"..closeprice[i]..";\n")
			sleep(10)
			
		end
		
		sleep(10)
		end
	
	my_csv:flush()  
	my_csv:close() 

	datetime = os.date("!*t",os.time())
	
	Hou_two = datetime.hour
	Min_two = datetime.min
	Sec_two = datetime.sec
	Total_two = Hou_two * 60 * 60 + Min_two * 60 + Sec_two
	
	message(ProgramSmallName.." ����� ��������: "..tostring(Total_two-Total_one).." ���.")
	message(ProgramSmallName.." <-- ���������� ��������� �������� -->")
	
	
end

-- ����� �����: �������� ������ 000
function myint(numb, qual)
	
	if qual == 0 then
		return(tostring(math.floor(numb)))
	end
	
	if qual == 1 then
		b = math.floor(numb)
		c = math.ceil((numb - b)*10)
		--message(b.."."..tostring(c))
		return (b.."."..tostring(c))
	end
	
	if qual == 2 then
		b = math.floor(numb)
		c = math.ceil((numb - b)*100)
		if c == 0 then 
			return(b.."."..tostring(c).."0")
		else
			return(b.."."..tostring(c))
		end
	end
	
end



function main()
 
-- ������ ������� �������� �������
if m_t==nil then
	m_t=AllocTable()
		for m=1, 4 do
			AddColumn(m_t, m, NameTableColumns[m], true, QTABLE_STRING_TYPE, QCTanbles[m])
		end
	CreateWindow(m_t)
	SetWindowPos(m_t, 0, YPosTables, 706, 80)
	SetWindowCaption(m_t, ProgramSmallName..": "..ProgramName.." "..ProgramVersion)
	InsertRow(m_t,-1)	
end


	myRun=true -- ���� true �� ��������
	
	message("===========================================", 2)
	message("<--- c���� "..ProgramSmallName..": "..ProgramName.." --->", 2)	
	message("<--- ������: "..ProgramVersion.." --->", 2)	
	message('���� �������: '..os.date("%d.%m.%Y"), 2)
	message('����� ������: '..os.date("%X",os.time()), 2)
	SetCell(m_t, 1, 1, tostring(os.date("%X",os.time())))
	SetCell(m_t, 1, 2, otxt..HTimeOut..":"..ttxt..MTimeOut)
	SetCell(m_t, 1, 3, "����� ���������")
	Highlight(m_t, 1, QTABLE_NO_INDEX, RGB(149,200,216), RGB(0,0,0), 600)
	sleep(10)
	
	--��������� � ����
	DirectionSaveFile=tostring(WorkPath.."logs.csv") 
	my_csv=io.open(DirectionSaveFile,"a+") 
	my_csv:write("===========================================\n")
	my_csv:write("<--- c���� "..ProgramSmallName..": "..ProgramName.." --->\n")
	my_csv:write("<--- ������: "..ProgramVersion.." --->\n")	
	my_csv:write('���� �������: '..os.date("%d.%m.%Y").."\n")
	my_csv:write('����� ������: '..os.date("%X",os.time()).."\n")
	my_csv:flush()  
	my_csv:close() 
	sleep(10)

	ind = 0 -- ������� ���������� ���������
	indtwo = 0 -- ��������� ������ ��������
	MM = 0 -- ������ �����
	indtre = 0 -- ������� ��� ���������� �� �������
	
	while myRun do
	

		-- ��������� �������
		datetime = os.date("!*t",os.time())
		mHou = datetime.hour + 3
		mMin = datetime.min
		mSec = datetime.sec
		
		TimerVar = mHou * 3600 + mMin * 60 + mSec
		cnct = isConnected()
		
		
		if indtwo == 0 then 
		
		DirectionSaveFile=tostring(WorkPath.."logs.csv") 
		my_csv=io.open(DirectionSaveFile,"a+") 
		
			if cnct == 1 then
				if ind >= 0 then 
					message(ProgramSmallName.." <-- ����� � �������� �� ������ ����������� -->", 2)
					my_csv:write(ProgramSmallName.." <-- ����� � �������� �� ������ ����������� -->\n")
					SetCell(m_t, 1, 3, "����� � �������� �� ������ �����������")
					Highlight(m_t, 1, 3, RGB(149, 200, 216), RGB(0,0,0), 600)
					sleep(10)
				end
			else
				message(ProgramSmallName.." <-- ����� � �������� �� ������ ��������� -->", 3)
				my_csv:write(ProgramSmallName.." <-- ����� � �������� �� ������ ��������� -->\n")
				SetCell(m_t, 1, 3, "����� � �������� �� ������ ���������")
				Highlight(m_t, 1, 3, RGB(160, 160, 160), RGB(0,0,0), 600)
				ind = -1
				OnStop()
				myRun = false
			end
		
		--	�������� �����
		my_csv:flush()  
		my_csv:close() 
		sleep(10)		
		
		end
	
		if ind == -1 and cnct == 1 then
			DirectionSaveFile=tostring(WorkPath.."logs.csv") 
			my_csv=io.open(DirectionSaveFile,"a+") 
			
			if mMin<10 then
				stxtone="0"
			else
				stxtone=""
			end
			
			if mSec<10 then
				stxttwo="0"
			else
				stxttwo=""
			end
			
			message(ProgramSmallName..": ����� ������������� � "..mHou..":"..stxtone..mMin..":"..stxttwo..mSec, 2)
			my_csv:write(ProgramSmallName..": ����� ������������� � "..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."\n")
			SetCell(m_t, 1, 3, "����� ������������� � "..mHou..":"..stxtone..mMin..":"..stxttwo..mSec)
			Highlight(m_t, 1, 3, RGB(149, 200, 216), RGB(0,0,0), 600)
			
			my_csv:flush()  
			my_csv:close() 
			sleep(10)	
			
			ind = 0
			indtwo = 0
			MM = 0
		end
	
		
		if cnct == 0 and indtwo == 1 then
		
			if mMin<10 then
				stxtone="0"
			else
				stxtone=""
			end
			
			if mSec<10 then
				stxttwo="0"
			else
				stxttwo=""
			end
			
			DirectionSaveFile=tostring(WorkPath.."logs.csv") 
			my_csv=io.open(DirectionSaveFile,"a+") 
			
			message(ProgramSmallName..": <-- ����� � �������� �������� "..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.." -->", 3)
			message(ProgramSmallName.." ������� � ������ �����, ��� ������������� �����", 3)
			SetCell(m_t, 1, 3, "����� � �������� �������� "..mHou..":"..stxtone..mMin..":"..stxttwo..mSec)
			Highlight(m_t, 1, 3, RGB(160, 160, 160), RGB(0,0,0), 600)
			
			my_csv:write(ProgramSmallName..": <-- ����� � �������� �������� "..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.." -->\n")
			my_csv:write(ProgramSmallName.." ������� � ������ �����, ��� ������������� �����\n")
			
			my_csv:flush()  
			my_csv:close() 
			sleep(10)
			
			ind = -1
			indtwo = -1
			
		end

		-- ��������� ������ ��������
		if indtwo == 0 then 
			MM = TimerVar
			indtwo = 1
		end
			
		if mHou >= HTimeOut and mMin >= MTimeOut and cnct == 1 then 
		
			if mMin<10 then
				stxtone="0"
			else
				stxtone=""
			end
			
			if mSec<10 then
				stxttwo="0"
			else
				stxttwo=""
			end
			
			SetCell(m_t, 1, 3, "��������� �������� ������")
			Highlight(m_t, 1, 3, RGB(149, 200, 216), RGB(0,0,0), 600)
			
			DirectionSaveFile=tostring(WorkPath.."logs.csv") 
			my_cs=io.open(DirectionSaveFile,"a+") 
		
			message(ProgramSmallName.." Timer downloads: "..mHou..":"..stxtone..tostring(mMin)..":"..stxttwo..tostring(mSec), 2)
			my_cs:write(ProgramSmallName.." Timer downloads: "..mHou..":"..stxtone..tostring(mMin)..":"..stxttwo..tostring(mSec).."\n")
			SetCell(m_t, 1, 4, " Timer downloads: "..mHou..":"..stxtone..tostring(mMin)..":"..stxttwo..tostring(mSec))	
				
			my_cs:flush()  
			my_cs:close() 
			sleep(10)
			
			
			downloadsdata()
			ind = 1
		end
		
		-- ����� ������� ������ ������� ����� ������ 5 �����
		if TimerVar >= (MM + 5*60)  then
			
			if mMin<10 then
				stxtone="0"
			else
				stxtone=""
			end
			
			if mSec<10 then
				stxttwo="0"
			else
				stxttwo=""
			end
			
			--��������� ���� ��� ������ �����
			DirectionSaveFile=tostring(WorkPath.."logs.csv") 
			my_csv=io.open(DirectionSaveFile,"a+") 

			
			if cnct == 1 then
				message(ProgramSmallName.." timer ["..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."]")
				-- ��������� ����
				my_csv:write(ProgramSmallName.." timer ["..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."]\n")
				SetCell(m_t, 1, 3, "����� �������� ["..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."]")
				Highlight(m_t, 1, 3, RGB(149, 200, 216), RGB(0,0,0), 600)
				sleep(10)
			end
			
			if cnct == 0 then
				message(ProgramSmallName.." timer ["..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."] ��� �������", 3)
				-- ��������� ����
				my_csv:write(ProgramSmallName.." timer ["..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."] ��� �������\n")
				SetCell(m_t, 1, 3, " ����� �������� ["..mHou..":"..stxtone..mMin..":"..stxttwo..mSec.."] ��� �������")
				Highlight(m_t, 1, 3, RGB(160, 160, 160), RGB(0,0,0), 600)
				sleep(10)
			end
			
			-- ��������� ����
			my_csv:flush()  
			my_csv:close() 
			sleep(10)
			
			MM = TimerVar
		end
		
		-- ���� �� ���������, �� ������ ����������� ������
		if ind == 1 then OnStop() end
		
		-- ������� � ������� �������� ��������� �� 7 �����
		-- � ����� ������ �������
		if indtre >= indTimer then
			ind = 2
			OnStop()
			end
				
		--�������� 15 ������ ��� ��������� ����������
		sleep(15000)	

		indtre = indtre + 1
		
	end

end