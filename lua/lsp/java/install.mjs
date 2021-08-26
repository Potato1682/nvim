await $`git clone https://github.com/dgileadi/vscode-java-decompiler --depth 1 --recursive java-decompiler`
await $`git clone https://github.com/eclipse/eclipse.jdt.ls.git --depth 1 --recursive`
await $`mkdir -pv lombok`

const lombokDownloadUri = "https://projectlombok.org/downloads/lombok.jar"

await $`wget -O lombok/lombok.jar ${lombokDownloadUri}`

cd("eclipse.jdt.ls")

await $`./mvnw clean verify -DskipTests`
