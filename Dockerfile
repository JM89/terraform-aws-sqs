FROM zenika/terraform-aws-cli:release-7.0_terraform-1.3.9_awscli-2.12.5

COPY --chown=nonroot main.tf ./
COPY --chown=nonroot outputs.tf ./
COPY --chown=nonroot variables.tf ./

COPY --chown=nonroot ./examples/ ./examples/

ENTRYPOINT [ "bash", "examples/entrypoint.sh" ]