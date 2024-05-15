function OnInit()

	firm_id 	= "NC0011100000"  
	client_code = "10461"  

end


function mprint( numb )
	return string.format( "%.2f", numb )
end


function main()

	Portfolio = getPortfolioInfo( firm_id, client_code )
    
	message( string.rep( "- ", 15 ) ) 
	
	message( "�������� ������ = " .. mprint( Portfolio.in_all_assets ) )
	message( "������� ������ = " .. mprint( Portfolio.all_assets ) )
	message( "��������� �������� = " .. mprint( Portfolio.portfolio_value ) )
	message( "������� / ������ = " .. mprint( Portfolio.profit_loss ) )
	message( "��� = " .. mprint( Portfolio.fundslevel ) )
	
	message( "����������� ����� = " .. mprint( Portfolio.min_margin ) )
	message( "��������� ����� = " .. mprint( Portfolio.init_margin ) )
	message( "�������� �������� ����� ���1 = " .. mprint( Portfolio.rcv1 ) )
	message( "�������� �������� ����� ���2 = " .. mprint( Portfolio.rcv2 ) )
	
	firm_id 	= "SPBFUT" 
	client_code = "SPBFUT108"
	Portfolio = getPortfolioInfoEx( firm_id, client_code, 0 )
	message( "��������� �������� ��� �������� ������� FORTS = " .. Portfolio.lim_non_margin )

end

