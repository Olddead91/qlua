function main()

quotelvl = getQuoteLevel2("TQBR", "SBER")

	if quotelvl then
	
		if quotelvl.offer then
			
			message("�����������:")
			
			for i = quotelvl.offer_count, 1, -1 do
				offer = tonumber(quotelvl.offer[i].price)
				quant = tonumber(quotelvl.offer[i].quantity)
				message(i.." : "..offer.." �. /"..quant.." ��.")
			end
	
		
		else
		
			message("��� ������ �� ������������")

		end
	
		message(string.rep("-",10)) -- �����������
	
		if quotelvl.bid then
			
			message("�����:")
			
			for i = quotelvl.bid_count, 1, -1 do
				bid = tonumber(quotelvl.bid[i].price)
				quant = tonumber(quotelvl.bid[i].quantity)
				message(i.." : "..bid.." �. /"..quant.." ��.")
			end
		
		else
		
			message("��� ������ �� ������")

		end
		
	end

end

