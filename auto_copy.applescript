tell application "Finder"
	set musicFolder to "Macintosh HD:Users:huytrinh:Music:"
	set pace3musicFolder to "PACE 3:Music:"
	set fileList to every file in folder musicFolder whose name extension is "mp3"
	set pace3fileList to every file in folder pace3musicFolder whose name extension is "mp3"
	set mp3Names to {}
	set pace3mp3Names to {}
	
	-- Lấy tên của các file mp3 trong thư mục Music
	repeat with aFile in fileList
		set end of mp3Names to name of aFile
	end repeat
	
	-- Lấy tên của các file mp3 trong thư mục PACE3:Music
	repeat with aFile in pace3fileList
		set end of pace3mp3Names to name of aFile
	end repeat
end tell

-- Hàm để nối các phần tử của một danh sách thành một chuỗi, sử dụng một ký tự phân cách
on join(theList, theDelimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theDelimiter
	set theString to theList as string
	set AppleScript's text item delimiters to oldDelimiters
	return theString
end join

-- Hiển thị danh sách tên file mp3 từ thư mục Music
set output to "Danh sách file mp3 trong thư mục Music:
" & join(mp3Names, return) & return

-- Thêm danh sách tên file mp3 từ thư mục PACE3:Music
set output to output & "

Danh sách file mp3 trong thư mục PACE3:Music:
" & join(pace3mp3Names, return) & return

-- Hàm để lọc các phần tử có trong list1 nhưng không có trong list2
on filterList(list1, list2)
	set resultList to {}
	repeat with i from 1 to count list1
		set currentItem to item i of list1
		if list2 does not contain currentItem then
			set end of resultList to currentItem
		end if
	end repeat
	return resultList
end filterList

-- Lọc ra các tên file mp3 có trong thư mục Music nhưng không có trong thư mục PACE3:Music
set uniqueMp3Names to filterList(mp3Names, pace3mp3Names)

-- Hiển thị danh sách tên file mp3 duy nhất từ thư mục Music
set output to output & "

Danh sách file mp3 chỉ có trong thư mục Music:
" & join(uniqueMp3Names, return) & return

-- Hàm để sao chép file từ nguồn đến đích
on copyFile(source, destination)
	tell application "Finder"
		duplicate file source to folder destination with replacing
	end tell
end copyFile

-- Duyệt qua danh sách tên file mp3 duy nhất và sao chép chúng
repeat with mp3Name in uniqueMp3Names
	set sourceFile to (musicFolder & mp3Name) as string
	set destinationFolder to pace3musicFolder as string
	my copyFile(sourceFile, destinationFolder)
end repeat


display dialog output
