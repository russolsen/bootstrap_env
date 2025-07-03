#TargetDir = $(HOME)
TargetDir = qqqfake_home

ScriptSources := $(wildcard bin_scripts/*)
StartUpAdditions := $(wildcard shell_functions/*)

#BinDir := $(HOME)/bin
BinDir := $(TargetDir)/bin
ScriptTargets := $(addprefix $(BinDir)/,$(notdir $(ScriptSources)))

ShStartUpFile := .bash_profile
ShStartUpPath := $(TargetDir)/$(ShStartUpFile)

dry_run:
	echo doing dry run into fake_home
	mkdir -p fake_home
	make TargetDir=fake_home setup_files

default: setup_files

init: $(BinDir)

setup_files: init copy_scripts startup_additions

$(BinDir):
	mkdir -p $(BinDir)

debug:
	@echo Debug
	@echo bin dir $(BinDir)
	@echo

copy_scripts: $(ScriptTargets)

$(BinDir)/%: bin_scripts/% 
	cp $< $@
	chmod o+x $@

startup_additions:
	sed -i '.bak' '/#START ADDITIONS/,/#END ADDITIONS/d' $(ShStartUpPath)
	echo '#START ADDITIONS' >> $(ShStartUpPath)
	echo  >> $(ShStartUpPath)
	cat $(StartUpAdditions) >> $(ShStartUpPath)
	echo  >> $(ShStartUpPath)
	echo '#END ADDITIONS' >> $(ShStartUpPath)
