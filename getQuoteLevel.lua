function main()

quotelvl = getQuoteLevel2("TQBR", "SBER")

	if quotelvl then
	
		if quotelvl.offer then
			
			offer = tonumber(quotelvl.offer[1].price)
			quant = tonumber(quotelvl.offer[1].quantity)
			
			message("������ ���� ����������� : "..offer)
			message("���������� ��� ������ ���� : "..quant)
			message("���������� ��������� ������� : "..quotelvl.offer_count)
		
		else
		
			message("��� ������ �� ������������")

		end
	
		if quotelvl.bid then
			
			bid = tonumber(quotelvl.bid[tonumber(quotelvl.bid_count)].price)
			quant = tonumber(quotelvl.bid[tonumber(quotelvl.bid_count)].quantity)
			
			message("������ ���� ������ : "..bid)
			message("���������� ��� ������ ���� : "..quant)
			message("���������� ��������� ������ : "..quotelvl.bid_count)
		
		else
		
			message("��� ������ �� ������")

		end

	end

end

