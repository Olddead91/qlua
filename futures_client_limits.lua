 
function main()

	message( string.rep( "- ", 22 ) )
	
	message( "������ �� ������� �� ������� �����:" ) 

	local n = getNumberOf( "futures_client_limits" )

	local money_limit = getItem( "futures_client_limits", 0 )
	
	if money_limit.limit_type == 0 then
	
		message( "���������� ����� �������� ������� " ..  money_limit.cbp_prev_limit )
		message( "������� ����� �������� ������� " ..  money_limit.cbplimit )
		message( "������� ������ �������  " ..  money_limit.cbplused  )
		message( "�������� ������ �������   " ..  money_limit.cbplplanned  )
		message( "������������ �����   " ..  money_limit.varmargin  )
	
	end

 end