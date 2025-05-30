Return-Path: <linux-edac+bounces-4048-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A65AC8E3F
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320A2500066
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9623F413;
	Fri, 30 May 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8eub5PQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4C23F295;
	Fri, 30 May 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608787; cv=none; b=bxEdNE1w2L0aiYoDf0J6Z0DecybZmaAofCiwwVYMYqSfz1PGwY5TMdaNeiYJQpX+O0vNlG9O1DQ+1WisHhCJn27hBNuBJEpnpvTIxvCEwFgsthK537DqUYyIh2XsXcaTekFiF7HWb8hP62SMEJuJBeJZQbx+zGA8+RTEl/Nj7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608787; c=relaxed/simple;
	bh=TvNimTVgvbEym4ULdALPgk9HfGrV6xqArV1tyJRhJJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqUL9X5QY2fBfZfNa9uRiO1bYxluJoqz6e2fDO5bVxfclGIxB8kZnkeWEUc4yMJdO7TDie+s4wiSxTijN17l54yqxhpGtRiAgHe6H4qY2VGelPNJZE4GOFsOAeZdcug6/OYsaSPzjqvlo+j9FfjkJ86qLGENV5KLfOQ5ozuldik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8eub5PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD7CC4CEF1;
	Fri, 30 May 2025 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608787;
	bh=TvNimTVgvbEym4ULdALPgk9HfGrV6xqArV1tyJRhJJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8eub5PQSS/rxnIWD8Blk/PIybkelTfp028Jxi/Gc371Odkg1nhh3NMBBpoTHOKHs
	 ztEGp6XvqBJE4FQCavUFADISnyrMgVbCc5E72nBt20PKxsv6kzWS0i4NzBTiyCsM9M
	 B22OWiAicuq/ErDCjM9LYdjO7xnn3fW2VtV2T8Uzeoi7Kn95kIJ8Q/r4DxNva+97XS
	 Y1J2DxzBrQRYcmdYSz/jDBLUrKrhzlc7stWGtVBqKaDGxWZ8RZ2sWxj44s4xgo2xrY
	 rax6JUo9bw7SpmwqfxPX+YDd/qM/o090X1QYRKQ8L8O+jR27u0K2UWaflMfsCIfokt
	 TEl/IjiInzJXQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	bp@alien8.de,
	mchehab@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 10/28] EDAC/igen6: Skip absent memory controllers
Date: Fri, 30 May 2025 08:39:16 -0400
Message-Id: <20250530123934.2574748-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123934.2574748-1-sashal@kernel.org>
References: <20250530123934.2574748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 20e190b1c1fd88b21cc5106c12cfe6def5ab849d ]

Some BIOS versions may fuse off certain memory controllers and set the
registers of these absent memory controllers to ~0. The current igen6_edac
mistakenly enumerates these absent memory controllers and registers them
with the EDAC core.

Skip the absent memory controllers to avoid mistakenly enumerating them.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20250408132455.489046-2-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Bug Impact and User Experience This commit
fixes a real problem where **some BIOS versions fuse off certain memory
controllers** and set their registers to `~0` (all 1s). The current
igen6_edac driver mistakenly enumerates these absent memory controllers
and registers them with the EDAC core, which can lead to: 1. **Incorrect
memory controller enumeration** - showing non-existent memory
controllers to userspace 2. **Potential false error reporting** - trying
to read error logs from non-existent hardware 3. **Resource waste** -
allocating structures and registering devices for hardware that doesn't
exist ## Code Analysis - Minimal and Safe Changes Looking at the
specific code changes: ### 1. New Detection Function ```c +/* Check
whether the memory controller is absent. model/ prompt/ src/ target/
+static bool igen6_imc_absent(void __iomem *window) +{ + return
readl(window + MAD_INTER_CHANNEL_OFFSET) == ~0; +} ``` This is a
**simple, conservative check** that reads a known register
(`MAD_INTER_CHANNEL_OFFSET`) and checks if it returns all 1s (`~0`),
which is the standard pattern for absent/fused-off hardware. ### 2.
Modified Registration Logic The key change in `igen6_register_mcis()`:
```c + if (igen6_imc_absent(window)) { + iounmap(window); + edac_dbg(2,
"Skip absent mc%d\n", pmc); + continue; + } ``` This **safely skips**
absent controllers rather than trying to register them. The logic is: -
Map the memory controller's MMIO space - Check if it's absent (registers
return ~0) - If absent: unmap and continue to next controller - If
present: proceed with normal registration ### 3. Robust Error Handling
The code maintains proper resource cleanup and adds logging for when
fewer controllers are found than expected: ```c + if (lmc <
res_cfg->num_imc) + igen6_printk(KERN_WARNING, "Expected %d mcs, but
only %d detected.", + res_cfg->num_imc, lmc); ``` ## Comparison with
Similar Commits Looking at the historical examples: **Similar Commit #1
(YES)** - "EDAC/i10nm: Skip the absent memory controllers" has nearly
identical logic and was backported because it fixed absent memory
controller detection causing call traces. **Similar Commit #2 (YES)** -
A dependency fix that prevented build errors was backported. This commit
follows the same pattern as **Similar Commit #1** - it's a focused bug
fix for absent hardware detection with minimal risk. ## Why This Should
Be Backported ### 1. **Clear Bug Fix** This addresses a specific,
reproducible issue where BIOS configurations cause incorrect driver
behavior. ### 2. **Minimal Risk** - Small, contained change - Only
affects the memory controller enumeration path - Adds defensive checks
rather than changing core logic - Maintains backward compatibility ###
3. **Follows Established Patterns** The "check register for ~0" pattern
is well-established in kernel hardware detection and matches the
successful backport in Similar Commit #1. ### 4. **Hardware Support
Issue** This fixes support for legitimate hardware configurations where
BIOS has fused off memory controllers - these systems should work
correctly. ### 5. **Stable Tree Criteria Met** - ✅ Fixes important bug
affecting users - ✅ Small and contained change - ✅ No architectural
changes - ✅ Minimal regression risk - ✅ Confined to single driver
subsystem The commit represents exactly the type of targeted hardware
fix that stable trees are designed to include - it resolves a real-world
compatibility issue with a safe, minimal change.

 drivers/edac/igen6_edac.c | 78 +++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 595908af9e5c9..14692c2da6222 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -127,6 +127,7 @@
 
 static struct res_config {
 	bool machine_check;
+	/* The number of present memory controllers. */
 	int num_imc;
 	u32 imc_base;
 	u32 cmf_base;
@@ -1201,23 +1202,21 @@ static void igen6_check(struct mem_ctl_info *mci)
 		irq_work_queue(&ecclog_irq_work);
 }
 
-static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
+/* Check whether the memory controller is absent. */
+static bool igen6_imc_absent(void __iomem *window)
+{
+	return readl(window + MAD_INTER_CHANNEL_OFFSET) == ~0;
+}
+
+static int igen6_register_mci(int mc, void __iomem *window, struct pci_dev *pdev)
 {
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
 	struct igen6_imc *imc;
-	void __iomem *window;
 	int rc;
 
 	edac_dbg(2, "\n");
 
-	mchbar += mc * MCHBAR_SIZE;
-	window = ioremap(mchbar, MCHBAR_SIZE);
-	if (!window) {
-		igen6_printk(KERN_ERR, "Failed to ioremap 0x%llx\n", mchbar);
-		return -ENODEV;
-	}
-
 	layers[0].type = EDAC_MC_LAYER_CHANNEL;
 	layers[0].size = NUM_CHANNELS;
 	layers[0].is_virt_csrow = false;
@@ -1283,7 +1282,6 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 fail2:
 	edac_mc_free(mci);
 fail:
-	iounmap(window);
 	return rc;
 }
 
@@ -1309,6 +1307,56 @@ static void igen6_unregister_mcis(void)
 	}
 }
 
+static int igen6_register_mcis(struct pci_dev *pdev, u64 mchbar)
+{
+	void __iomem *window;
+	int lmc, pmc, rc;
+	u64 base;
+
+	for (lmc = 0, pmc = 0; pmc < NUM_IMC; pmc++) {
+		base   = mchbar + pmc * MCHBAR_SIZE;
+		window = ioremap(base, MCHBAR_SIZE);
+		if (!window) {
+			igen6_printk(KERN_ERR, "Failed to ioremap 0x%llx for mc%d\n", base, pmc);
+			rc = -ENOMEM;
+			goto out_unregister_mcis;
+		}
+
+		if (igen6_imc_absent(window)) {
+			iounmap(window);
+			edac_dbg(2, "Skip absent mc%d\n", pmc);
+			continue;
+		}
+
+		rc = igen6_register_mci(lmc, window, pdev);
+		if (rc)
+			goto out_iounmap;
+
+		/* Done, if all present MCs are detected and registered. */
+		if (++lmc >= res_cfg->num_imc)
+			break;
+	}
+
+	if (!lmc) {
+		igen6_printk(KERN_ERR, "No mc found.\n");
+		return -ENODEV;
+	}
+
+	if (lmc < res_cfg->num_imc)
+		igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d detected.",
+			     res_cfg->num_imc, lmc);
+
+	return 0;
+
+out_iounmap:
+	iounmap(window);
+
+out_unregister_mcis:
+	igen6_unregister_mcis();
+
+	return rc;
+}
+
 static int igen6_mem_slice_setup(u64 mchbar)
 {
 	struct igen6_imc *imc = &igen6_pvt->imc[0];
@@ -1405,7 +1453,7 @@ static void opstate_set(struct res_config *cfg, const struct pci_device_id *ent)
 static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	u64 mchbar;
-	int i, rc;
+	int rc;
 
 	edac_dbg(2, "\n");
 
@@ -1421,11 +1469,9 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	opstate_set(res_cfg, ent);
 
-	for (i = 0; i < res_cfg->num_imc; i++) {
-		rc = igen6_register_mci(i, mchbar, pdev);
-		if (rc)
-			goto fail2;
-	}
+	rc = igen6_register_mcis(pdev, mchbar);
+	if (rc)
+		goto fail;
 
 	if (res_cfg->num_imc > 1) {
 		rc = igen6_mem_slice_setup(mchbar);
-- 
2.39.5


