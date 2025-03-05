#!/bin/bash

FILEINPUT_TEMPLATE=$(tr -d '\r' < file_list.txt | tr '\n' ',' | sed 's/,$//')

hltGetConfiguration /dev/CMSSW_14_1_0/GRun \
--globaltag 141X_dataRun3_HLT_v2 \
--input "$FILEINPUT_TEMPLATE" \
--max-events 10000 \
--output none \
--unprescale \
--eras Run3_2024 \
--l1-emulator uGT --l1 L1Menu_Collisions2024_v1_3_0_xml \
--paths ScoutingPFOutput,\
DST_PFScouting_*,\
Dataset_ScoutingPFRun3 \
> reHLT_HLT_Tag.py


cat <<@EOF >> reHLT_HLT_Tag.py
process.GlobalTag.JsonDumpFileName =cms.untracked.string("CondDBESSource.json")
@EOF

cmsRun reHLT_HLT_Tag.py >& reHLT_HLT.log

mv DQMIO.root DQMIO_HLTTag.root
mv outputScoutingPF.root outputScoutingPF_HLTTag.root
mv CondDBESSource.json CondDBESSource_HLTTag.json
