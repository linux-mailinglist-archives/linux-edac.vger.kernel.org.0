Return-Path: <linux-edac+bounces-2906-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E2A10C70
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78BB3A0F97
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18191D63E2;
	Tue, 14 Jan 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LIvN6him";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LIvN6him"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B281C8776;
	Tue, 14 Jan 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872658; cv=none; b=DoVbOOPs0EODw5QeK/SLsG9F7iLTY2R5IOaq2qbgQ2BSCslFgwHHrrDnYTY9qkDWerImV9wZv8kPbL+K4hgm/OwGRt9sAIQPAWRVDJe++zntXiC+12lStV2124udRMxx8s3n3pZbVNKqhxhaSx55seWfT94O3VCEzvzIu/yoCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872658; c=relaxed/simple;
	bh=ImiK1sZx7744zGqJyW4Jr5XguEhXlq61ttaYjgVuQqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqAJ0aFFxtynK+Xije2gfO5KwQ71++ivJ4Ig32/0JfGbGonvleoZM2I1EudA/3F7jX5SeDlycoCphR9zrwcSSgMKPtYwiQhRa/je8Wu0P1xn+KY6WtTiqKrF+5moFaJ79yCFNeOAE1kuw8CGYmud4v32SA0O2sXcfjrUdxvLhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LIvN6him; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LIvN6him; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AF591F78B;
	Tue, 14 Jan 2025 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU1XfdYdHAJYZu7HkgbOsnG0DHNk2dKwW3G8GLbmzfs=;
	b=LIvN6himH/uLLflzSav8ZeofTWggzu13S1VxwdemlPRWLpTderCTs+cCA5y74M6P7tsoR9
	dWPDrmwgdfQ1Wpa73hTxFAU5Eh/s7bM3Mvre8jZD6IqK6/E8RBDQic2Cihh9GDjhw/rluQ
	ggunBLcFhyXgPMeQ3PTu6oagjy+AkPk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU1XfdYdHAJYZu7HkgbOsnG0DHNk2dKwW3G8GLbmzfs=;
	b=LIvN6himH/uLLflzSav8ZeofTWggzu13S1VxwdemlPRWLpTderCTs+cCA5y74M6P7tsoR9
	dWPDrmwgdfQ1Wpa73hTxFAU5Eh/s7bM3Mvre8jZD6IqK6/E8RBDQic2Cihh9GDjhw/rluQ
	ggunBLcFhyXgPMeQ3PTu6oagjy+AkPk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20A361384C;
	Tue, 14 Jan 2025 16:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJ2rBc+ShmfpCgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 14 Jan 2025 16:37:35 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 3/3] x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY
Date: Tue, 14 Jan 2025 18:37:22 +0200
Message-ID: <20250114163722.34850-4-nik.borisov@suse.com>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

mce_notify_irq() really depends on the legacy mcelog being enabled as
otherwise mce_work_trigger() will never schedule the trigger work as
mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

In addition to making the body of this function depend on MCELOG, mce_need_notify
also depends entirely on MCELOG, however I haven't added it since I don't want to
proliferate ifdefs, this begs the qustion whether this patch is acceptable ?

 arch/x86/kernel/cpu/mce/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2544e9ae7449..4e2f6c162b43 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -591,6 +591,7 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
  */
 static int mce_notify_irq(void)
 {
+#ifdef CONFIG_X86_MCELOG_LEGACY
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);

@@ -602,7 +603,7 @@ static int mce_notify_irq(void)

 		return 1;
 	}
-
+#endif
 	return 0;
 }

--
2.43.0


