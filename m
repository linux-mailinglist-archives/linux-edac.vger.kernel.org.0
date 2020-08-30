Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514B7256C72
	for <lists+linux-edac@lfdr.de>; Sun, 30 Aug 2020 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgH3HC4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 30 Aug 2020 03:02:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:35192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgH3HCx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 30 Aug 2020 03:02:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31797AEFA;
        Sun, 30 Aug 2020 07:03:25 +0000 (UTC)
Date:   Sun, 30 Aug 2020 09:02:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v5.9-rc3
Message-ID: <20200830070245.GB4363@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull a single fix for the ghes_edac driver to properly clear
state on remove, when testing with CONFIG_DEBUG_TEST_DRIVER_REMOVE.

Thx.

---
The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc3

for you to fetch changes up to b972fdba8665d75109ade0357739f46af6415d2a:

  EDAC/ghes: Fix NULL pointer dereference in ghes_edac_register() (2020-08-27 18:04:07 +0200)

----------------------------------------------------------------
A fix to properly clear ghes_edac driver state on driver remove so that
a subsequent load can probe the system properly; by Shiju Jose.

----------------------------------------------------------------
Shiju Jose (1):
      EDAC/ghes: Fix NULL pointer dereference in ghes_edac_register()

 drivers/edac/ghes_edac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index da60c29468a7..54ebc8afc6b1 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -55,6 +55,8 @@ static DEFINE_SPINLOCK(ghes_lock);
 static bool __read_mostly force_load;
 module_param(force_load, bool, 0);
 
+static bool system_scanned;
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -225,14 +227,12 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 
 static void ghes_scan_system(void)
 {
-	static bool scanned;
-
-	if (scanned)
+	if (system_scanned)
 		return;
 
 	dmi_walk(enumerate_dimms, &ghes_hw);
 
-	scanned = true;
+	system_scanned = true;
 }
 
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
@@ -631,6 +631,8 @@ void ghes_edac_unregister(struct ghes *ghes)
 
 	mutex_lock(&ghes_reg_mutex);
 
+	system_scanned = false;
+
 	if (!refcount_dec_and_test(&ghes_refcount))
 		goto unlock;
 

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
