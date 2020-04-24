Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EF61B7E70
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgDXS5l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 14:57:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:21121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgDXS5l (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Apr 2020 14:57:41 -0400
IronPort-SDR: PHrvr/XHV6zB7YsUtS861I2d7K/MMY/c6t33wWRemRgJxQJcsgXzMAQ555NH+YyK0fjhGe6TSq
 cy8Cm/h8g6mg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 11:57:40 -0700
IronPort-SDR: LnB8aXbPjv5c2Pwyyjv7onfs2A4ml/9YZnFObOEQZk9zTTiQBWUNDHApvnEKTaT2Md8kR1Zdk9
 AEJZ6JBRCsew==
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="430893784"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 11:57:39 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jerry Chen <jerry.t.chen@intel.com>,
        Jin Wen <wen.jin@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 2/2] EDAC, i10nm: Fix i10nm_edac loading failure on some servers
Date:   Fri, 24 Apr 2020 11:57:38 -0700
Message-Id: <20200424185738.7985-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424185738.7985-1-tony.luck@intel.com>
References: <20200424185738.7985-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

It failed to load the i10nm_edac driver on Ice Lake and
Tremont/Jacobsville servers if their CPU stepping >= 4 and failed
on Ice Lake-D servers from stepping 0. The root cause was that for
Ice Lake and Tremont/Jacobsville servers with CPU stepping >=4, the
offset for bus number configuration register was updated from 0xcc
to 0xd0. For Ice Lake-D servers, all the steppings use the updated
0xd0 offset.

Fix the issue by using the appropriate offset for bus number
configuration register according to the CPU model number and stepping.

Reported-by: Jerry Chen <jerry.t.chen@intel.com>
Reported-and-tested-by: Jin Wen <wen.jin@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index ba4578c6ef2b..ebb45738c11b 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -122,16 +122,24 @@ static int i10nm_get_all_munits(void)
 	return 0;
 }
 
-static struct res_config i10nm_cfg = {
+/* ATOM_TREMONT_D, ICELAKE_X */
+static struct res_config i10nm_cfg0 = {
 	.type			= I10NM,
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xcc,
 };
 
+/* ICELAKE_D */
+static struct res_config i10nm_cfg1 = {
+	.type			= I10NM,
+	.decs_did		= 0x3452,
+	.busno_cfg_offset	= 0xd0,
+};
+
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg1),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
@@ -257,6 +265,10 @@ static int __init i10nm_init(void)
 		return -ENODEV;
 	cfg = (struct res_config *)id->driver_data;
 
+	/* Newer steppings have different offset for ATOM_TREMONT_D/ICELAKE_X */
+	if (boot_cpu_data.x86_stepping >= 4)
+		cfg->busno_cfg_offset = 0xd0;
+
 	rc = skx_get_hi_lo(0x09a2, off, &tolm, &tohm);
 	if (rc)
 		return rc;
-- 
2.21.1

