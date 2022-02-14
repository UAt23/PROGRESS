.PHONY: run_website install_kind install_kubectl create_kind_cluster \ 
	install_brew create_docker_registry connect_registry_to_kind_network \
	connect_registry_to_kind create_kind_cluster_with_registry 


run_website:
	docker build -t explorecalifornia.com . && \
		docker run -p 5000:80 -d --name explorecalifornia.com --rm explorecalifornia.com

install_brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install_kind:
	brew install kind

install_kubectl:
	brew install kubectl

create_kind_cluster: install_brew install_kind install_kubectl
	kind create cluster --name explorecalifornia.com || true && \
		kubectl get nodes
	
create_docker_registry:
	if docker ps | grep -q 'local-registry'; \
	then echo "---> local-registry already created; skipping"; \
	else docker run --name local-registry -d --restart=always -p 5000:5000 registry:2; \
	fi

connect_registry_to_kind_network:
	docker network connect kind local-registry || true

connect_registry_to_kind: connect_registry_to_kind_network
	kubectl apply -f ./kind_configmap.yaml

create_kind_cluster_with_registry:
	$(MAKE) create_kind_cluster && $(MAKE) connect_registry_to_kind
