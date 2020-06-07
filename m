Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78301F09D7
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jun 2020 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgFGEhj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jun 2020 00:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgFGEhi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jun 2020 00:37:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1DC08C5C2;
        Sat,  6 Jun 2020 21:37:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so5317194plv.9;
        Sat, 06 Jun 2020 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnxUFQchShJ0548V2HenAcxZUiPCHDQbaDLgGdFOauc=;
        b=tqQnt3c+mrRJiD5dNdJ8k5HhuakPsvszu/aR8iPa6tuC7+2GdtCvdZPUXPIvoiRpQC
         GDlWGUrIX9AUu2z+ZfqB/a+YCfDp2ubpKOU7NnUcj3EKHWBWqgvBE13IYmmRUqsppSpT
         5gqwjtTtmAOWbCfoQHBXiq9FZDmQkYXrPRB92mAJ3GLX4OmZzgJFHHIWtw8Ij/U/8OP0
         Krr3rYJaw3sMRVs0JaPElFVJGCaUWFMobjs7R3g3h/6T94t8D8awoI+qeYbB4gKjlhUB
         b76LzLD35bTxHqi36R1bYaVaTin7iTeoODPAHKxOEG+YByqRs1fw8ead61AKqlN2PM9J
         r7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnxUFQchShJ0548V2HenAcxZUiPCHDQbaDLgGdFOauc=;
        b=jWLaPJPzQ8ictSxG04eOa0kXiPv5UDg3CEXsHhimA69Nf9ZEaBAQXK0lnZcCD90o4T
         WPeSf+cVs9SWD8588barc5DBZb8116mpG8P+zZ2Z4Hnj8BTf2preJxOXGV+fHMQwDh81
         7of7AdvxtytZzcGnqaW+lhW5oNzzJTehJLF57QdWx7QDUpOCRIMv2J/GYqtWmZckSwcm
         iz+H8y54ygLy7QnYiqR5q7dKOEeBxe2H/UEx7V/2sJe5q+pwHfvYQacGx208udWezBRi
         /3kYTF6PiyY/pwfVgbt16dBOSywBZwRjV75qzKcCXZosV0sE39aRBJIhLcl5LV+erU4q
         5KKg==
X-Gm-Message-State: AOAM53356ZGzSlB1fh5K7EMngWxRDYZM+FXY4wZNEzaHq0To4BPmF5eb
        ruCP0KFAGe0Fxm630JYY2jEVgoozNA==
X-Google-Smtp-Source: ABdhPJzelHQ9xvlttenM8dL2StIUOBMbHNW4u0lTc+1HDCsJqhQFdX8u9KwDZz1QMyNQmG9+U+1ErQ==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr16290467pll.43.1591504657946;
        Sat, 06 Jun 2020 21:37:37 -0700 (PDT)
Received: from localhost (98.86.92.34.bc.googleusercontent.com. [34.92.86.98])
        by smtp.gmail.com with ESMTPSA id w73sm3602651pfd.113.2020.06.06.21.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 21:37:37 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
        x86@kernel.org, Jacky Hu <hengqing.hu@gmail.com>
Subject: [PATCH 1/2] x86/amd_nb: Add Family 17h, Model 60h PCI IDs
Date:   Sun,  7 Jun 2020 12:37:08 +0800
Message-Id: <20200607043709.48178-2-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607043709.48178-1-hengqing.hu@gmail.com>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new Family 17h, Model 60h PCI IDs for AMD Zen2 APU systems.

Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 drivers/hwmon/k10temp.c  | 2 ++
 include/linux/pci_ids.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b6b3297851f3..b57e7bd68885 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -18,9 +18,11 @@
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
+#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 
@@ -33,6 +35,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
 	{}
 };
 
@@ -51,6 +54,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{}
@@ -65,6 +69,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 9915578533bb..287e9cf2aab9 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -583,6 +583,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(pdev, data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
+		case 0x60:	/* Zen2 APU */
 		case 0x71:	/* Zen2 */
 			data->show_current = !is_threadripper() && !is_epyc();
 			data->cfactor[0] = CFACTOR_ICORE;
@@ -632,6 +633,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9a57e6717e5c..0ad57693f392 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -550,6 +550,7 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
-- 
2.27.0

