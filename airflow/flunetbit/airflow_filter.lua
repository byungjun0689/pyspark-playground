function filter_khc_airflow_log(tag, timestamp, record)

    local file_path = record['file_path']

    -- /opt/airflow/logs/dag/error_dag/2024-12-5.log 
    local dag_name_pattern = "/opt/airflow/logs/dag/([^/]+)/" 
    local dag_name = string.match(file_path, dag_name_pattern)
    if dag_name then
        record["dag_name"] = dag_name
    end

    local log_line = record["log"]
    local pattern = "time:(%d+%-%d+%-%d+)T(%d+:%d+:%d+%.%d+%+0000)%s%sfilename:([^%s]+)%s%slevel_info:(%w+)%s%smessage:(.*)"
    local date, time, filename, level, message = string.match(log_line, pattern)

    local log_data = {
        date = date,
        time = time,
        filename = filename,
        level = level,
        message = message
    }
    
    record.log = nil

    if log_data then
        record["log_datetime"] = date .. "T" .. time
        record["log_date"] = date
        local time_pattern = "(%d%d:%d%d:%d%d).%d+%+0000"
        local time_slice = string.match(log_data.time, time_pattern)
        record["log_time"] = time_slice
        record["filename"] = log_data.filename
        record["log_level"] = log_data.level
        record["message"] = log_data.message

        return 1, timestamp, record
    else
        return -1, timestamp, record
    end
end