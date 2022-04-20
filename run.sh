node_bin=$1
yamls=$2
base_path=$3
additional_args=$4
rust_log="gwasm=debug,gear_core_processor=debug,runtime=debug,gear_backend_sandbox=debug,gear_backend_wasmtime=debug"

npm i > /dev/null
npm run build

RUST_LOG=$rust_log $node_bin --dev --ws-max-out-buffer-capacity 500 --rpc-max-payload 500 -l 1 $additional_args > out 2>&1  &
sleep 15

node ./dist/index.js $yamls --base_path=$3
kill %1
