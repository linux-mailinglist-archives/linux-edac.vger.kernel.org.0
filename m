Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F53E12885D
	for <lists+linux-edac@lfdr.de>; Sat, 21 Dec 2019 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLUJYG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Dec 2019 04:24:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfLUJYG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 21 Dec 2019 04:24:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 60011AC23;
        Sat, 21 Dec 2019 09:24:04 +0000 (UTC)
Date:   Sat, 21 Dec 2019 10:23:53 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS urgent for 5.5
Message-ID: <20191221092353.GA5832@zn.tnic>
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

please pull three urgent RAS fixes for the AMD side of things:

- initialize struct mce.bank so that calculated error severity on AMD
SMCA machines is correct

- do not send IPIs early during bank initialization, when interrupts are
disabled

- a fix for when only a subset of MCA banks are enabled, which led to
boot hangs on some new AMD CPUs.

Thx.

---
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

for you to fetch changes up to a3a57ddad061acc90bef39635caf2b2330ce8f21:

  x86/mce: Fix possibly incorrect severity calculation on AMD (2019-12-17 09:39:53 +0100)

----------------------------------------------------------------
Jan H. Schönherr (1):
      x86/mce: Fix possibly incorrect severity calculation on AMD

Konstantin Khlebnikov (1):
      x86/MCE/AMD: Do not use rdmsr_safe_on_cpu() in smca_configure()

Yazen Ghannam (1):
      x86/MCE/AMD: Allow Reserved types to be overwritten in smca_banks[]

 arch/x86/kernel/cpu/mce/amd.c  | 4 ++--
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5167bd2bb6b1..d6cf5c18a7e0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -266,10 +266,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	smca_set_misc_banks_map(bank, cpu);
 
 	/* Return early if this bank was already initialized. */
-	if (smca_banks[bank].hwid)
+	if (smca_banks[bank].hwid && smca_banks[bank].hwid->hwid_mcatype != 0)
 		return;
 
-	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
+	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5f42f25bac8f..2e2a421c8528 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -819,8 +819,8 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 		if (quirk_no_way_out)
 			quirk_no_way_out(i, m, regs);
 
+		m->bank = i;
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			m->bank = i;
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
