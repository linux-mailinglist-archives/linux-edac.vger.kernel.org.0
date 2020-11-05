Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5682A7839
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 08:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKEHsT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 02:48:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:37360 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKEHsT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Nov 2020 02:48:19 -0500
IronPort-SDR: fQvwWgTeYRDEuapg6Z50Kq7BHmTTJcT/oa3/yWKbw6zeCGLrYHyc47pUGLT7ToDC0rQ5TUHFwZ
 8ONeHE6QT6JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="165834295"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="165834295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:48:19 -0800
IronPort-SDR: jZnzN/dwitDJFl3EJ3eead29SmmwXHoG0hBMwZdbrwhFsuDs38X6YdTHmHXTl+psNf5Q7/jcOr
 HNDVXQKX0uxQ==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="306443550"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.133])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:48:17 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     bp@alien8.de
Cc:     tony.luck@intel.com, aris@redhat.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v1 1/3] EDAC: Add three new memory types
Date:   Thu,  5 Nov 2020 15:48:51 +0800
Message-Id: <20201105074851.3807-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are {Low-Power DDR3/4, WIO2} types of memory.
Add new entries to 'enum mem_type' and new strings to
'edac_mem_types[]' for the new types.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/edac_mc.c | 3 +++
 include/linux/edac.h   | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 01ff71f7b645..eef8724faae0 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -158,10 +158,13 @@ const char * const edac_mem_types[] = {
 	[MEM_DDR3]	= "Unbuffered-DDR3",
 	[MEM_RDDR3]	= "Registered-DDR3",
 	[MEM_LRDDR3]	= "Load-Reduced-DDR3-RAM",
+	[MEM_LPDDR3]	= "Low-Power-DDR3-RAM",
 	[MEM_DDR4]	= "Unbuffered-DDR4",
 	[MEM_RDDR4]	= "Registered-DDR4",
+	[MEM_LPDDR4]	= "Low-Power-DDR4-RAM",
 	[MEM_LRDDR4]	= "Load-Reduced-DDR4-RAM",
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
+	[MEM_WIO2]	= "Wide-IO-2",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 15e8f3d8a895..8f63245f7f7c 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -175,11 +175,14 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_RDDR3:		Registered DDR3 RAM
  *			This is a variant of the DDR3 memories.
  * @MEM_LRDDR3:		Load-Reduced DDR3 memory.
+ * @MEM_LPDDR3:		Low-Power DDR3 memory.
  * @MEM_DDR4:		Unbuffered DDR4 RAM
  * @MEM_RDDR4:		Registered DDR4 RAM
  *			This is a variant of the DDR4 memories.
  * @MEM_LRDDR4:		Load-Reduced DDR4 memory.
+ * @MEM_LPDDR4:		Low-Power DDR4 memory.
  * @MEM_NVDIMM:		Non-volatile RAM
+ * @MEM_WIO2:		Wide I/O 2.
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -200,10 +203,13 @@ enum mem_type {
 	MEM_DDR3,
 	MEM_RDDR3,
 	MEM_LRDDR3,
+	MEM_LPDDR3,
 	MEM_DDR4,
 	MEM_RDDR4,
 	MEM_LRDDR4,
+	MEM_LPDDR4,
 	MEM_NVDIMM,
+	MEM_WIO2,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -223,10 +229,13 @@ enum mem_type {
 #define MEM_FLAG_XDR            BIT(MEM_XDR)
 #define MEM_FLAG_DDR3           BIT(MEM_DDR3)
 #define MEM_FLAG_RDDR3          BIT(MEM_RDDR3)
+#define MEM_FLAG_LPDDR3         BIT(MEM_LPDDR3)
 #define MEM_FLAG_DDR4           BIT(MEM_DDR4)
 #define MEM_FLAG_RDDR4          BIT(MEM_RDDR4)
 #define MEM_FLAG_LRDDR4         BIT(MEM_LRDDR4)
+#define MEM_FLAG_LPDDR4         BIT(MEM_LPDDR4)
 #define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
+#define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 
 /**
  * enum edac-type - Error Detection and Correction capabilities and mode
-- 
2.17.1

