function main()

	message(string.rep("- ",22))
	message("������ �� �������:") 

	local n=getNumberOf("money_limits")
		for i = 0, n - 1 do
			local money_limit=getItem("money_limits",i)
			
			if money_limit.tag == "EQTV" and money_limit.currcode == "SUR" and money_limit.limit_kind <= 1 then
			
				txt_string = "������: T+" ..  money_limit.limit_kind .. " : �������� �������: " .. money_limit.openbal .. " / ������� �������: " .. money_limit.currentbal .. " / ������������� : " .. money_limit.locked
			
				message(txt_string)
			
			end		
		
		end
	
 end
 
 