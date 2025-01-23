Return-Path: <linux-edac+bounces-2945-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C716A1A509
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2025 14:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7093C3A2D66
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0830020F997;
	Thu, 23 Jan 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SCwhbeHA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SCwhbeHA"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D9320B;
	Thu, 23 Jan 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639087; cv=none; b=VsFjjZvPRlTXIm9czadaii9g2JzynAzR6XNsS/PO6oJkVz5LkHYs00AhmE7ilr9Kx5vKDKRDA4ma4483+1PCOYEwVU8PlIz5OMgNJx04KTeN2W9ibZbTNArcq/HQdMGhPXZhxF3f1erY7j7iC9BFa22ZSYYlK0FkVgmV0iQcSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639087; c=relaxed/simple;
	bh=1XEE5ZMyxGPKRyO7wSyE7V2KZGczTZ7Wr5xhlESeTk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODg6wWaeRHiPRz4mne3A608kyc2fpAWE6SNJZU1e/5UqMjaH02HLMV8WyrbMzVrMOICWq8n/FSLf/sUKGtwHgH6yNbbSdj5qddEmE4vuX3fWA/IcSYXaXRJE1t4XQXGi3BKdCPOM64drd7eg+2WoQ+WurgAHnNJ/E8P0uR7+JAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SCwhbeHA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SCwhbeHA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A2C22116D;
	Thu, 23 Jan 2025 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737639083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QgVboW5U4vZOtStXHQV+Y0x65Rb5Ev16UEFKKQYe2lY=;
	b=SCwhbeHAPv3seq3AuB8dE2m9Ggw4oLPKrWJWAnLsu9fH5C7WSPSAIEkKOQwKk8xhD1639j
	gfvc5g0/FhSgUi/CPtuHHBKoHpTEvjBszUTtoge8eeOMTPoSfSY9O2ImAzG5g0NSIMj6bO
	UfPLGbvjC+uBGbPiI9sIz/W0mgDsWYg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737639083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QgVboW5U4vZOtStXHQV+Y0x65Rb5Ev16UEFKKQYe2lY=;
	b=SCwhbeHAPv3seq3AuB8dE2m9Ggw4oLPKrWJWAnLsu9fH5C7WSPSAIEkKOQwKk8xhD1639j
	gfvc5g0/FhSgUi/CPtuHHBKoHpTEvjBszUTtoge8eeOMTPoSfSY9O2ImAzG5g0NSIMj6bO
	UfPLGbvjC+uBGbPiI9sIz/W0mgDsWYg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35787136A1;
	Thu, 23 Jan 2025 13:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZrTICqtEkmeOVAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 23 Jan 2025 13:31:23 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 1/2] x86/mce/inject: Remove call to mce_notify_irq()
Date: Thu, 23 Jan 2025 15:31:10 +0200
Message-ID: <20250123133111.17867-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The call is actually a noop because when the MCE is raised the early
notifier is the only call site that correctly calls mce_notify_irq()
because it also sets mce_need_notify. Remove this call, making
mce_notify_irq() be private to core.c

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/mce.h       |  2 --
 arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
 arch/x86/kernel/cpu/mce/inject.c |  1 -
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index eb2db07ef39c..6c77c03139f7 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -296,8 +296,6 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-bool mce_notify_irq(void);
-
 DECLARE_PER_CPU(struct mce, injectm);
 
 /* Disable CMCI/polling for MCA bank claimed by firmware */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9894c7..89625ff79c3b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -584,6 +584,28 @@ bool mce_is_correctable(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_correctable);
 
+/*
+ * Notify the user(s) about new machine check events.
+ * Can be called from interrupt context, but not from machine check/NMI
+ * context.
+ */
+static int mce_notify_irq(void)
+{
+	/* Not more than two messages every minute */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
+
+	if (test_and_clear_bit(0, &mce_need_notify)) {
+		mce_work_trigger();
+
+		if (__ratelimit(&ratelimit))
+			pr_info(HW_ERR "Machine check events logged\n");
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
@@ -1773,28 +1795,6 @@ static void mce_timer_delete_all(void)
 		del_timer_sync(&per_cpu(mce_timer, cpu));
 }
 
-/*
- * Notify the user(s) about new machine check events.
- * Can be called from interrupt context, but not from machine check/NMI
- * context.
- */
-bool mce_notify_irq(void)
-{
-	/* Not more than two messages every minute */
-	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
-
-	if (test_and_clear_bit(0, &mce_need_notify)) {
-		mce_work_trigger();
-
-		if (__ratelimit(&ratelimit))
-			pr_info(HW_ERR "Machine check events logged\n");
-
-		return true;
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(mce_notify_irq);
-
 static void __mcheck_cpu_mce_banks_init(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 313fe682db33..06e3cf7229ce 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -229,7 +229,6 @@ static int raise_local(void)
 	} else if (m->status) {
 		pr_info("Starting machine check poll CPU %d\n", cpu);
 		raise_poll(m);
-		mce_notify_irq();
 		pr_info("Machine check poll done on CPU %d\n", cpu);
 	} else
 		m->finished = 0;
-- 
2.43.0


