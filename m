Return-Path: <linux-edac+bounces-2905-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD2A10C6E
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0123A2123
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E11D517E;
	Tue, 14 Jan 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b0+7TZCM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b0+7TZCM"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F61CB501;
	Tue, 14 Jan 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872658; cv=none; b=qjIhJ3PE+1APvCbk6XZT6FFhPb/o8jyeqSkUDp+po/gWHzLLdMJOzYF/tOAcMFP8llmH2TPO/rj5VPoniNVUEyfbsAJAusbN+iofAYSQY1b9MTAWqJCJjr5Fl4OrUWk5rHmTjYP12H1tPQb8u/nCI8sUsuRRFxAMh+BZdAVtA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872658; c=relaxed/simple;
	bh=B8QdmRsldnGdRGocpenIeiP431RBu3wyrIDl5cwRxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV20LdeY18SYwLmy2Sl2ojDzrW+jnjfIlEFk9HT4BRe9g6ETTv6X8tfNm9tOMr1N/WMR1oo0wuxluTfuq4Gq24NyKfMuXg0dykoNp1YffM8wts+Q3IWosj66Uqa2YdBevzImJqji7PbfItwSwx07GIvmZBQPIDZ6ZSFVvAY54hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b0+7TZCM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b0+7TZCM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB95A1F789;
	Tue, 14 Jan 2025 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KAc03OqcCwBki9FioTf5Eugi+fZBXsOXeI9zACJIvA=;
	b=b0+7TZCM1g3cybJTZm41LpjKVtJBogWbMpiehvNK4FM7yWvgYNOE9/MFrv9nFFOmAC3r02
	SsXGRpS+8UR5WHCFyPLyC20tgc4SACZ5iK2tdWU2y25Z69pxSvDshTX97fLFF0VMh4OxU4
	oIi4aZqOSU1IcOKpGedG1b6a6wHWwfM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=b0+7TZCM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KAc03OqcCwBki9FioTf5Eugi+fZBXsOXeI9zACJIvA=;
	b=b0+7TZCM1g3cybJTZm41LpjKVtJBogWbMpiehvNK4FM7yWvgYNOE9/MFrv9nFFOmAC3r02
	SsXGRpS+8UR5WHCFyPLyC20tgc4SACZ5iK2tdWU2y25Z69pxSvDshTX97fLFF0VMh4OxU4
	oIi4aZqOSU1IcOKpGedG1b6a6wHWwfM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 765D61384C;
	Tue, 14 Jan 2025 16:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4M5tGs2ShmfpCgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 14 Jan 2025 16:37:33 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 2/3] x86/mce: Make mce_notify_irq() static
Date: Tue, 14 Jan 2025 18:37:21 +0200
Message-ID: <20250114163722.34850-3-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114163722.34850-1-nik.borisov@suse.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB95A1F789
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

It's no longer used outside of core.c so let's make it static. No
functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/mce.h     |  2 --
 arch/x86/kernel/cpu/mce/core.c | 42 ++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4543cf2eb5e8..a665cd464889 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -296,8 +296,6 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-int mce_notify_irq(void);
-
 DECLARE_PER_CPU(struct mce, injectm);
 
 /* Disable CMCI/polling for MCA bank claimed by firmware */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e87676d86a85..2544e9ae7449 100644
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
@@ -1773,26 +1795,6 @@ static void mce_timer_delete_all(void)
 		del_timer_sync(&per_cpu(mce_timer, cpu));
 }
 
-/*
- * Notify the user(s) about new machine check events.
- * Can be called from interrupt context, but not from machine check/NMI
- * context.
- */
-int mce_notify_irq(void)
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
-		return 1;
-	}
-	return 0;
-}
 
 static void __mcheck_cpu_mce_banks_init(void)
 {
-- 
2.43.0


