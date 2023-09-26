function OnInit()
	class 		= "QJSIM"					-- ����� �����: ����� -- QJSIM
	tiker 		= "SBER"					-- �����: ����
	account 	= "NL0011100043"			-- �������� ����
	id_transact = 0			  				-- id ������� ���� ����������
	progname	= "sndTrnsctn_v1"			-- �������� �������
end

function offer_bid_price()

quotelvl = getQuoteLevel2(class, tiker)

if quotelvl then

	if quotelvl.offer then
		priceoffer = tonumber(quotelvl.offer[1].price)			
	else
		message("��� ������ �� �����������")
		priceoffer = -1
	end

	if quotelvl.bid then
		pricebid = tonumber(quotelvl.bid[tonumber(quotelvl.bid_count)].price)
	else
		message("��� ������ �� ������")
		pricebid = -1
	end

end

return priceoffer, pricebid

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

message(string.rep("-",15)) -- �����������

quant = 1 	-- ����� �������

OfferPrice, BidPrice  = offer_bid_price()


	for i = 1 , 5 do
		

		if BidPrice > 0 then
			newtransaction(1, quant, BidPrice)
			sleep(300)
		end
		
		if OfferPrice > 0 then		
			newtransaction(-1, quant, OfferPrice)
			sleep(300)
		end
		
		BidPrice = BidPrice - 0.01
		OfferPrice = OfferPrice + 0.01

	end	
	
end