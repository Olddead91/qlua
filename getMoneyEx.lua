function OnInit()
	firm_id 	= "NC0011100000"  
	client_code = "10461" 
end

function main()

	
	for u = 0 , 1 do
	
		local money_limits = getMoneyEx( firm_id, client_code, "EQTV", "SUR", u )
	
		message(string.rep('- ', 50))
		
		local eng_name = {	"limit_kind", "openbal", 
							"openlimit", 
							"currentbal", 
							"currentlimit", 
							"locked", 
							"locked_value_coef", 
							"locked_margin_value", 
							"leverage", 
							"wa_position_price", 
							"orders_collateral", 
							"positions_collateral" }
		
		local rus_name = {	"������� �+" , 
							"�������� �������" , 
							"�������� �����" , 
							"������� �������" , 
							"������� �����" , 
							"������������� ��� ���������� ������" , 
							"��������� ������� � ������� �� ������� �������������� ������������" , 
							"��������� ������� � ������� �� ������� ������������ ������������" , 
							"�����" , 
							"���������������� ���� ������������ �������" , 
							"����������� ����������� ������" , 
							"����������� ����������� �������"}
		
		for i = 1 , #eng_name do 
			message( eng_name[i] ..  " / " .. rus_name[i] .. " = " .. money_limits[eng_name[i]] )
		end
	
	end

end

