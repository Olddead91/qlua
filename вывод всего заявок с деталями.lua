function main()

	num_orders = getNumberOf("orders")
	message("���������� ������ : "..num_orders)

	for i = 0, num_orders - 1 do
		
		myorder = getItem("orders", i)
		
		if bit.band(tonumber(myorder["flags"]),1)>0 then 
			message(i..": ������: "..myorder["order_num"].." ����:"..myorder["price"].." �����: "..myorder["balance"].." �����������:"..myorder["brokerref"])
		end
		
		sleep(10)
		
	end
	
end 