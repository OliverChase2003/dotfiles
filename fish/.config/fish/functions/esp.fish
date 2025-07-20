function esp
    if not set -q IDF_PATH
        . /home/oliver/.softwares/esp-idf/export.fish
    end

    if count $argv >/dev/null
        idf.py $argv
    end
end
