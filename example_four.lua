function OnInit()
	do_it = true 
	progname="example_four: "
end


function OnStop()
	do_it = false
	message(progname.." ���������� ������")
end



function main()
	
	message(progname.." �����")

	connect = isConnected()
	
	if connect == 1 then 
		message(progname..' ����� � �������� �����������')
	else
		message(progname..'����� � �������� ���')
	end 
	
	
	while do_it do
	 


			
	sleep(1000)
	end
		

end
 