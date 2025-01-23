Return-Path: <linux-edac+bounces-2944-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2AA1A507
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2025 14:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E3B168B56
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179C20F060;
	Thu, 23 Jan 2025 13:31:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D626AF5;
	Thu, 23 Jan 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639087; cv=none; b=XMwUy2WHZi7d545Cq0XoHP8KR6xH1FIiTNucP16ocQkZHEZPWoBLDUyr0L8BZYJ4W1EuH4wqEbX9UNDFlv5tIsAnQt1Cu9dQqmV0kB9I4eCJT6v2YR0nSSqbMmKOHS27APOgmJJQG+5ogWnGAS5HrcG34PiSZy2Ps8y0sop9FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639087; c=relaxed/simple;
	bh=puV1XlGy/0q3xC1S0k33TxMikmvyxrluXX5SighM2ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1yXs2+lITkrTq9trixCpZuslByAM6oS+jhJrgf9OH12mxEKUooDuBpcfbtC/6/CB6wyP9NIWvpDdMGrgMlYXAoZ8fJxYfxYdYCY418Fft2qT8ciCbQ83eOd8SnsRvLeQIEcBSeO+kEHK49FUUE8Op6HfJ2wj42oTADIiBLMbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5D672116F;
	Thu, 23 Jan 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E83513A51;
	Thu, 23 Jan 2025 13:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mA5rIKtEkmeOVAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 23 Jan 2025 13:31:23 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 2/2] x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY
Date: Thu, 23 Jan 2025 15:31:11 +0200
Message-ID: <20250123133111.17867-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123133111.17867-1-nik.borisov@suse.com>
References: <20250123133111.17867-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D5D672116F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

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


