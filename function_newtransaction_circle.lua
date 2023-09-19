function OnInit()
	class 		= "QJSIM"					-- ����� �����: �����
	tiker 		= "SBER"					-- �����: ����
	account 	= "NL0011100043"			-- �������� ����
	id_transact = 0			  				-- id ������� ���� ����������
	progname	= "sndTrnsctn_v1"			-- �������� �������
end


function newtransaction(operation, quant, price)

id_transact = id_transact + 1

mytransaction  = 
	{
	["TRANS_ID"]			= tostring(id_transact),-- id ����������
	["ACTION"]				= "NEW_ORDER", 			-- ��� ������: ���������� ����� ������
	["CLASSCODE"]			= class ,				-- ����� ������
	["SECCODE"]				= tiker,				-- �����
	["QUANTITY"]			= tostring(quant), 		-- �����
	["PRICE"]				= tostring(price),		-- ����
	["ACCOUNT"]				= account,				-- �������� ����
	["CLIENT_CODE"]			= "sndTr_v1/"..id_transact, -- ����������� ��� ���������, �� 12 ��������
	["EXECUTION_CONDITION"] = "PUT_IN_QUEUE"		-- ������� ����������:  ��������� � ������� 
	}

	if operation == 1 then
		mytransaction["OPERATION"] = "B"
	else
		mytransaction["OPERATION"] = "S"
	end

	error_transaction = sendTransaction(mytransaction)

	if error_transaction ~= "" then
		message(progname.." : ������ ����������� ������ :"..error_transaction, 3)
	else
		message(progname.." : ������ ���������� �������. id ����������="..id_transact)
	end


end

function main()

quant = 1 	-- ����� �������

	for i = 1 , 5 do
		
		priceL = 256.9 - 0.01*i
		priceS = 257.06 + 0.01*i
		
		newtransaction(1, quant, priceL)
		sleep(300)
		
		newtransaction(-1, quant, priceS)
		sleep(300)

	end	
	
end