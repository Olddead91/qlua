function OnInit()
	do_it = true
end

function OnStop()
	do_it = false
end


function OnAllTrade(alltrade)
	
	if alltrade.sec_code=="SBER" then
	
		lastprice	= alltrade.price 	-- ����
		lastvolume	= alltrade.qty 		-- ����������
		lastvalue 	= alltrade.value 	-- ������
		
		
		if lastvolume >= 100 then
		
			if bit.test(alltrade.flags, 0) then  
				message("�������: ����������: "..lastvolume.." ����: "..lastprice.." ������: "..lastvalue)
			end
			if bit.test(alltrade.flags, 1) then 
				message("�������: ����������: "..lastvolume.." ����: "..lastprice.." ������: "..lastvalue)
			end		
			
		end
		
	end
end

function main()

	
	while do_it do 
		sleep(1000) 
	end


end