Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EED1F09D9
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jun 2020 06:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFGEhp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jun 2020 00:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgFGEhp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jun 2020 00:37:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F914C08C5C2;
        Sat,  6 Jun 2020 21:37:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so5335304plk.1;
        Sat, 06 Jun 2020 21:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+RfD0GNAG9wtYBIqQI83YWVj2YPAQjhlZZhEwrpiUR0=;
        b=nLMe/PmUWDpie/4JGJYHvkGhZglWExGklzZHubXRcJ6RxiFhblxTs8k3fF10Uid1Ta
         bpc7bIEWxPpsiFBPi3SVzGXJ/tjHI+KiYncdvsCaC/HImbCqo82N0Qc3snQPMKZwzLDp
         zHSUlpFGgwzr6OuCuvmqJEeC3Ycv3PX31TewQteofq1cKucP6N9zeog0BqHP/sUeIfxK
         P0E6yzvLL0NLQH/9t3Eq9gPuIpT/Ridn796+GV/qg/2qiIRDWv+1ccLCp0ld51mjffX3
         5uGUZpcfOMEg64PuGSiUMn1gIO7Z0CWVFGUGn5CMJncw7VCGMfm2DnZvmHPiMMzFYBsL
         drGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+RfD0GNAG9wtYBIqQI83YWVj2YPAQjhlZZhEwrpiUR0=;
        b=bwKEc2f8lSqySOlbS0D76NoUL7C61ABCF15VTXYyRyOFx6BoC+3yGybJuENGhdYA1p
         8hRraikzhyDIjHFRqphhdKdhO0aFSCiiNyOfs5zxrd+CiKslSAmOuxgkTYmp4/QZ73Nt
         b+/K8xvg23WsBh/nBArdpYMBkArc1tOnI4DmgFSBJRQvOScEkm1ZO+K+meXTKyweIsFp
         np/x+I+8HnI9FsNSE/nPxw1WjNkvvd/U4UeDW8zVStZODEMJ6ng6R2OnlPSrxKenDMqb
         NMj2uJqFihb+IeVr1jZKOqqj/bVfIuu89lJW1wfKj6w1xg1Ru/KzAGFeJB4LOk8akYEi
         tjBQ==
X-Gm-Message-State: AOAM53369ahSEnbzsD1RyYKLHLlItW0KGhZFo/G3KCZGhBvKGnH3H3qI
        OxIAQ4ixvpOpiiZvpouBimIU+yGMXg==
X-Google-Smtp-Source: ABdhPJyoao4/TQK4XdT5KWfP0hv+v1BBqmn3ekWDOpZYWfIvpZDArQFDyOAGJTYOrU5Fr13uLyMo2g==
X-Received: by 2002:a17:90b:517:: with SMTP id r23mr11643417pjz.191.1591504663554;
        Sat, 06 Jun 2020 21:37:43 -0700 (PDT)
Received: from localhost (98.86.92.34.bc.googleusercontent.com. [34.92.86.98])
        by smtp.gmail.com with ESMTPSA id t201sm3633265pfc.104.2020.06.06.21.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 21:37:43 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
        x86@kernel.org, Jacky Hu <hengqing.hu@gmail.com>
Subject: [PATCH 2/2] EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
Date:   Sun,  7 Jun 2020 12:37:09 +0800
Message-Id: <20200607043709.48178-3-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607043709.48178-1-hengqing.hu@gmail.com>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add family ops to support AMD Family 17h, Models 60h-6Fh systems.

Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
---
 drivers/edac/amd64_edac.c | 14 ++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9cf7cc1f3f72..0e74027d3660 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2319,6 +2319,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F17_M60H_CPUS] = {
+		.ctl_name = "F17h_M60h",
+		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
+		.max_mcs = 2,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
@@ -3357,6 +3367,10 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type = &family_types[F17_M30H_CPUS];
 			pvt->ops = &family_types[F17_M30H_CPUS].ops;
 			break;
+		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
+			fam_type = &family_types[F17_M60H_CPUS];
+			pvt->ops = &family_types[F17_M60H_CPUS].ops;
+			break;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index abbf3c274d74..52b5d03eeba0 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -120,6 +120,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F0 0x1448
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F6 0x144e
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
@@ -293,6 +295,7 @@ enum amd_families {
 	F17_CPUS,
 	F17_M10H_CPUS,
 	F17_M30H_CPUS,
+	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
 	NUM_FAMILIES,
-- 
2.27.0

