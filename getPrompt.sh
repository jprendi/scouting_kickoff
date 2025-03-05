#!/bin/bash

FILEINPUT_TEMPLATE=$(tr -d '\r' < file_list.txt | tr '\n' ',' | sed 's/,$//')

hltGetConfiguration /dev/CMSSW_14_1_0/GRun \
--globaltag 140X_dataRun3_Prompt_v4 \
--input "$FILEINPUT_TEMPLATE" \
--max-events 10000 \
--output none \
--unprescale \
--eras Run3_2024 \
--l1-emulator uGT --l1 L1Menu_Collisions2024_v1_3_0_xml \
--paths ScoutingPFOutput,\
DST_PFScouting_*,\
Dataset_ScoutingPFRun3 \
> reHLT_Prompt_Tag.py


cat <<@EOF >> reHLT_Prompt_Tag.py
process.hltOnlineBeamSpotESProducer.timeThreshold = 0
process.GlobalTag.JsonDumpFileName =cms.untracked.string("CondDBESSource.json")
@EOF

cmsRun reHLT_Prompt_Tag.py >& reHLT_Prompt.log

mv DQMIO.root DQMIO_PromptTag.root
mv outputScoutingPF.root outputScoutingPF_PromptTag.root
mv CondDBESSource.json CondDBESSource_PromptTag.json

