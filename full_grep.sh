full_grep()
{
        local keyword=$1
        # mark the new line
        # local newLinePattern="^d{2}\/d{2}\/d{2} d{2}:d{2}:d{2}"
        #local newLinePattern="^[0-9]{2}\/[0-9]{2}\/[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}"
        local newLinePattern="^(DEBUG|INFO|WARN|ERROR) "
        cat | awk  '
                        BEGIN{
                                isFound = "no"
                        }

                        # match lines with keyword
                        {
                                # if match print the line
                                if($0~/'"$keyword"'/)
                                {
                                        print $0
                                        isFound="yes"
                                }
                                # if new line begin
                                else if($0~/'"$newLinePattern"'/)
                                {
                                        isFound="no"
                                }
                                # if no line found, print continuely
                                else if(isFound=="yes")
                                {
                                        print $0
                                }
                        }
                        '
}
full_grep $@
