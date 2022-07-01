# Obtaining the Portworx configuration

This module requires a Portworx configuration.   Portworx is available in 2 flavors: `Enterprise` and `Essentials`.

- **Portworx Essentials** is free forever, but only supports a maximum of 5 nodes on a cluster, 200 volumes, and 5TB of storage.   
- **Portworx Enterprise** requires a subscription (has 30 day free trial), supports over 1000 nodes per cluster, and has unlimited storage.

The instructions below provide the steps required to obtain the configuration values needed to deploy Portworx in a cluster

## Essentials

1. Launch the [spec generator](https://central.portworx.com/specGen/wizard)

2. Press _Continue_ on the `Portworx Enterprise` product.

3. Select the `Portworx Essentials` license radio button and press _Continue_.

4. Check `Use the Portworx Operator` box, select the **Portworx version** as `2.6` then press _Next_.

5. Select `Cloud` for the **Select your environment** option then select `AWS` or `Azure` for the **Cloud Platform**, as appropriate. Next select the `Create Using a Spec` option for **Select type of disk**. Leave the **Volume type** as `Premium` and enter a value of `1000` for **Size (GB)**. Press _Next_ to continue.

6. Leave `auto` as the value for **Data Network Interface** and **Management Network Interface** then press _Next_.

7. Select `Openshift 4+` as Container service then go to **Advanced Settings**. Check `Enable Stork`, `Enable CSI`, `Enable Monitoring`, and `Enable Telemetry` then press _Finish_.

8. Click _Download_ to download a copy of the spec file.

## Enterprise

1. Launch the [spec generator](https://central.portworx.com/specGen/wizard)

2. Press **Continue** on the `Portworx Enterprise` product.

3. Select the `Portworx Enterprise` license radio button and press _Continue_.

4. Select the `Portworx Enterprise` license radio button and press _Continue_.

5. Check `Use the Portworx Operator` box, select the **Portworx version** as `2.6` and **ETCD** as `Built-in` then press _Next_.

6. Select `Cloud` for the **Select your environment** option then select `AWS` or `Azure` for the **Cloud Platform**, as appropriate. Next select the `Create Using a Spec` option for **Select type of disk**. Leave the **Volume type** as `Premium` and enter a value of `1000` for **Size (GB)**. Press _Next_ to continue.

7. Leave `auto` as the value for **Data Network Interface** and **Management Network Interface** then press _Next_.

8. Select `Openshift 4+` as Container service then go to **Advanced Settings**. Check `Enable Stork`, `Enable CSI`, `Enable Monitoring`, and `Enable Telemetry` then press _Finish_.

9. Select `Openshift 4+` as Container service then go to **Advanced Settings**. Check `Enable Stork`, `Enable CSI`, `Enable Monitoring`, and `Enable Telemetry` then press _Finish_.

10. Click _Download_ to download a copy of the spec file.
