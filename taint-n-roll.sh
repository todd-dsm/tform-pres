#!/usr/bin/env bash
#  PURPOSE: Description
# -----------------------------------------------------------------------------
#  PREREQS: a)
#           b)
#           c)
# -----------------------------------------------------------------------------
#  EXECUTE: ./taint-n-roll.sh -v -n 5 --cluster yo
# -----------------------------------------------------------------------------
#     TODO: 1)
#           2)
#           3)
# -----------------------------------------------------------------------------
#   AUTHOR: Todd E Thomas
# -----------------------------------------------------------------------------
#  CREATED: 2017/06/27
# -----------------------------------------------------------------------------
#set -x


###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
# ENV Stuff
# Data Files


###----------------------------------------------------------------------------
### FUNCTIONS
###----------------------------------------------------------------------------
### Print usage info
###----------------------------------------------------------------------------
show_help() {
    printf '%s\n' """
    Usage: ${0##*/} [-hv] [-f OUTFILE] [FILE]...
    Do stuff with FILE and write the result to standard output. With no FILE
    or when FILE is -, read standard input.

        -h          display this help and exit
        -f OUTFILE  write the result to OUTFILE instead of standard output.
        -v          verbose mode. Can be used multiple times for increased
                    verbosity.
    """
}

###---
### Straighten out the numbers for those time when we're tired
###---
exportNumbers() {
    maxCount="$1"
    #maxCount="$((maxCount+1))"
    minCount="0"
}

###---
### Taint N Roll
###---
procCluster() {
    for (( nodeNo = "$minCount"; nodeNo < "$maxCount"; nodeNo++ )); do
        printf '%s\n' "Tainting cluster $nodeNo..."
        terraform taint "$targetCluster.$nodeNo"
        printf '%s\n' "Rolling the node..."
        terraform apply
    done
}


###----------------------------------------------------------------------------
### MAIN PROGRAM
###----------------------------------------------------------------------------
### Reset any variables to avoid contamination
###---
targetCluster=''

###---
### Process the options
###---
while :; do
    case $1 in
        -h|-\?|--help)
            show_help    # Display a usage synopsis.
            exit
            ;;
        -c|--cluster)
            export targetCluster="$2"
            shift 1
            ;;
        -n|--node-number)
            exportNumbers "$2"
            shift 1
            ;;
        -v|--verbose)
            set -x
            ;;
        --)              # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: No more options, so break out of the loop.
            break
    esac
    shift
done


###---
### if we have everything, let's do it
###---
if [[ -z "$targetCluster" ]] && \
   [[ -z "$maxCount" ]]; then
    printf '%s\n' "You forgot the cluster name."
else
    procCluster
fi



###---
### REQ
###---


###---
### REQ
###---


###---
### fin~
###---
exit 0
