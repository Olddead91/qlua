function OnInit()

	folder_id = "C:\\files\\"
	file_name = "test.csv"
	
end

function main()

	if FileSize(folder_id .. file_name) == nil then
		message("���� " .. file_name .. " �� ������") 
	else
		message("������ ����� " .. file_name .. " ����� " .. FileSize(folder_id .. file_name) .. " ����")
		FileStatus()
	end
	
end

-- �������� ������� �����
-- ���� ����, �� ������ ������ ����� � ������
function FileSize(file)

   local size
 
   if type(file) == "string" then
      local f,err = io.open(file,"r")
      if not f then return nil,err end
      size = FileSize(f)
      f:close()
   else
      local current_position = file:seek() 
      size = file:seek("end")
      file:seek("set", current_position)
   end
   return size
   
end

-- ������ �����
function FileStatus()

	-- ��������� ���� ��� ������
	DirectionOpenFile=tostring(folder_id .. file_name) 
	FileStatus = io.open(DirectionOpenFile, "a+");

	string_file = {}

	if FileStatus ~= nil then

		--�������� ���������
		index_for_string_file = 1
		string_file[index_for_string_file] = FileStatus:read("*l")
		
		if string_file[index_for_string_file] ~= nil then

			while string_file[index_for_string_file] ~= nil do
				index_for_string_file = index_for_string_file + 1
				string_file[index_for_string_file] = FileStatus:read("*l")
			end
		
		end
		
		-- ���� ������ ����� �� �������� � ������ �������� �������, �� ���� ����
		if #string_file == 1 and string_file[1] == "" then
			message("���� " .. folder_id .. file_name .. " ����")
			status_file = 0
		end
		
		FileStatus:close()
	else
		message("���� "..folder_id .. file_name.." ������ ������ ����������.")
	end
	
end