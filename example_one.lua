function OnInit()
-- �������������� ���������� ���������� � ���������
progname="example_one: "
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


while do_it do

	sleep(1000)
end

end

