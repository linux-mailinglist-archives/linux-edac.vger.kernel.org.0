Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400D824ECAA
	for <lists+linux-edac@lfdr.de>; Sun, 23 Aug 2020 12:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHWKMN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 23 Aug 2020 06:12:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgHWKMM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 23 Aug 2020 06:12:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85514AE92;
        Sun, 23 Aug 2020 10:12:39 +0000 (UTC)
Date:   Sun, 23 Aug 2020 12:12:03 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v5.9-rc2
Message-ID: <20200823101203.GA27452@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull a single fix which corrects a wrong error severity
determination which got copied to a bunch of drivers too.

Thx.

---
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc2

for you to fetch changes up to 45bc6098a3e279d8e391d22428396687562797e2:

  EDAC/{i7core,sb,pnd2,skx}: Fix error event severity (2020-08-18 15:40:30 +0200)

----------------------------------------------------------------
A single fix correcting a reversed error severity determination check
which lead to a recoverable error getting marked as fatal, by Tony
Luck.

----------------------------------------------------------------
Tony Luck (1):
      EDAC/{i7core,sb,pnd2,skx}: Fix error event severity

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
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
