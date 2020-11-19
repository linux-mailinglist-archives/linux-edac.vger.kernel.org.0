Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100A62B9CE6
	for <lists+linux-edac@lfdr.de>; Thu, 19 Nov 2020 22:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKSVW2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 16:22:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:60831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgKSVW1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Nov 2020 16:22:27 -0500
IronPort-SDR: 2HJDPgspVdfmmubMRt81oBvjTVfu+PQZ+BWI2259LnGrAN3QuCirRM81fsFeIymJd19X5Ae8LW
 IgrxgyOgdAyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171535892"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171535892"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:27 -0800
IronPort-SDR: rAki79l/8NpVnfmMWDcLnnwvuUOI6W8lmTFcEeub38ufh0/M8QImr7MRrJLaktSYhiX47HRJNJ
 rwm+mws4l1Qg==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="476968890"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:26 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/3] EDAC/i10nm: Use readl() to access MMIO registers
Date:   Thu, 19 Nov 2020 13:22:17 -0800
Message-Id: <20201119212219.1335-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201119212219.1335-1-tony.luck@intel.com>
References: <20201119212219.1335-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Instead of raw access, use readl() to access MMIO registers of
memory controller to avoid possible compiler re-ordering.

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index c8d11da85bec..7b52691c45d2 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/io.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mce.h>
@@ -19,14 +20,16 @@
 #define i10nm_printk(level, fmt, arg...)	\
 	edac_printk(level, "i10nm", fmt, ##arg)
 
-#define I10NM_GET_SCK_BAR(d, reg)		\
+#define I10NM_GET_SCK_BAR(d, reg)	\
 	pci_read_config_dword((d)->uracu, 0xd0, &(reg))
 #define I10NM_GET_IMC_BAR(d, i, reg)	\
 	pci_read_config_dword((d)->uracu, 0xd8 + (i) * 4, &(reg))
 #define I10NM_GET_DIMMMTR(m, i, j)	\
-	(*(u32 *)((m)->mbase + 0x2080c + (i) * 0x4000 + (j) * 4))
+	readl((m)->mbase + 0x2080c + (i) * 0x4000 + (j) * 4)
 #define I10NM_GET_MCDDRTCFG(m, i, j)	\
-	(*(u32 *)((m)->mbase + 0x20970 + (i) * 0x4000 + (j) * 4))
+	readl((m)->mbase + 0x20970 + (i) * 0x4000 + (j) * 4)
+#define I10NM_GET_MCMTR(m, i)		\
+	readl((m)->mbase + 0x20ef8 + (i) * 0x4000)
 
 #define I10NM_GET_SCK_MMIO_BASE(reg)	(GET_BITFIELD(reg, 0, 28) << 23)
 #define I10NM_GET_IMC_MMIO_OFFSET(reg)	(GET_BITFIELD(reg, 0, 10) << 12)
@@ -148,7 +151,7 @@ static bool i10nm_check_ecc(struct skx_imc *imc, int chan)
 {
 	u32 mcmtr;
 
-	mcmtr = *(u32 *)(imc->mbase + 0x20ef8 + chan * 0x4000);
+	mcmtr = I10NM_GET_MCMTR(imc, chan);
 	edac_dbg(1, "ch%d mcmtr reg %x\n", chan, mcmtr);
 
 	return !!GET_BITFIELD(mcmtr, 2, 2);
-- 
2.21.1

