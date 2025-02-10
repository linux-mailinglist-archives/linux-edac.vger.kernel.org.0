Return-Path: <linux-edac+bounces-3005-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED9A2F203
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21E216243A
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D938241C89;
	Mon, 10 Feb 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bHTJ6hs/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bHTJ6hs/"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB624BCF9;
	Mon, 10 Feb 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202438; cv=none; b=G7QxJ6UEDmk52SKBm07oRvNA8BpCHZ9DxTZrjknK04fLhSE0SHVMMdwP6bfKQNRixog0YgSpqL+nNyy9MKTOXypQCSBNCuRK4sFpBe6rTz6JuOQ7osIV5FTRGcIsV51niU0nLH9DcG9c+R8rtBogkdNSX4h2d/rmdJBjkZ3i0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202438; c=relaxed/simple;
	bh=GgN4GSnLCmoSoHjgwz5lRyTBcMWvdM5RGgX11LyKgCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW1eLLvyGAcXBqN7Ckbss4v+E50vFoD/YVGhinL4X/3fP/Qj0rkSUU60Oel3mY69gsTrb25McGR8u/UCZ0aTEMzdq5jr8h89PJu2R9Ny7sJlPOitURdI/NzhchH//dBAxXYdV1992V4s1ZwYbWyN21ZjXvoEfczt5E3h11/wSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bHTJ6hs/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bHTJ6hs/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89A41211A7;
	Mon, 10 Feb 2025 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739202434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1/OcBVt8aVVxEgbqtHYaL8EmsYbGghVZAotNfYtYS8=;
	b=bHTJ6hs/fqDCWOomDfug5cWpGHaTrMczT7jbVGqOenqC60JnlNw7GIiWqrp4LFVjCd5CsI
	4joA2Tx8HHJLpLTPwXrG11IG1ntJGqHp1LrpvaDaFZKOblSo4yzR1VwBngRUGzjcYSD7tS
	mieljpLXnUe6AsA2QGbCyFB8v8IOGHY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739202434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1/OcBVt8aVVxEgbqtHYaL8EmsYbGghVZAotNfYtYS8=;
	b=bHTJ6hs/fqDCWOomDfug5cWpGHaTrMczT7jbVGqOenqC60JnlNw7GIiWqrp4LFVjCd5CsI
	4joA2Tx8HHJLpLTPwXrG11IG1ntJGqHp1LrpvaDaFZKOblSo4yzR1VwBngRUGzjcYSD7tS
	mieljpLXnUe6AsA2QGbCyFB8v8IOGHY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 259F813A62;
	Mon, 10 Feb 2025 15:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IH5RBoIfqmdPPgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 10 Feb 2025 15:47:14 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tony.luck@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 2/3] x86/mce: Move message printing from mce_notify_irq to mce_early_notifier()
Date: Mon, 10 Feb 2025 17:47:05 +0200
Message-ID: <20250210154707.114219-3-nik.borisov@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Informing the user that an MCE has been logged from mce_notify_irq() is
somewhat misleading because whether the MCE has been logged actually
depends on whether CONFIG_X86_MCELOG_LEGACY is turned on or not.

Furthermore it was reported that actually having a message triggered
when an MCE is generated can be helpful in certain scenarios. Improve
the situation by lifting the printing to the generic
mce_early_notifier() as it's executed always and is independent of any
compile-time option.

Link: https://lore.kernel.org/all/CY8PR11MB7134D97F82DC001AE009637889E32@CY8PR11MB7134.namprd11.prod.outlook.com/
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89625ff79c3b..d55b1903fde6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -591,15 +591,8 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
  */
 static int mce_notify_irq(void)
 {
-	/* Not more than two messages every minute */
-	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
-
 	if (test_and_clear_bit(0, &mce_need_notify)) {
 		mce_work_trigger();
-
-		if (__ratelimit(&ratelimit))
-			pr_info(HW_ERR "Machine check events logged\n");
-
 		return 1;
 	}
 
@@ -609,6 +602,8 @@ static int mce_notify_irq(void)
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
+	/* Not more than two messages every minute */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
 	struct mce_hw_err *err = to_mce_hw_err(data);
 
 	if (!err)
@@ -619,6 +614,9 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 
 	set_bit(0, &mce_need_notify);
 
+	if (__ratelimit(&ratelimit))
+		pr_info(HW_ERR "Machine check event detected\n");
+
 	mce_notify_irq();
 
 	return NOTIFY_DONE;
-- 
2.43.0


