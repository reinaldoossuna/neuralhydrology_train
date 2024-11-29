set export 

config_dir := "./configs"
config_default := "config.yml"

data_dir := "./data"
run_dir := "./runs"

last_model := `ls -1t ./runs | head -n1`

default:
  @just --choose

tboard: 
	.venv/bin/tensorboard --logdir {{run_dir}}

choose:
	@just train $(ls -1t {{config_dir}} | fzf)

train config=( config_default ): 
	.venv/bin/nh-run train --config-file {{config_dir / config}}

eval model_dir=last_model: 
	.venv/bin/nh-run evaluate --run-dir {{run_dir/model_dir}}
