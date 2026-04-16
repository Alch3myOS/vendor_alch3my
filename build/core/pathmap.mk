#
# Alch3myOS Project Path Mapping Utilities
#

# $(1): project name
# $(2): source path
define project-set-path
$(eval pathmap_PROJ += $(1):$(2))
endef

# $(1): list of project names
define project-path-for
$(foreach n,$(1),$(patsubst $(n):%,%,$(filter $(n):%,$(pathmap_PROJ))))
endef
