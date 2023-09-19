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

	if operation == -1 then
		mytransaction["OPERATION"] = "S"
	else
		mytransaction["OPERATION"] = "B"
	end

	error_transaction = sendTransaction(mytransaction)

	if error_transaction ~= "" then
		message(progname.." : ������ ����������� ������ :"..error_transaction, 3)
	else
		message(progname.." : ������ ���������� �������. id ����������="..id_transact)
	end

end

function main()

	price = 256.5 	-- ���� �������
	quant = 1 		-- ����� �������

	operation = 1	-- �����������: �������
	
	newtransaction(operation, quant, price)
	sleep(1000)		-- ������� 1 ���.

end

