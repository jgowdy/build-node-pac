#!/bin/bash

echo "Verifying output"
stat ./node || echo "Node output not found" && exit 1
objdump --disassemble-all ./node | grep paciasap && echo PAC build successful && exit 0 || echo No PAC instructions found! && exit 1
