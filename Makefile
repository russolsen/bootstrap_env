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
	cat $(StartUpAdditions) >> $(BinDir)/startup_additions.sh
	sed -i.bak '/#START ADDITIONS/d' $(ShStartUpPath)
	echo 'source $(BinDir)/startup_additions.sh    #START ADDITIONS' >> $(ShStartUpPath)
