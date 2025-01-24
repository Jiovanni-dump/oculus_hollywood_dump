#!/vendor/bin/sh

SWAP_FILE="/data/vendor/flashswap/swap.dat"

create_swap_file() {
  dd if=/dev/zero of=$SWAP_FILE bs=1MB count=512 || return
  mkswap $SWAP_FILE || return
}

# Create a swap file if it doesn't exist or has incorrect size
if [[ -f $SWAP_FILE ]]; then
  SWAP_FILE_SIZE=$(stat --format=%s "$SWAP_FILE")
  if [ "$SWAP_FILE_SIZE" -ne "536870912" ]; then
    swapoff $SWAP_FILE
    rm $SWAP_FILE || return
    create_swap_file
  fi
else
  create_swap_file
fi

# Enable swap
swapon -p 5 $SWAP_FILE || return
