function OnInit()
	do_it = true 
	progname="example_five: "
	status = 0
	mes_ind = 0
end


function OnStop()
	do_it = false
	message(progname.." ���������� ������")
end

function OnDisconnected()
	status = - 1
	message(progname..'�������� �������� �� �������')
end


function main()
	
	message(progname.." �����")

	connect = isConnected()
	
	if connect == 1 then 
		message(progname..' ����� � �������� �����������')
		status = 1 
	else
		message(progname..'����� � �������� ���')
		status = - 1
	end 
	
	
	while do_it do
	
		connect2 = isConnected()	
		
		if status == -1 and connect2 == 1 then 
			message(progname..' ���������� � �������� �������������')
			status = 1
		end
		
			
	sleep(1000)
	end
		

end
 