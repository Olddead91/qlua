function OnInit()
	firm_id 	= "NC0011100000"  
	client_code = "10461" 
end

function main()

 	message( string.rep( '- ', 50 ) )
	
	local money_limits = getMoney( client_code, firm_id, "EQTV", "SUR" )
    
	
	local eng_name = {	"money_open_limit", 
						"money_limit_locked_nonmarginal_value", 
						"money_limit_locked",
						"money_open_balance",
						"money_current_limit",
						"money_current_balance",
						"money_limit_available"}
	
	local rus_name = {	"�������� ����� �� �������� ���������", 
						"��������� �������������� ������������ � ������� �� �������", 
						"��������������� � ������� �� ������� ���������� �������� �������",
						"�������� ������� �� �������� ���������",
						"������� ����� �� �������� ���������",
						"������� ������� �� �������� ���������",
						"��������� ���������� �������� �������"}
	
	for i = 1 , #eng_name do
		message( eng_name[i] .. " / " .. rus_name[i] .. " = " .. money_limits[eng_name[i]] )
	end
	

end

