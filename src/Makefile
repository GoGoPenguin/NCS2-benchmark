SCRIPT_DIR=./scripts

.PHONY: all
all:
	${SCRIPT_DIR}/freeze.sh
	${SCRIPT_DIR}/optimizer.sh
	${SCRIPT_DIR}/inference.sh

.PHONY: inference
inference:
	${SCRIPT_DIR}/inference.sh

.PHONY: optimizer
optimizer:
	${SCRIPT_DIR}/optimizer.sh

.PHONY: freeze
freeze:
	${SCRIPT_DIR}/freeze.sh