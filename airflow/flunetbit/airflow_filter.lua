function filter_khc_airflow_log(tag, timestamp, record)
    
    local log_message = record["log"]
    local timestamp_pattern = "(%d%d%d%d%-%d%d%-%d%d)T(%d%d:%d%d:%d%d)%.%d%d%d%+%d%d%d%d" -- 2024-12-04T07:39:13.984+0000
    local date, time = string.match(log_message, timestamp_pattern)
    
    if date and time then
        record["log_datetime"] = date .. " " .. time
    end

    record['ABC'] = 'ABC'

    return 1, timestamp, record

    -- -- Step 정보 추출 (예시)
    -- -- 로그 메시지 필터링
    -- --if string.match(log_message, "^%d%d/%d%d/%d%d %d%d:%d%d:%d%d (ERROR|INFO KHCLogger: Step %d+: %d+:%d+:%d+)") then
    -- if string.match(log_message, "^%d%d/%d%d/%d%d %d%d:%d%d:%d%d INFO KHCLogger: Step %d+: %d+:%d+:%d+") then
    --     return 1, timestamp, record
    -- elseif string.match(log_message, "^%d%d/%d%d/%d%d %d%d:%d%d:%d%d ERROR") then
    --     return 1, timestamp, record
    -- else
    --     return -1, timestamp, record
    -- end

end