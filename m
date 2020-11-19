Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894672B9CE7
	for <lists+linux-edac@lfdr.de>; Thu, 19 Nov 2020 22:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgKSVW2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 16:22:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:60831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSVW2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Nov 2020 16:22:28 -0500
IronPort-SDR: HeNFLdmUAg4L7/KOPzx+Ex4sm3ZtkPxm6P34FzuAHjPoA7Kx85lyEA3Qc854KLiIE56w3H9L4q
 BGGCCwlTHFoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171535894"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171535894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:27 -0800
IronPort-SDR: j5ljYHS6eV7iiI8VSupJMcUsw+UGkvslbtPARoltb9qpsB7jeTRAWkZTxSqBHizAqfeCF11U8l
 6EzhRuRlpiWg==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="476968894"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:27 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 2/3] EDAC: Add DDR5 new memory type
Date:   Thu, 19 Nov 2020 13:22:18 -0800
Message-Id: <20201119212219.1335-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201119212219.1335-1-tony.luck@intel.com>
References: <20201119212219.1335-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Add a new entry to 'enum mem_type' and a new string to
'edac_mem_types[]' for DDR5 new memory type.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/edac_mc.c | 1 +
 include/linux/edac.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index eef8724faae0..f6d462d0be2d 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -163,6 +163,7 @@ const char * const edac_mem_types[] = {
 	[MEM_RDDR4]	= "Registered-DDR4",
 	[MEM_LPDDR4]	= "Low-Power-DDR4-RAM",
 	[MEM_LRDDR4]	= "Load-Reduced-DDR4-RAM",
+	[MEM_DDR5]	= "Unbuffered-DDR5",
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 	[MEM_WIO2]	= "Wide-IO-2",
 };
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 8f63245f7f7c..e64b73b556eb 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -181,6 +181,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  *			This is a variant of the DDR4 memories.
  * @MEM_LRDDR4:		Load-Reduced DDR4 memory.
  * @MEM_LPDDR4:		Low-Power DDR4 memory.
+ * @MEM_DDR5:		Unbuffered DDR5 RAM
  * @MEM_NVDIMM:		Non-volatile RAM
  * @MEM_WIO2:		Wide I/O 2.
  */
@@ -208,6 +209,7 @@ enum mem_type {
 	MEM_RDDR4,
 	MEM_LRDDR4,
 	MEM_LPDDR4,
+	MEM_DDR5,
 	MEM_NVDIMM,
 	MEM_WIO2,
 };
@@ -234,6 +236,7 @@ enum mem_type {
 #define MEM_FLAG_RDDR4          BIT(MEM_RDDR4)
 #define MEM_FLAG_LRDDR4         BIT(MEM_LRDDR4)
 #define MEM_FLAG_LPDDR4         BIT(MEM_LPDDR4)
+#define MEM_FLAG_DDR5           BIT(MEM_DDR5)
 #define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 
-- 
2.21.1

