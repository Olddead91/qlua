function OnInit()
	class 		= "QJSIM"					-- ����� �����: �����
	tiker 		= "SBER"					-- �����: ����
	account 	= "NL0011100043"			-- �������� ����
	client_code = "10070"					-- ��� �������
	id_transact = 0			  				-- id ������� ���� ����������
	progname	= "delete_order_1.0"		-- �������� �������
end


function trasactiondelete(number_order)

id_transact = id_transact + 1

deleteorder  = 
	{
	["TRANS_ID"]			= tostring(id_transact), 
	["ACTION"]				= "KILL_ORDER", 			 
	["CLASSCODE"]			= class ,				 
	["SECCODE"]				= tiker,				 			 
	["ACCOUNT"]				= account,				
	["ORDER_KEY"] 			= tostring(number_order)		
	}
	
end

function main()
 	
	num_orders = getNumberOf("orders")
	
	for i = num_orders - 1, 0, -1 do
	
		myorder = getItem("orders", i)
		
		if myorder["client_code"]==client_code and myorder["sec_code"]==tiker then
		
			if bit.band(tonumber(myorder["flags"]),1) > 0 then
			
				message(progname.." ����� ������: "..myorder.order_num)
					
					trasactiondelete(myorder.order_num)
					error_transaction = sendTransaction(deleteorder)
					sleep(300)
					
					if error_transaction ~= "" then
						message(progname.." : ������ ="..error_transaction, 3)
					else
						message(progname.." : ������ ������ "..myorder["order_num"].." ����:"..myorder["price"].." �����: "..myorder["balance"].." �����������:"..myorder["brokerref"], 2)
					end
				
				break -- ������� �� ����� ����� ���� ��� ����� 1 �������� ������

			end
	
		end
	
	end

end