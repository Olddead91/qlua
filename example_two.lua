function OnInit()
-- �������������� ���������� ���������� � ���������
	progname="example_two: "
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

		for i=1, 10 do
		
			time1 = os.sysdate()
			time2 = getInfoParam('SERVERTIME')

			time_txt=time1.hour..":"..time1.min..":"..time1.sec
			message("����� ����� os.sysdate: "..time_txt.." ����� SERVERTIME:"..time2)
			sleep(250)
			
		end


	while do_it do
	

		
		sleep(1000)
	end

end

