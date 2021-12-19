Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED3A47A2B1
	for <lists+linux-edac@lfdr.de>; Sun, 19 Dec 2021 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhLSWbm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Dec 2021 17:31:42 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59351 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhLSWbl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Dec 2021 17:31:41 -0500
Received: (Authenticated sender: m@zorinaq.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B28E720005;
        Sun, 19 Dec 2021 22:31:38 +0000 (UTC)
From:   Marc Bevand <m@zorinaq.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, Marc Bevand <m@zorinaq.com>
Subject: [PATCH] EDAC/amd64: Add PCI device IDs for family 19h model 50h
Date:   Sun, 19 Dec 2021 14:31:27 -0800
Message-Id: <20211219223127.71554-1-m@zorinaq.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new family 19h model 50h PCI IDs (device 18h functions 0 and 6)
to support Ryzen 5000 APUs ("Cezanne").

Signed-off-by: Marc Bevand <m@zorinaq.com>
---
 drivers/edac/amd64_edac.c | 16 ++++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce75013674..45c81c0a232f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2650,6 +2650,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F19_M50H_CPUS] = {
+		.ctl_name = "F19h_M50h",
+		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
+		.max_mcs = 2,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3693,6 +3703,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type->ctl_name = "F19h_M20h";
 			break;
 		}
+		if (pvt->model == 0x50) {
+			fam_type = &family_types[F19_M50H_CPUS];
+			pvt->ops = &family_types[F19_M50H_CPUS].ops;
+			fam_type->ctl_name = "F19h_M50h";
+			break;
+		}
 		fam_type	= &family_types[F19_CPUS];
 		pvt->ops	= &family_types[F19_CPUS].ops;
 		family_types[F19_CPUS].ctl_name = "F19h";
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..796e39e1890c 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -126,6 +126,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
 #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F0 0x166a
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F6 0x1670
 
 /*
  * Function 1 - Address Map
@@ -298,6 +300,7 @@ enum amd_families {
 	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
+	F19_M50H_CPUS,
 	NUM_FAMILIES,
 };
 
-- 
2.30.2

