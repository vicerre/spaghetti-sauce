git clone --depth=1 --filter=blob:none --sparse https://github.com/vicerre/spaghetti-ice.git
cd spaghetti-ice
git sparse-checkout set --no-cone '**/*.md'
