Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB12217824
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jul 2020 21:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGGTn0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jul 2020 15:43:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:8254 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGGTn0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Jul 2020 15:43:26 -0400
IronPort-SDR: MdIUgG+CuSp2Gjh0mwmQINTTzJBKGfKiOGj7hKyYeR3YmGkre++PaCh3zU9U73ExIta36dS8rU
 YbKuUOtL3d4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="165756287"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="165756287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:43:25 -0700
IronPort-SDR: 8UpS+ICVsICC80AB1clmi6e87WeOdKs4B0I79MKHkMwLKF52436Ao452/SXQ5wmQbVEYuk1DQR
 mrxdnzrJDsXA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="427585167"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:43:25 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC, i7core, sb, pnd2, skx: Fix error event severity
Date:   Tue,  7 Jul 2020 12:43:24 -0700
Message-Id: <20200707194324.14884-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

IA32_MCG_STATUS.RIPV indicates whether the return RIP value pushed onto
the stack as part of machine check delivery is valid or not.

Various drivers copied a code fragment that uses the RIPV bit to
determine the severity of the error as either HW_EVENT_ERR_UNCORRECTED
or HW_EVENT_ERR_FATAL, but this check is reversed (marking errors where
RIPV is set as "FATAL").

Reverse the tests so that the error is marked fatal when RIPV is not set.

Reported-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i7core_edac.c | 4 ++--
 drivers/edac/pnd2_edac.c   | 2 +-
 drivers/edac/sb_edac.c     | 4 ++--
 drivers/edac/skx_common.c  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 5860ca41185c..2acd9f9284a2 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1710,9 +1710,9 @@ static void i7core_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv)
-			tp_event = HW_EVENT_ERR_FATAL;
-		else
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
+		else
+			tp_event = HW_EVENT_ERR_FATAL;
 	} else {
 		tp_event = HW_EVENT_ERR_CORRECTED;
 	}
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index fd363746f5b0..b8fc4b84fd86 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1155,7 +1155,7 @@ static void pnd2_mce_output_error(struct mem_ctl_info *mci, const struct mce *m,
 	u32 optypenum = GET_BITFIELD(m->status, 4, 6);
 	int rc;
 
-	tp_event = uc_err ? (ripv ? HW_EVENT_ERR_FATAL : HW_EVENT_ERR_UNCORRECTED) :
+	tp_event = uc_err ? (ripv ? HW_EVENT_ERR_UNCORRECTED : HW_EVENT_ERR_FATAL) :
 						 HW_EVENT_ERR_CORRECTED;
 
 	/*
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index d414698ca324..c5ab634cb6a4 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -2982,9 +2982,9 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv) {
-			tp_event = HW_EVENT_ERR_FATAL;
-		} else {
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
+		} else {
+			tp_event = HW_EVENT_ERR_FATAL;
 		}
 	} else {
 		tp_event = HW_EVENT_ERR_CORRECTED;
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 6d8d6dc626bf..2b4ce8e5ac2f 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -493,9 +493,9 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv) {
-			tp_event = HW_EVENT_ERR_FATAL;
-		} else {
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
+		} else {
+			tp_event = HW_EVENT_ERR_FATAL;
 		}
 	} else {
 		tp_event = HW_EVENT_ERR_CORRECTED;
-- 
2.21.1

