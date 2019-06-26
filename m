Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2156F58
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFZRJf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 13:09:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:6876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZRJf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jun 2019 13:09:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:09:34 -0700
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="155933380"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:09:33 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 2/2] EDAC, skx, i10nm: Fix source ID register offset
Date:   Wed, 26 Jun 2019 10:09:32 -0700
Message-Id: <20190626170932.6105-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626170932.6105-1-tony.luck@intel.com>
References: <20190626170932.6105-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The source ID register offset for Skylake server is 0xf0, while for
Icelake server is 0xf8. Pass the correct offset to get the source ID.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 2 +-
 drivers/edac/skx_base.c   | 2 +-
 drivers/edac/skx_common.c | 4 ++--
 drivers/edac/skx_common.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 72cc20a90ac1..83392f2841de 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -267,7 +267,7 @@ static int __init i10nm_init(void)
 		goto fail;
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
-		rc = skx_get_src_id(d, &src_id);
+		rc = skx_get_src_id(d, 0xf8, &src_id);
 		if (rc < 0)
 			goto fail;
 
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index a5c8fa3a249a..0fcf3785e8f3 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -639,7 +639,7 @@ static int __init skx_init(void)
 	}
 
 	list_for_each_entry(d, skx_edac_list, list) {
-		rc = skx_get_src_id(d, &src_id);
+		rc = skx_get_src_id(d, 0xf0, &src_id);
 		if (rc < 0)
 			goto fail;
 		rc = skx_get_node_id(d, &node_id);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index b0dddcfa9baa..d8ff63d91b86 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -136,11 +136,11 @@ void skx_set_decode(skx_decode_f decode)
 	skx_decode = decode;
 }
 
-int skx_get_src_id(struct skx_dev *d, u8 *id)
+int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 {
 	u32 reg;
 
-	if (pci_read_config_dword(d->util_all, 0xf0, &reg)) {
+	if (pci_read_config_dword(d->util_all, off, &reg)) {
 		skx_printk(KERN_ERR, "Failed to read src id\n");
 		return -ENODEV;
 	}
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index d18fa98669af..08cc971a50ea 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -118,7 +118,7 @@ int __init skx_adxl_get(void);
 void __exit skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode);
 
-int skx_get_src_id(struct skx_dev *d, u8 *id);
+int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
 
 int skx_get_all_bus_mappings(unsigned int did, int off, enum type,
-- 
2.20.1

