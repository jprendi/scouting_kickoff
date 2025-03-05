# Rerunning HLT with only Scouting paths

In order to rerun the HLT with only the Scouting paths, using different tags, one needs to slightly adap the input arguments when calling the `hltGetConfiguration` command. We also want to get a .json file as an output from the conditions database. Simply run:
```
git clone git@github.com:jprendi/scouting_kickoff.git
cd scouting_kickoff

./getHLT.sh
./getPrompt.sh
```
This will output various things: .root, .log and .json files. As a first step, we are interested in seeing how much the prompt vs HLT tag differ. For that we can run
```
python3 diff_jsons.py --file1 CondDBESSource_HLTTag.json --file2 CondDBESSource_PromptTag_TT.json >& tag_diffs_tenk.txt
```

which in turn will give us the output file named `tag_diffs_tenk.txt` that enables us to look at the differences.

