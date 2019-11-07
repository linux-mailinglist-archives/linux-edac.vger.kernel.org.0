Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5837EF2A71
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 10:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKGJVB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 04:21:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfKGJVB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 Nov 2019 04:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o3OnBnpIuSKUqIXrLFlcbWSlhPvDMgZ5tGt9U5+sDhc=; b=OvxFDzvUKn5HxJMhipiTji+mJ
        wiiGIRCBgWApvisU1dSVmHsz8iufYfLPiGMWwK3qzmbkvRHyqZXH1PNg66NVk1A3sdoBMoSu0EcYo
        V80jislFQAYtg3Z3nWDXOFhwERBIwygtE4bYHcBmYT+4OomCdtomHlmqHe0CoiiSHdDNwD02kVQ4S
        1XP4VB9rKfC5Ey8fDgYnL0ljLudf9wjx2wlhX+wvLQ97FTXEvE0vhnSyMnYsRZhJqZ1HjopD/wH89
        vPjYpY8yibNu28aO5qp/AyflHig0+yU6MA9U4GV5Oi+DAVQnEH+aNM0KdAPSYMHHJCFDmsyJnuUif
        KeFFf8mtw==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSdyH-0003qI-Qk; Thu, 07 Nov 2019 09:20:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, yash.shah@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
Subject: [PATCH v2] riscv: move sifive_l2_cache.c to drivers/soc
Date:   Thu,  7 Nov 2019 10:20:39 +0100
Message-Id: <20191107092039.32240-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The sifive_l2_cache.c is in no way related to RISC-V architecture
memory management.  It is a little stub driver working around the fact
that the EDAC maintainers prefer their drivers to be structured in a
certain way that doesn't fit the SiFive SOCs.

Move the file to drivers/soc and add a Kconfig option for it, as well
as the whole drivers/soc boilerplate for CONFIG_SOC_SIFIVE.

Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v2:
 - don't allow modular builds
 - remove the empty last line in the new Makefile

 MAINTAINERS                                            |  1 +
 arch/riscv/mm/Makefile                                 |  1 -
 drivers/edac/Kconfig                                   |  2 +-
 drivers/soc/Kconfig                                    |  1 +
 drivers/soc/Makefile                                   |  1 +
 drivers/soc/sifive/Kconfig                             | 10 ++++++++++
 drivers/soc/sifive/Makefile                            |  3 +++
 .../riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c  |  0
 8 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/sifive/Kconfig
 create mode 100644 drivers/soc/sifive/Makefile
 rename {arch/riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..f5a8accb0df3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5972,6 +5972,7 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
+F:	drivers/soc/sifive/
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 9d9a17335686..b225134c29e0 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -11,7 +11,6 @@ obj-y += extable.o
 obj-y += ioremap.o
 obj-y += cacheflush.o
 obj-y += context.o
-obj-y += sifive_l2_cache.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 417dad635526..5c8272329a65 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SIFIVE
 	bool "Sifive platform EDAC driver"
-	depends on EDAC=y && RISCV
+	depends on EDAC=y && SIFIVE_L2
 	help
 	  Support for error detection and correction on the SiFive SoCs.
 
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 833e04a7835c..1778f8c62861 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -14,6 +14,7 @@ source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
+source "drivers/soc/sifive/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2ec355003524..8b49d782a1ab 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -20,6 +20,7 @@ obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
+obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
new file mode 100644
index 000000000000..58cf8c40d08d
--- /dev/null
+++ b/drivers/soc/sifive/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if SOC_SIFIVE
+
+config SIFIVE_L2
+	bool "Sifive L2 Cache controller"
+	help
+	  Support for the L2 cache controller on SiFive platforms.
+
+endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
new file mode 100644
index 000000000000..b5caff77938f
--- /dev/null
+++ b/drivers/soc/sifive/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
diff --git a/arch/riscv/mm/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
similarity index 100%
rename from arch/riscv/mm/sifive_l2_cache.c
rename to drivers/soc/sifive/sifive_l2_cache.c
-- 
2.20.1

