function filter_khc_yarn_log(tag, timestamp, record)
    
    local path = record["file_path"]
    local applicationid = string.match(path, "application_%d+_%d+")
    
    if applicationid then
        record["applicationid"] = applicationid
    end
    
    local message = record["log"]
    -- local a, b, c, d = string.match(message, "(%d%d/%d%d/%d%d) (%d%d:%d%d:%d%d) (%u+) (KHCLogger: Step %d+: %d+:%d+:%d+)?")  
    
    
    -- if c then
    --     print("KHCLogger")
    --     print(c)
    -- end 

    -- if a and b and c then 
    --     if string.match(c, "ERROR") then
    --         print("ERROR")
    --     end
    -- end

    -- Step 정보 추출 (예시)
    -- 로그 메시지 필터링
    if string.match(message, "^%d%d/%d%d/%d%d %d%d:%d%d:%d%d INFO KHCLogger: Step %d+: %d+:%d+:%d+") then

        local date, time, level = string.match(message, "(%d%d/%d%d/%d%d) (%d%d:%d%d:%d%d) (%u+)")
        local day, month, year = string.match(date, "(%d%d)/(%d%d)/(%d%d)")
        local formatted_date = string.format("20%s-%s-%s", year, month, day)

        record["log_date"] = formatted_date
        record["log_time"] = time
        record["log_level"] = level
        record["log_datetime"] = formatted_date .. " " .. time

        return 1, timestamp, record
    elseif string.match(message, "^%d%d/%d%d/%d%d %d%d:%d%d:%d%d ERROR") then

        local date, time, level = string.match(message, "(%d%d/%d%d/%d%d) (%d%d:%d%d:%d%d) (%u+)")
        local day, month, year = string.match(date, "(%d%d)/(%d%d)/(%d%d)")
        local formatted_date = string.format("20%s-%s-%s", year, month, day)

        record["log_date"] = formatted_date
        record["log_time"] = time
        record["log_datetime"] = formatted_date .. " " .. time
        record["log_level"] = level

        return 1, timestamp, record
    else
        return -1, timestamp, record
    end

end