Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CA47C9BC
	for <lists+linux-edac@lfdr.de>; Wed, 22 Dec 2021 00:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhLUXbk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Dec 2021 18:31:40 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49005 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhLUXbk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Dec 2021 18:31:40 -0500
Received: (Authenticated sender: m@zorinaq.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 651881C0005;
        Tue, 21 Dec 2021 23:31:36 +0000 (UTC)
From:   Marc Bevand <m@zorinaq.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, Marc Bevand <m@zorinaq.com>
Subject: [PATCH v2] EDAC/amd64: Add PCI device IDs for family 19h model 50h
Date:   Tue, 21 Dec 2021 15:31:12 -0800
Message-Id: <20211221233112.556927-1-m@zorinaq.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YcIk4XJaBZs/aihF@yaz-ubuntu>
References: <YcIk4XJaBZs/aihF@yaz-ubuntu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new family 19h model 50h PCI IDs (device 18h functions 0 and 6)
to support Ryzen 5000 APUs ("Cezanne").

Signed-off-by: Marc Bevand <m@zorinaq.com>
---
V1 -> V2: rebase on latest ras.git, apply to models 0x50-0x5f

Hi Yazen, I addressed your comments in v2 of this patch, included below.
Cheers, 
Marc.

 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c6c58f01067f..f8ef2edf8abf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2660,6 +2660,16 @@ static struct amd64_family_type family_types[] = {
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
@@ -3706,6 +3716,11 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			fam_type->ctl_name = "F19h_M20h";
 			break;
+		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
+			fam_type = &family_types[F19_M50H_CPUS];
+			pvt->ops = &family_types[F19_M50H_CPUS].ops;
+			fam_type->ctl_name = "F19h_M50h";
+			break;
 		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
 			fam_type = &family_types[F19_M10H_CPUS];
 			pvt->ops = &family_types[F19_M10H_CPUS].ops;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 650cab401e21..352bda9803f6 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -128,6 +128,8 @@
 #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F0 0x14ad
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F6 0x14b3
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F0 0x166a
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F6 0x1670
 
 /*
  * Function 1 - Address Map
@@ -301,6 +303,7 @@ enum amd_families {
 	F17_M70H_CPUS,
 	F19_CPUS,
 	F19_M10H_CPUS,
+	F19_M50H_CPUS,
 	NUM_FAMILIES,
 };
 
-- 
2.30.2

