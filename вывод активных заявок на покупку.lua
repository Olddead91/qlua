function main()

	num_orders = getNumberOf("orders")
	message("���������� ������ �����: "..num_orders)
	num_active_buy_order = 0
	
	for i = 0, num_orders - 1 do
		
		myorder = getItem("orders", i)

		if bit.band(tonumber(myorder["flags"]),1) > 0 and bit.band(tonumber(myorder["flags"]),4) == 0 then 
			message(i..": ������: "..myorder["order_num"].." ����:"..myorder["price"].." �����: "..myorder["balance"].." �����������:"..myorder["brokerref"])
			num_active_buy_order = num_active_buy_order + 1
		end
		
		sleep(10)
		
	end
	
	message("���������� �������� ������ �� �������: "..num_active_buy_order)
	
end 

