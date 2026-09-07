# Disaster Recovery

## Recovery sequence

1. Confirm the incident boundary and freeze deployments.
2. Restore or select a known-good state version.
3. Reconcile the state against existing Azure resources.
4. Plan the reviewed commit in the recovery region or subscription.
5. Restore application data using its service-specific procedure.
6. Deploy an immutable image digest and execute smoke tests.
7. Re-enable traffic and document recovery metrics.

| Asset | Recovery source |
|---|---|
| Infrastructure | Git commit plus protected remote state |
| Container image | Immutable registry digest and replication |
| Secrets | Key Vault recovery and documented rotation procedure |
| Telemetry | Log Analytics retention/export policy |

The example is single-region. A production RTO/RPO requires paired-region design and tested data replication.
