Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80162160270
	for <lists+linux-edac@lfdr.de>; Sun, 16 Feb 2020 09:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgBPISB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Feb 2020 03:18:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:49770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgBPISB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 16 Feb 2020 03:18:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 153C3AAF1;
        Sun, 16 Feb 2020 08:17:59 +0000 (UTC)
Date:   Sun, 16 Feb 2020 09:17:53 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for 5.6
Message-ID: <20200216081753.GA13765@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull two EDAC fixes for 5.6. Doing only signed tags from now on, btw.

Thx.

---
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_5.6

for you to fetch changes up to 4d59588c09f2a2daedad2a544d4d1b602ab3a8af:

  EDAC/sysfs: Remove csrow objects on errors (2020-02-13 13:29:41 +0100)

----------------------------------------------------------------
Two fixes for use-after-free and memory leaking in the EDAC core, by
Robert Richter.

Debug options like DEBUG_TEST_DRIVER_REMOVE, KASAN and DEBUG_KMEMLEAK
unearthed issues with the lifespan of memory allocated by the EDAC
memory controller descriptor due to misdesigned memory freeing, done
partially by the EDAC core *and* the driver core, which is problematic
to say the least.

These two are minimal fixes to take care of stable - a proper rework is
following which cleans up that mess properly.

----------------------------------------------------------------
Robert Richter (2):
      EDAC/mc: Fix use-after-free and memleaks during device removal
      EDAC/sysfs: Remove csrow objects on errors

 drivers/edac/edac_mc.c       | 12 +++---------
 drivers/edac/edac_mc_sysfs.c | 18 ++++--------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7243b88f81d8..69e0d90460e6 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -505,16 +505,10 @@ void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
 
-	/* If we're not yet registered with sysfs free only what was allocated
-	 * in edac_mc_alloc().
-	 */
-	if (!device_is_registered(&mci->dev)) {
-		_edac_mc_free(mci);
-		return;
-	}
+	if (device_is_registered(&mci->dev))
+		edac_unregister_sysfs(mci);
 
-	/* the mci instance is freed here, when the sysfs object is dropped */
-	edac_unregister_sysfs(mci);
+	_edac_mc_free(mci);
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
 
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0367554e7437..c70ec0a306d8 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -276,10 +276,7 @@ static const struct attribute_group *csrow_attr_groups[] = {
 
 static void csrow_attr_release(struct device *dev)
 {
-	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(csrow);
+	/* release device with _edac_mc_free() */
 }
 
 static const struct device_type csrow_attr_type = {
@@ -447,8 +444,7 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 		csrow = mci->csrows[i];
 		if (!nr_pages_per_csrow(csrow))
 			continue;
-
-		device_del(&mci->csrows[i]->dev);
+		device_unregister(&mci->csrows[i]->dev);
 	}
 
 	return err;
@@ -608,10 +604,7 @@ static const struct attribute_group *dimm_attr_groups[] = {
 
 static void dimm_attr_release(struct device *dev)
 {
-	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(dimm);
+	/* release device with _edac_mc_free() */
 }
 
 static const struct device_type dimm_attr_type = {
@@ -893,10 +886,7 @@ static const struct attribute_group *mci_attr_groups[] = {
 
 static void mci_attr_release(struct device *dev)
 {
-	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(mci);
+	/* release device with _edac_mc_free() */
 }
 
 static const struct device_type mci_attr_type = {

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
