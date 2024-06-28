Return-Path: <linux-edac+bounces-1431-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC191BB00
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415852853F5
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38179152179;
	Fri, 28 Jun 2024 09:06:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305F14E2F9
	for <linux-edac@vger.kernel.org>; Fri, 28 Jun 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565581; cv=none; b=cjjg75dTiH03Ypp6MwrP2N6yfLheSWJfDk+czcUgrYME5IZI0Xq8TaXDa27X2lp5CDudcZutTQy+rme0s+80/6ebcybjCVhIY1DvwDafBOlKSaUuCctso2IfVys1i4nTkYVCCpCLbZoU1ZunY5nf17V/8SjugfnVCtpA/a/sWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565581; c=relaxed/simple;
	bh=AMwNtq3Gr4uFVQBZiS+FjfadSe3QGx9rv52amyQOcco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpTb+BSG5M9UDYt8WFNvhvqdK28QRbvCh2KY40gGtT3rnOQmt1KYGn+ZrmA4qH2EAkvqqthPTk30SsYwMKt4j6vHmQic5KeSlqMgcfUMkRIOBp5vwmlvlvFBBb3ir/fs9IMOI/MnXt1tXsU8/4+5hIRX+hHcDoGmqkV+WtkVIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W9Tzp6wKkz6K69p;
	Fri, 28 Jun 2024 17:05:26 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id CA0291406AC;
	Fri, 28 Jun 2024 17:06:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.147.160) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 10:06:14 +0100
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
	<linux-edac@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 1/3 qemu] arm/virt: Wire up GPIO error source for ACPI / GHES
Date: Fri, 28 Jun 2024 10:06:02 +0100
Message-ID: <20240628090605.529-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240628090605.529-1-shiju.jose@huawei.com>
References: <20240628090605.529-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Creates a GED - Generic Event Device and set a GPIO to
be used or error injection.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
 hw/arm/virt.c            | 12 +++++++++++-
 include/hw/boards.h      |  1 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b2366f24f9..998bf01743 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -63,6 +63,7 @@
 
 #define ARM_SPI_BASE 32
 
+#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 
 static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
@@ -155,9 +156,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
 
     Aml *aei = aml_resource_template();
     /* Pin 3 for power button */
-    const uint32_t pin_list[1] = {3};
+    uint32_t pin = 3;
     aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
+                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
+                                 "GPO0", NULL, 0));
+    pin = 6;
+    /* Pin 8 for generic error */
+    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
+                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
                                  "GPO0", NULL, 0));
     aml_append(dev, aml_name_decl("_AEI", aei));
 
@@ -166,6 +172,11 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                   aml_int(0x80)));
     aml_append(dev, method);
+    method = aml_method("_E06", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name(ACPI_GENERIC_EVENT_DEVICE),
+                                  aml_int(0x80)));
+    aml_append(dev, method);
+
     aml_append(scope, dev);
 }
 
@@ -794,6 +805,15 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static void acpi_dsdt_add_generic_event_device(Aml *scope)
+{
+    Aml *dev = aml_device(ACPI_GENERIC_EVENT_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+    aml_append(scope, dev);
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -836,9 +856,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                       irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
                       memmap[VIRT_ACPI_GED].base);
     } else {
-        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
-                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
     }
+    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
+                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
 
     if (vms->acpi_dev) {
         uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
@@ -852,6 +872,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    acpi_dsdt_add_generic_event_device(scope);
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0784ee7f46..6d96bb2482 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -993,6 +993,13 @@ static void create_rtc(const VirtMachineState *vms)
 }
 
 static DeviceState *gpio_key_dev;
+
+static DeviceState *gpio_error_dev;
+static void virt_set_error(void)
+{
+    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
+}
+
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
     VirtMachineState *s = container_of(n, VirtMachineState, powerdown_notifier);
@@ -1010,6 +1017,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
 {
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
+    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
+                                          qdev_get_gpio_in(pl061_dev, 6));
 
     qemu_fdt_add_subnode(fdt, "/gpio-keys");
     qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
@@ -2381,8 +2390,8 @@ static void machvirt_init(MachineState *machine)
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
-        create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
+    create_gpio_devices(vms, VIRT_GPIO, sysmem);
 
     if (vms->secure && !vmc->no_secure_gpio) {
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
@@ -3096,6 +3105,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "mach-virt.ram";
     mc->default_nic = "virtio-net-pci";
 
+    mc->set_error = virt_set_error;
     object_class_property_add(oc, "acpi", "OnOffAuto",
         virt_get_acpi, virt_set_acpi,
         NULL, NULL);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 73ad319d7d..fe23750456 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -304,6 +304,7 @@ struct MachineClass {
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
     ram_addr_t (*fixup_ram_size)(ram_addr_t size);
+    void (*set_error)(void);
 };
 
 /**
-- 
2.34.1


