.PHONY: run_website install_kind

run_website:
	docker build -t explorecalifornia.com . && \
		docker run -p 5001:80 -d --name explorecalifornia.com --rm explorecalifornia.com

install_kind:
	curl --location --output ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.11.1/kind-windows-amd64 && ./kind --version
