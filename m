Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1C148E6
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2019 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFL1n (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 May 2019 07:27:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43015 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFL1n (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 May 2019 07:27:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so6218926plp.10
        for <linux-edac@vger.kernel.org>; Mon, 06 May 2019 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T8hpdmPuZ0S4pAwGaFbzxGbWzGiaXVlLtVKlfYx4iio=;
        b=Bk/ZFvOIuQWRmXzKFsuxJ00hiLtOb4ZoDbwp6eXMKveVW/RPVFwSmc44fPc/ZJ6GP/
         UTNJZvjSkvpNM0+QgnKNQ4n1Cb4+gjspV/eAFIqBhte+d/d+2PS8luAjgdceOT1Yfja4
         +LIKLTvzcRLnbIZPAvB4HYe9/o6QOm7iZk/Q+3GVZLJzdUBMQnsbrmo41YqHni6qkzDW
         EO9fUcW6TJ008kdJJjE6elBB/gfphZgHDOlc4JQT1t+mIKgi+RwuL2WOpOZsM75RzBS+
         FlzFYQS1FBTf9798vV6PzExx0JbJQysoxr6KdGIeOdUzZ0oMvBZKlf9AsJ7doLOOXsFG
         Dawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T8hpdmPuZ0S4pAwGaFbzxGbWzGiaXVlLtVKlfYx4iio=;
        b=Gkq5mtkB9KlpT2IJlpY2H/eM3BRrtiursn0PPtyxkLu/SRkfr54zDQqeCZzEDY0jYo
         USASkZgB1GOlGd0NGaLtwUG4VXK7gX3F4jpt8IZkcPI+QdJ3+l7+faBERc1z6ldHDUO0
         zVZfD8rkVaPP3o1RqHEU8/gV1Ghgs9LkdlTZWTfqyHbth1uT+ZMEEkhfmKAMXcB9qyQV
         6XO4DON3UYvT5tdO7xwBWwL7TJE5nk2yjC4pF6PScW6z333EnPHFZ46ju65xrzIoXtk2
         9yXgFWyhh/SjO1SKv+lTs7pv2hXwY6OOV3f34hN01FDaUHQotkC4qbyLgtQcq422qudq
         mtcw==
X-Gm-Message-State: APjAAAUecUCp21fav32DsnTziC7HY80X3XLQrUPwkOooPLTEuNIPx4Rf
        Y2M1RL9nRHybvSNiqk2K4O/uvE6sCyA=
X-Google-Smtp-Source: APXvYqwvAjJnxUVsUW1uW8HJ+SfIt8h2TIyySZXIVTncALvvJkEVjE2ZgjSeTQHCUfvKmF5+rETmxg==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr30112857plo.32.1557142062000;
        Mon, 06 May 2019 04:27:42 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id k4sm23990693pgh.27.2019.05.06.04.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 04:27:40 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com, bp@alien8.de, james.morse@arm.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mchehab@kernel.org, sachin.ghadi@sifive.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
Date:   Mon,  6 May 2019 16:57:06 +0530
Message-Id: <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557142026-15949-1-git-send-email-yash.shah@sifive.com>
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The initial ver of EDAC driver supports:
- ECC event monitoring and reporting through the EDAC framework for SiFive
  L2 cache controller.

The EDAC driver registers for notifier events from the L2 cache controller
driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
This patch depends on patch
'RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs'
https://lkml.org/lkml/2019/5/6/255

 MAINTAINERS                |   6 +++
 arch/riscv/Kconfig         |   1 +
 drivers/edac/Kconfig       |   6 +++
 drivers/edac/Makefile      |   1 +
 drivers/edac/sifive_edac.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 drivers/edac/sifive_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ba4f104..50f9f43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5679,6 +5679,12 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/sb_edac.c
 
+EDAC-SIFIVE
+M:	Yash Shah <yash.shah@sifive.com>
+L:	linux-edac@vger.kernel.org
+S:	Supported
+F:	drivers/edac/sifive_edac.c
+
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
 L:	linux-edac@vger.kernel.org
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82..31999a6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
 	select HAVE_EBPF_JIT if 64BIT
+	select EDAC_SUPPORT
 
 config MMU
 	def_bool y
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d1..3e05228 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -460,6 +460,12 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
 
+config EDAC_SIFIVE
+	bool "Sifive platform EDAC driver"
+	depends on EDAC=y && RISCV
+	help
+	  Support for error detection and correction on the SiFive SoCs.
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84..165ca65e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
+obj-$(CONFIG_EDAC_SIFIVE)		+= sifive_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
new file mode 100644
index 0000000..413cdb4
--- /dev/null
+++ b/drivers/edac/sifive_edac.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive Platform EDAC Driver
+ *
+ * Copyright (C) 2018-2019 SiFive, Inc.
+ *
+ * This driver is partially based on octeon_edac-pc.c
+ *
+ */
+#include <linux/edac.h>
+#include <linux/platform_device.h>
+#include "edac_module.h"
+#include <asm/sifive_l2_cache.h>
+
+#define DRVNAME "sifive_edac"
+
+struct sifive_edac_priv {
+	struct notifier_block notifier;
+	struct edac_device_ctl_info *dci;
+};
+
+/**
+ * EDAC error callback
+ *
+ * @event: non-zero if unrecoverable.
+ */
+static
+int ecc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	const char *msg = (char *)ptr;
+	struct sifive_edac_priv *p;
+
+	p = container_of(this, struct sifive_edac_priv, notifier);
+
+	if (event == SIFIVE_L2_ERR_TYPE_UE)
+		edac_device_handle_ue(p->dci, 0, 0, msg);
+	else if (event == SIFIVE_L2_ERR_TYPE_CE)
+		edac_device_handle_ce(p->dci, 0, 0, msg);
+
+	return NOTIFY_OK;
+}
+
+static int ecc_register(struct platform_device *pdev)
+{
+	struct sifive_edac_priv *p;
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->notifier.notifier_call = ecc_err_event;
+	platform_set_drvdata(pdev, p);
+
+	p->dci = edac_device_alloc_ctl_info(0, "sifive_ecc", 1, "sifive_ecc",
+					    1, 1, NULL, 0,
+					    edac_device_alloc_index());
+	if (IS_ERR(p->dci))
+		return PTR_ERR(p->dci);
+
+	p->dci->dev = &pdev->dev;
+	p->dci->mod_name = "Sifive ECC Manager";
+	p->dci->ctl_name = dev_name(&pdev->dev);
+	p->dci->dev_name = dev_name(&pdev->dev);
+
+	if (edac_device_add_device(p->dci)) {
+		dev_err(p->dci->dev, "failed to register with EDAC core\n");
+		goto err;
+	}
+
+	register_sifive_l2_error_notifier(&p->notifier);
+
+	return 0;
+
+err:
+	edac_device_free_ctl_info(p->dci);
+
+	return -ENXIO;
+}
+
+static int ecc_unregister(struct platform_device *pdev)
+{
+	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
+
+	unregister_sifive_l2_error_notifier(&p->notifier);
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(p->dci);
+
+	return 0;
+}
+
+static struct platform_device *sifive_pdev;
+
+static int __init sifive_edac_init(void)
+{
+	int ret;
+
+	sifive_pdev = platform_device_register_simple(DRVNAME, 0, NULL, 0);
+	if (IS_ERR(sifive_pdev))
+		return PTR_ERR(sifive_pdev);
+
+	ret = ecc_register(sifive_pdev);
+	if (ret)
+		platform_device_unregister(sifive_pdev);
+
+	return ret;
+}
+
+static void __exit sifive_edac_exit(void)
+{
+	ecc_unregister(sifive_pdev);
+	platform_device_unregister(sifive_pdev);
+}
+
+module_init(sifive_edac_init);
+module_exit(sifive_edac_exit);
+
+MODULE_AUTHOR("SiFive Inc.");
+MODULE_DESCRIPTION("SiFive platform EDAC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

