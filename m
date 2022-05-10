Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07869521E8E
	for <lists+linux-edac@lfdr.de>; Tue, 10 May 2022 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbiEJPak (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 May 2022 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbiEJP37 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 May 2022 11:29:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC8192A5;
        Tue, 10 May 2022 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652196052; x=1683732052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=An2DWh+lnicdQp5Dv4UeRITSb7pkwS9koGVbJHHuvPo=;
  b=N0hpA3cQWSVBPVamn3rJRSt5MqsZYoTvjsvt+Y5fKbqBy1gIu2kL2d/b
   Ewhm7MEzCdz41njYLkv/Fuou8ZYAQc5it9C4bn1SWyY69NJ84CNsw5KdV
   PMoqFKwUMyyXU5azsbB2kfQ8dsJJdZhihbwxOHdZOPLmSyZ4M9kgtYoO+
   /c0zsofXjWFMzINEJoo9HQ2vfI62O0sXfd3fFy+M+QIX1mwFIzGa+Z7FB
   6iIYboSKoLOoKWUn6J+so/qCB5T6O6o+fgibF4R+zb7WgENzGl62di2FO
   0n94uPfZpaj223nEwxIQJm0iqN7RtjHBZ0HRSfSCWchsg5+9XGOTgJDbF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="256943417"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="256943417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 08:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="593559675"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 May 2022 08:17:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B77435D0; Tue, 10 May 2022 18:15:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Yong <jonathan.yong@intel.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v5 6/8] i2c: i801: convert to use common P2SB accessor
Date:   Tue, 10 May 2022 18:14:49 +0300
Message-Id: <20220510151451.85561-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510151451.85561-1-andriy.shevchenko@linux.intel.com>
References: <20220510151451.85561-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since we have a common P2SB accessor in tree we may use it instead of
open coded variants.

Replace custom code by p2sb_bar() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Henning Schild <henning.schild@siemens.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Acked-by: Wolfram Sang <wsa@kernel.org>
---
 drivers/i2c/busses/Kconfig        |  1 +
 drivers/i2c/busses/i2c-i801.c     | 39 +++++++------------------------
 drivers/platform/x86/intel/p2sb.c |  6 +++++
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a1bae59208e3..4d0a195ca3ef 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -108,6 +108,7 @@ config I2C_HIX5HD2
 config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
 	depends on PCI
+	select P2SB if X86
 	select CHECK_SIGNATURE if X86 && DMI
 	select I2C_SMBUS
 	help
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ff706349bdfb..f7a0bb372e8e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -111,6 +111,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/itco_wdt.h>
+#include <linux/platform_data/x86/p2sb.h>
 #include <linux/pm_runtime.h>
 #include <linux/mutex.h>
 
@@ -140,7 +141,6 @@
 #define TCOBASE		0x050
 #define TCOCTL		0x054
 
-#define SBREG_BAR		0x10
 #define SBREG_SMBCTRL		0xc6000c
 #define SBREG_SMBCTRL_DNV	0xcf000c
 
@@ -1482,45 +1482,24 @@ i801_add_tco_spt(struct i801_priv *priv, struct pci_dev *pci_dev,
 		.version = 4,
 	};
 	struct resource *res;
-	unsigned int devfn;
-	u64 base64_addr;
-	u32 base_addr;
-	u8 hidden;
+	int ret;
 
 	/*
 	 * We must access the NO_REBOOT bit over the Primary to Sideband
-	 * bridge (P2SB). The BIOS prevents the P2SB device from being
-	 * enumerated by the PCI subsystem, so we need to unhide/hide it
-	 * to lookup the P2SB BAR.
+	 * (P2SB) bridge.
 	 */
-	pci_lock_rescan_remove();
-
-	devfn = PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 1);
-
-	/* Unhide the P2SB device, if it is hidden */
-	pci_bus_read_config_byte(pci_dev->bus, devfn, 0xe1, &hidden);
-	if (hidden)
-		pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, 0x0);
-
-	pci_bus_read_config_dword(pci_dev->bus, devfn, SBREG_BAR, &base_addr);
-	base64_addr = base_addr & 0xfffffff0;
-
-	pci_bus_read_config_dword(pci_dev->bus, devfn, SBREG_BAR + 0x4, &base_addr);
-	base64_addr |= (u64)base_addr << 32;
-
-	/* Hide the P2SB device, if it was hidden before */
-	if (hidden)
-		pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, hidden);
-	pci_unlock_rescan_remove();
 
 	res = &tco_res[1];
+	ret = p2sb_bar(pci_dev->bus, 0, res);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (pci_dev->device == PCI_DEVICE_ID_INTEL_DNV_SMBUS)
-		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL_DNV;
+		res->start += SBREG_SMBCTRL_DNV;
 	else
-		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
+		res->start += SBREG_SMBCTRL;
 
 	res->end = res->start + 3;
-	res->flags = IORESOURCE_MEM;
 
 	return platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt", -1,
 					tco_res, 2, &pldata, sizeof(pldata));
diff --git a/drivers/platform/x86/intel/p2sb.c b/drivers/platform/x86/intel/p2sb.c
index b598ef14dbc6..fb2e141f3eb8 100644
--- a/drivers/platform/x86/intel/p2sb.c
+++ b/drivers/platform/x86/intel/p2sb.c
@@ -21,6 +21,12 @@
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	PCI_DEVFN(31, 1)),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	PCI_DEVFN(31, 1)),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		PCI_DEVFN(31, 1)),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		PCI_DEVFN(31, 1)),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		PCI_DEVFN(31, 1)),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		PCI_DEVFN(31, 1)),
 	{}
 };
 
-- 
2.35.1

