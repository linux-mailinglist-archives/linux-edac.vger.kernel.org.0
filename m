Return-Path: <linux-edac+bounces-3007-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB8DA2F206
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 16:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C305C188521F
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054C243952;
	Mon, 10 Feb 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Krdr8O4R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pIuzvIXz"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186391DF24F;
	Mon, 10 Feb 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202438; cv=none; b=BfdVeuBqvxpSEJsKOvtpOAHIODRLh2FBERE7HM3oOoVucuhCbMFrcrNv4WC3zkguRyj+vbHn+tz0z3RGx8SCmi5dCuzVMmrbHek/sLi/KnFbhmtSqOMIfujKWBqsToFzb+a5S06jihtsCggPmLHkgSSgujyeMTLIs6ntyMzIyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202438; c=relaxed/simple;
	bh=molnHLE+ImGyVT3dBeGgwJb2UsOhkCt7UFLAT06XLOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiMtkEnyRvC+GsUNu+xzpp5eGWd4wOX+5xJjoKmcCc8f4V+BHzjOPcyeLif0I3OK4V7uOUdFVP+1WByA/CtjmU9/X6uBPWPiTkOKP+n7NTl83GgLnzkP+mEioi/85LQAFil+Y6CInRXP8VFjIEOi/dgnauIGNWAl852BxLdlI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Krdr8O4R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pIuzvIXz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3DF61F7B9;
	Mon, 10 Feb 2025 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739202435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXMGG8/YIRRsCfEp6IX/XoMwtaLw4CtvY0PBv+VMLDA=;
	b=Krdr8O4RI2ZBadjbXeDMk9VzGEG+uuOvN2yKNuO7d6nRt3m9niV4AZQsjNCAWTE9nZZy6C
	0Pew616zCKalaRcmhaqbYvqkNxssB9+zVZ9rqK8bQLj62uNsjrUoSTxCBx3TFIcy0tapqB
	79Hl54YLDcqV6nAKpXoS/YlhXMa2orY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pIuzvIXz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739202434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXMGG8/YIRRsCfEp6IX/XoMwtaLw4CtvY0PBv+VMLDA=;
	b=pIuzvIXzJKJuRTaUiP2I643Z/8Po7wguAUisxat2jXotI14FfYtgg+njqLECxUctgtKkmt
	ydeU8PTw6FPtTx0+IquDVBbnpft+BwPgENAfE/ximbWoav/S/KAVjq2wsA23FdOi8gnFwo
	HWbtdy8JqRkTmwlQca1ZtlTThDRk8wk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9175B13AAB;
	Mon, 10 Feb 2025 15:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2B6sIIIfqmdPPgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 10 Feb 2025 15:47:14 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tony.luck@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 3/3] x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY
Date: Mon, 10 Feb 2025 17:47:06 +0200
Message-ID: <20250210154707.114219-4-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210154707.114219-1-nik.borisov@suse.com>
References: <20250210154707.114219-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3DF61F7B9
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

mce_notify_irq() really depends on the legacy mcelog being enabled as
otherwise mce_work_trigger() will never schedule the trigger work as
mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d55b1903fde6..8b8553e144ce 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -591,11 +591,13 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
  */
 static int mce_notify_irq(void)
 {
+#ifdef CONFIG_X86_MCELOG_LEGACY
+
 	if (test_and_clear_bit(0, &mce_need_notify)) {
 		mce_work_trigger();
 		return 1;
 	}
-
+#endif
 	return 0;
 }
 
-- 
2.43.0


