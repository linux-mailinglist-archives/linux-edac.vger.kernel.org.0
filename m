Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB59158C
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2019 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHRIbw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 18 Aug 2019 04:31:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRIbw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 18 Aug 2019 04:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nxKuYGPQhgJkfpybKN0jQGWSeUjumJ0GDmnTQwBVeko=; b=sCT1suy6/kg6xY3V8HuauLjve
        mLbLmk+RMeyvvnCeFsBkGv+h12/aT/2DV3dgzMC6nlwlt+2s1TcCWv8kUnl3w7I3ZnNmVDbr8se7d
        lyzRvUDmeL+jwAZOoXI8zdF4Dmgg1OUmWXjwkCI4GL8YjzhDl8rhQTNdua6EmiPvls2gl+p8dr0oo
        iJh9Y9HZT/Qdg07h3BGpbw2DxbyAgSYRvtPnnEZTBMfF6ofdAjl3KWUSVJSr9b//NtZkrh9zRClUx
        30Ws0BpCMWzJ8/rRiLipgg0a8Su3lm7SB5iYjz51jCggq/2Zzmw4BxhktwdzFFyEWwhtCG4LXxYY7
        PRsKOLAlw==;
Received: from 213-225-6-198.nat.highway.a1.net ([213.225.6.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hzGbO-0002CY-Nn; Sun, 18 Aug 2019 08:31:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     paul.walmsley@sifive.com, palmer@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Date:   Sun, 18 Aug 2019 10:29:35 +0200
Message-Id: <20190818082935.14869-1-hch@lst.de>
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
 arch/riscv/mm/Makefile                                 |  1 -
 drivers/edac/Kconfig                                   |  2 +-
 drivers/soc/Kconfig                                    |  1 +
 drivers/soc/Makefile                                   |  1 +
 drivers/soc/sifive/Kconfig                             | 10 ++++++++++
 drivers/soc/sifive/Makefile                            |  4 ++++
 .../riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c  |  0
 7 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/sifive/Kconfig
 create mode 100644 drivers/soc/sifive/Makefile
 rename {arch/riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c (100%)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 74055e1d6f21..d2101d0741d4 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -11,6 +11,5 @@ obj-y += extable.o
 obj-y += ioremap.o
 obj-y += cacheflush.o
 obj-y += context.o
-obj-y += sifive_l2_cache.o
 
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 200c04ce5b0e..9241b3e7a050 100644
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
index 000000000000..9ffb2e8a48cd
--- /dev/null
+++ b/drivers/soc/sifive/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if SOC_SIFIVE
+
+config SIFIVE_L2
+	tristate "Sifive L2 Cache controller"
+	help
+	  Support for the L2 cache controller on SiFive platforms.
+
+endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
new file mode 100644
index 000000000000..9b4a85558347
--- /dev/null
+++ b/drivers/soc/sifive/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
+
diff --git a/arch/riscv/mm/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
similarity index 100%
rename from arch/riscv/mm/sifive_l2_cache.c
rename to drivers/soc/sifive/sifive_l2_cache.c
-- 
2.20.1

