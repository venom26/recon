#!/bin/bash

mkdir nuclei_op
nuclei -l alive.txt -t "/root/tools/nuclei-templates/cves/*.yaml" -c 60 -o nuclei_op/cves.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/files/*.yaml" -c 60 -o nuclei_op/files.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/panels/*.yaml" -c 60 -o nuclei_op/panels.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/security-misconfiguration/*.yaml" -c 60 -o nuclei_op/security-misconfiguration.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/technologies/*.yaml" -c 60 -o nuclei_op/technologies.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/tokens/*.yaml" -c 60 -o nuclei_op/tokens.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/vulnerabilities/*.yaml" -c 60 -o nuclei_op/vulnerabilities.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/basic-detections/*.yaml" -c 60 -o nuclei_op/basic.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/dns/*.yaml" -c 60 -o nuclei_op/dns.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/examples/*.yaml" -c 60 -o nuclei_op/examples.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/subdomain-takeover/*.yaml" -c 60 -o nuclei_op/subdomain-takeover.txt
