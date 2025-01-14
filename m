Return-Path: <linux-edac+bounces-2904-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B826DA10C6C
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0C218869FA
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E091D3576;
	Tue, 14 Jan 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aep78i/y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aep78i/y"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A481C2324;
	Tue, 14 Jan 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872657; cv=none; b=q4mhsftc6Hio2Pq05C01n3cdz2cwl3Rq+JKac1JM7Lqz2v8imydFbYg3h+gEtGW9bwiaGSMtdaUI+JkcoBWpOhop7Zu/YoZkRPuB8HJu7RlZl5Cu38v1SKJiFDIUCzd7SBxOrgmh+rU1fEwkAxs6L9R4yDbjnxru5dVeQIYfhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872657; c=relaxed/simple;
	bh=atYzKM7csFUGjo0rmh4A/GQbaQhKSLgQCXyg1W1ENHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT9E+9wDS0ItbCYzapTxFFiYQTNCV6N+hz9Kcf2MJXndtZgo7+iiNyoHZmI5GpPJri3WzNRF1PWXsNv/Mt6E+9eL2OruLr09zlPPSbI/ZH/yf4eonhNDTWYVr4q5Av4NnSoYkMM8AfVdBD9Yq5MdLT5qDxMk6D999qo2TjbhcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aep78i/y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aep78i/y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 662DF1F786;
	Tue, 14 Jan 2025 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6mJom1qodA0dlBP8nCKHNIUf7s1a49HNKJZRBNdNYU=;
	b=aep78i/yyq78IazRwqcbzrl1VLN+8B6h7n01CHnWUYttQ9flud3AySQ/AgwX2/0sE46Ztn
	5xFgjSEV66HjQAVqhVZbkSyjultQjfSFUZEYm/Q2RS1B3HTzRglETrKfjE2ei+D9wrnFLZ
	9GTPWnJ6uMbjwWUcNBj+svHoveoXcaU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6mJom1qodA0dlBP8nCKHNIUf7s1a49HNKJZRBNdNYU=;
	b=aep78i/yyq78IazRwqcbzrl1VLN+8B6h7n01CHnWUYttQ9flud3AySQ/AgwX2/0sE46Ztn
	5xFgjSEV66HjQAVqhVZbkSyjultQjfSFUZEYm/Q2RS1B3HTzRglETrKfjE2ei+D9wrnFLZ
	9GTPWnJ6uMbjwWUcNBj+svHoveoXcaU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCF5213AEB;
	Tue, 14 Jan 2025 16:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFOAM8uShmfpCgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 14 Jan 2025 16:37:31 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 1/3] x86/mce/inject: Remova call to mce_notify_irq()
Date: Tue, 14 Jan 2025 18:37:20 +0200
Message-ID: <20250114163722.34850-2-nik.borisov@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The call is actually a noop because when the MCE is raised the early
notifier is the only call site that correctly calls mce_notify_irq()
because it also sets mce_need_notify. So let's just remove this call,
which allows to unexport mce_notify_irq.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c   | 1 -
 arch/x86/kernel/cpu/mce/inject.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7fb5556a0b53..e87676d86a85 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1793,7 +1793,6 @@ int mce_notify_irq(void)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mce_notify_irq);
 
 static void __mcheck_cpu_mce_banks_init(void)
 {
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


