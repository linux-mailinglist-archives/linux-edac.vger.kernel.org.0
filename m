Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8114B271327
	for <lists+linux-edac@lfdr.de>; Sun, 20 Sep 2020 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgITJZH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Sep 2020 05:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgITJZH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 20 Sep 2020 05:25:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6207AC26;
        Sun, 20 Sep 2020 09:25:40 +0000 (UTC)
Date:   Sun, 20 Sep 2020 11:24:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v5.9-rc6
Message-ID: <20200920092456.GA13044@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull two more fixes for ghes_edac resulting from playing with
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y.

Thx.

---
The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc6

for you to fetch changes up to 251c54ea26fa6029b01a76161a37a12fde5124e4:

  EDAC/ghes: Check whether the driver is on the safe list correctly (2020-09-15 09:42:15 +0200)

----------------------------------------------------------------
Two fixes for resulting from CONFIG_DEBUG_TEST_DRIVER_REMOVE=y experiments:

* The first one completes a previous fix to reset a local structure
containing scanned system data properly so that the driver rescans, as
it should, on a second load.

* The second one addresses a refcount underflow due to not paying
attention to the driver whitelest on unregister.

----------------------------------------------------------------
Borislav Petkov (2):
      EDAC/ghes: Clear scanned data on unload
      EDAC/ghes: Check whether the driver is on the safe list correctly

 drivers/edac/ghes_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 54ebc8afc6b1..94d1e3165052 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -508,6 +508,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		if (!force_load && idx < 0)
 			return -ENODEV;
 	} else {
+		force_load = true;
 		idx = 0;
 	}
 
@@ -629,9 +630,13 @@ void ghes_edac_unregister(struct ghes *ghes)
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
+	if (!force_load)
+		return;
+
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
+	memset(&ghes_hw, 0, sizeof(struct ghes_hw_desc));
 
 	if (!refcount_dec_and_test(&ghes_refcount))
 		goto unlock;

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
