function OnInit()
-- �������������� ���������� ���������� � ���������
	progname="example_three: "
	do_it = true
end

function OnStop()
-- ������� ��������� �������, ������������ ��� ������� ������� ������������ 
	do_it = false
	message(progname.." ���������� ������")
end

function main()
--�������� �������
	message(progname.." �����")

	for i=1, 20 do
	
		time1 = os.sysdate()
		time2 = getInfoParam('SERVERTIME')
		
		sec1 = time1.sec
		sec2 = tonumber(string.sub(time2, #time2-1, #time2))
		
		
		
		if sec1~=sec2 then 
			time_txt=time1.hour..":"..time1.min..":"..time1.sec
			message("����� ����� os.sysdate: "..time_txt.." ����� SERVERTIME:"..time2)
		end
		
		sleep(250)
		
	end

	OnStop()

	while do_it do
	

		
		sleep(1000)
	end

end

