function OnInit()
	do_it 		= true
	class 		= "QJSIM"					-- ����� �����: ����� -- QJSIM
	tiker 		= "GAZP"					-- ����� 
	account 	= "NL0011100043"			-- �������� ����
	id_transact = 0			  				-- id ������� ���� ����������
	progname	= "OnTrade_test : "			-- �������� �������
	commentid	= "sndTr_tst/"				-- ����������� � ������
	title1 		= "OnTransReply :"
	title2		= "OnOrder :"
	title3 		= "OnTrade :"
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
	["CLIENT_CODE"]			= commentid..id_transact, -- ����������� ��� ���������, �� 12 ��������
	["EXECUTION_CONDITION"] = "PUT_IN_QUEUE"		-- ������� ����������:  ��������� � ������� 
	}

	if operation == 1 then
		mytransaction["OPERATION"] = "B"
	else
		mytransaction["OPERATION"] = "S"
	end

	error_transaction = sendTransaction(mytransaction)

	if error_transaction ~= "" then
		message(progname.." ������ ����������� ������ :"..error_transaction, 3)
	else
		message(progname.." ������ ���������� �������. id ����������="..id_transact)
		lastId = id_transact
	end

end


function OnTransReply(trn)

	if bit.test(tonumber(trn.order_flags), 2) then
		txt_operation = "sell"
	else
		txt_operation = "buy"
	end

	message(string.rep("-",25))
	message(title1.." trn_id="..tostring(trn.trans_id).." / status="..trn.status.." / order_num="..trn.order_num)
	message(title1.." price="..trn.price.." / quantity="..trn.quantity.." / brokerref="..trn.brokerref)
	message(title1.." result_msg="..trn.result_msg)
	time2 = os.clock()
	message(title1.." ����� ������� "..(time2-time1).." ���.")
	
end


function OnOrder(trans)

	if bit.test(tonumber(trans.flags), 2) then
		direct_operation = "sell"
	else
		direct_operation = "buy"
	end

	message(string.rep("-",25))
	message(title2.." trn_id="..trans.trans_id.." / order_num="..trans.order_num)
	message(title2.." price="..trans.price.." / quantity="..trans.qty.." / brokerref="..trans.brokerref)
	message(title2.." direction: "..direct_operation.." / value="..trans.value)
	time3 = os.clock()
	message(title2.." ����� ������� "..(time3-time1).." ���.")
	
end

function OnTrade(trd)
	
	if bit.test(tonumber(trd.flags), 2) then
		direct_operation = "sell"
	else
		direct_operation = "buy"
	end
	
	message(string.rep("-",25))
	message(title3.." trade_num="..trd.trade_num.." / order_num="..trd.order_num)
	message(title3.." price="..trd.price.." / quantity="..trd.qty.." / brokerref="..trd.brokerref)
	message(title3.." direction: "..direct_operation.." / value="..trd.value)
	time4 = os.clock()
	message(title3.." ����� ������� "..(time4-time1).." ���.")
	
end


function OnStop()
	do_it = false
	message(string.rep('=', 25))
end


function main()

	price_order  = tonumber(getParamEx(class, tiker, "OFFER").param_value) 
	message("���� ������� ����������� = " .. price_order)
	quant = 1
	operation = 1
	
	time1 = os.clock()
	newtransaction(operation, quant, price_order)

	while do_it do
		sleep(100)
	end

end