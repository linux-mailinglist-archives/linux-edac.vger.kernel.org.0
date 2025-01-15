Return-Path: <linux-edac+bounces-2915-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377BBA11B08
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 08:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DB5167F7F
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157E22FAD4;
	Wed, 15 Jan 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N82z6qv3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N82z6qv3"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD222F3A6;
	Wed, 15 Jan 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926627; cv=none; b=OVseD+TwmLDoBWRKhSiPa9bi1ye6m8N+nFXXen1P+Cck92KrEfnTOfV++++TcPiYP1FTQv1UrSRnCLpeT+mK+PIY8O3njx4BV43/P2p1kahPr4qkT1A2BgyXmOtnznWfuK9NQLZLjc8ZX06m4MGxiFKYa+QCgYiioWP/irGsXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926627; c=relaxed/simple;
	bh=D9h+tiP6JEtTHxSESOuMYqrrbcn5T1XnU7EvIPm8XQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxVUz3yML1pUSxfwCWFlCGk7w9GchZDMRI30aaKEXHNT2KHfqQy3VGjxPhMnbtjOy3wSY4sqfdFr1wJc6WX6wUxW+9oEggvUbR106CzDCMqrW1ZjcfEp/h9k+aJ5eLok4fBWPBV4yrWwWGDd0R9FL9Tmn5lIN1aJONdpr6wUZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N82z6qv3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N82z6qv3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98F692120C;
	Wed, 15 Jan 2025 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736926617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTH09SYz9NCYnEC36lz1B8Y+6XSMOmWFsvL3TMrAlMg=;
	b=N82z6qv3dVAl4m10RlESBOF1LvESR2yUHjAxpo7DxMkHKrGs6LVVloBZ5eBKmGUQcX6g4h
	nfX5kv+V35La6KfJBItPVoSii8fQU/LLfsnTclP1/PO9NK/AND9l2IeCRcrqa+3ET655qJ
	t/2Ixk+0Nk+ZilAEace2f6k6ZnTHY1E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N82z6qv3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736926617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTH09SYz9NCYnEC36lz1B8Y+6XSMOmWFsvL3TMrAlMg=;
	b=N82z6qv3dVAl4m10RlESBOF1LvESR2yUHjAxpo7DxMkHKrGs6LVVloBZ5eBKmGUQcX6g4h
	nfX5kv+V35La6KfJBItPVoSii8fQU/LLfsnTclP1/PO9NK/AND9l2IeCRcrqa+3ET655qJ
	t/2Ixk+0Nk+ZilAEace2f6k6ZnTHY1E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4728313A8A;
	Wed, 15 Jan 2025 07:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +NcbD5llh2crawAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 15 Jan 2025 07:36:57 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [RESEND PATCH 1/3] x86/mce/inject: Remova call to mce_notify_irq()
Date: Wed, 15 Jan 2025 09:36:38 +0200
Message-ID: <20250115073640.77099-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115073640.77099-1-nik.borisov@suse.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98F692120C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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
index 0dc00c9894c7..23e5e7f7c554 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1793,7 +1793,6 @@ bool mce_notify_irq(void)
 	}
 	return false;
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


