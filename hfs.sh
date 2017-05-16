#!/bin/zsh

echo Starting HTTP file server!
function Main {
    echo Starting HTTP file server!
    cd /data/share || ( echo Share directory missing. Exiting!!! && exit )
    python -m http.server 
}
Main &> /tmp/${${0:t}:r}.log

