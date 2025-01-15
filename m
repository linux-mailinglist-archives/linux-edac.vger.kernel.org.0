Return-Path: <linux-edac+bounces-2914-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FAA11B06
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 08:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085EF188A6DE
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C822F84F;
	Wed, 15 Jan 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sLSZk/Ph";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sLSZk/Ph"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1122F166;
	Wed, 15 Jan 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926627; cv=none; b=BHDYsFRXkbjUGMMXvaLcYSr8MUTwPDwLzRlFekHWFebwXr2hhGOgagFijIJGJVuStfpgju7XUjNTQrH4kGmjdzLhtGpDVeuseGTAy3/V71Rb7oAvFWwbKiU6rmBlkxba0loi+JX6Zz0Sfh/+XHQHUX61c7pQ63Aw40vDoTx/e9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926627; c=relaxed/simple;
	bh=Ta7/wk8PG440NjsU9HbIWpLwKT0+QfOFmgb13BivgPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H091Jl/Yk5v74ucelZtkZIDJ9YV/o7kDDiueynnDOAZZsWUV9K81OuW+Ehvsfuimt6cIfIOwDy3Gx8DpAfg1cuJT4dNi9pakRfBRA5lUbdRUmdWCgV57cmlcF2aOfYV6T6m39IRvAhGMgaBkVSKlU/c1pyl+6OhLBtkmte2ZWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sLSZk/Ph; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sLSZk/Ph; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46EBE1F460;
	Wed, 15 Jan 2025 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736926618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdZROEtM/+x4f3o7nUlSSNxFgZRPyRGQwqI+al79wGw=;
	b=sLSZk/Ph+bW1hN11VhI5yC75K4kttDvyFj40xvqjfuhzkMZAGo1IubuVx3wvgTsCmljZLV
	QTeKOPct/jRC2VJZkbU1uWIPGL8WGqL2n1tG4aEVd5sJWmUZL1SU6He5RUC9vhr3b06Int
	2oi8ah4UyH3pKv/lZDgUgjC5v9ac3wU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="sLSZk/Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736926618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdZROEtM/+x4f3o7nUlSSNxFgZRPyRGQwqI+al79wGw=;
	b=sLSZk/Ph+bW1hN11VhI5yC75K4kttDvyFj40xvqjfuhzkMZAGo1IubuVx3wvgTsCmljZLV
	QTeKOPct/jRC2VJZkbU1uWIPGL8WGqL2n1tG4aEVd5sJWmUZL1SU6He5RUC9vhr3b06Int
	2oi8ah4UyH3pKv/lZDgUgjC5v9ac3wU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F311813A8A;
	Wed, 15 Jan 2025 07:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LgmOZllh2crawAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 15 Jan 2025 07:36:57 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY
Date: Wed, 15 Jan 2025 09:36:40 +0200
Message-ID: <20250115073640.77099-4-nik.borisov@suse.com>
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
X-Rspamd-Queue-Id: 46EBE1F460
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

mce_notify_irq() really depends on the legacy mcelog being enabled as
otherwise mce_work_trigger() will never schedule the trigger work as
mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89625ff79c3b..b21aa1494da0 100644
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


