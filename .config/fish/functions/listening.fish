function listening
    lsof -iTCP -sTCP:LISTEN -n -P
end
