TargetDir = $(HOME)

ScriptSources := $(wildcard bin_scripts/*)
StartUpAdditions := $(wildcard shell_functions/*)

BinDir := $(TargetDir)/bin
ScriptTargets := $(addprefix $(BinDir)/,$(notdir $(ScriptSources)))

ShStartUpFile := .bashrc
ShStartUpPath := $(TargetDir)/$(ShStartUpFile)

# Do a dry run into the local dir fake_home
dry_run:
	@echo doing dry run into fake_home
	mkdir -p fake_home
	make TargetDir=fake_home install

# Really install the files
install: init copy_scripts startup_additions

init: $(BinDir)

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

$(ShStartUpPath):
	touch $@

startup_additions: $(ShStartUpPath)
	sed -i.bak '/#START ADDITIONS/,/#END ADDITIONS/d' $(ShStartUpPath)
	echo '#START ADDITIONS' >> $(ShStartUpPath)
	echo  >> $(ShStartUpPath)
	cat $(StartUpAdditions) >> $(ShStartUpPath)
	echo  >> $(ShStartUpPath)
	echo '#END ADDITIONS' >> $(ShStartUpPath)
