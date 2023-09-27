# PUG2023-WASM-Examples
Examples shown in the 2023 is the year of WASM presentation at PUGChallenge 2023

The LicenceLog examples contain two seperate forms, the first demonstrates key value pair storage using webassembley microservices, the second demonstrates using LLama2 to provide sentiment analysis for OpenEdge. 
For both of these, you will need to download and install spin (canary version required for LLM example) https://github.com/fermyon/spin/releases/download/canary/spin-canary-windows-amd64.zip 
Place the contents in a directory and add directory to PATH environmental variable. 
KVP project available from https://github.com/technosophos/all-kv-functions
Sentiment Analysis project is available from https://github.com/fermyon/ai-examples/tree/main/sentiment-analysis-ts and stick in a folder (for example d:\workdir\llama\)
Sentiment Analysis project requires a local copy of the LLM. Download from https://huggingface.co/meta-llama. File should be renamed llama2-chat and placed in the dir [sentiment analysis project root]\.spin\ai-models
