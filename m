Return-Path: <linux-edac+bounces-5525-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A6C80FD2
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DAEC345BAB
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBEC30F7EA;
	Mon, 24 Nov 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sYHIteKi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sYHIteKi"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E730DEAF
	for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994332; cv=none; b=QZ8h+JJJ/PsoQg749rsDiUmoQCQKD6zlK2ef2qNBhkHsAUXsAFH+zhMkDNxyfEw0vMkcKDr9nJAaj4iqaax1R1T205do3mNIj6BrWUUCQTszCd1z6OuFsV247ZHWLyo+Eczw86MZ0tB4dfNNsGXaElmSR8Z687ko+NCnhXbNG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994332; c=relaxed/simple;
	bh=L/XbNw+4Ugcjx/J4Mai31cTuDAtYkM88zPyJ4ltrlgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XS6ncJ+r/teAdZsCBIXgIAzi04wxzSE8Tna4d7JUWkFipNHPXjglxbikLzgx3cJmHf/Kz8VFbHcVq8elCyqtgZfgqm5GcYsjuJhNA7IENPfjm6fr9vkpmATMeJPOgq1drcBEqD6FDJ98+cEQn+ofBgd+i5IhTcqtpSJFMOX7viY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sYHIteKi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sYHIteKi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 534425BD39;
	Mon, 24 Nov 2025 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763994327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=haavHNAGdu2Jadk1TzWiSsMC3NtXgH1OWZQ0Sj8vclQ=;
	b=sYHIteKiCsMfpxeM3neKOG7Ww6zq3Xg5yxyTqgygEBfBnlvACD1oc0banmPA3cKmkYgmY6
	RInqXOdJMnML0HhBaaxGthMwCMY2YMybB8wIuXdnC+5TWlEQ81wPqLl16uP/ioBk8eDOk9
	K/R2rkw+tCx96+whfulQXm2c0aNr0QE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763994327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=haavHNAGdu2Jadk1TzWiSsMC3NtXgH1OWZQ0Sj8vclQ=;
	b=sYHIteKiCsMfpxeM3neKOG7Ww6zq3Xg5yxyTqgygEBfBnlvACD1oc0banmPA3cKmkYgmY6
	RInqXOdJMnML0HhBaaxGthMwCMY2YMybB8wIuXdnC+5TWlEQ81wPqLl16uP/ioBk8eDOk9
	K/R2rkw+tCx96+whfulQXm2c0aNr0QE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F08323EA63;
	Mon, 24 Nov 2025 14:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yadDONZqJGm7DgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 24 Nov 2025 14:25:26 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Yazen.Ghannam@amd.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] RAS/AMD/ATL: Replace bitwise_xor_bits() with hweight16()
Date: Mon, 24 Nov 2025 16:25:17 +0200
Message-ID: <20251124142517.1708451-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Doing hweight16 and checking whether the lsb is set is functionally
equivalent to what bitwise_xor_bits() does. In addition it results in
better generated code as before gcc would inline the function 4 times.
With hweight, the resulting code boils down to 2 instructions -  popcnt
and andl as all cpus we care about has popcnt. No functional changes.

An alternative would have been to use the __builtin_parity() function provided
by both Clang/GCC, however under some circumstances the compiler can choose not
to inline it but generate a library call which is unsupported in the kernel.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 drivers/ras/amd/atl/umc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 6e072b7667e9..8d1363237eee 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -49,17 +49,6 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
 	return i;
 }

-/* XOR the bits in @val. */
-static u16 bitwise_xor_bits(u16 val)
-{
-	u16 tmp = 0;
-	u8 i;
-
-	for (i = 0; i < 16; i++)
-		tmp ^= (val >> i) & 0x1;
-
-	return tmp;
-}

 struct xor_bits {
 	bool	xor_enable;
@@ -250,17 +239,17 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 		if (!addr_hash.bank[i].xor_enable)
 			continue;

-		temp  = bitwise_xor_bits(col & addr_hash.bank[i].col_xor);
-		temp ^= bitwise_xor_bits(row & addr_hash.bank[i].row_xor);
+		temp  = hweight16(col & addr_hash.bank[i].col_xor) & 1;
+		temp ^= hweight16(row & addr_hash.bank[i].row_xor) & 1;
 		bank ^= temp << i;
 	}

 	/* Calculate hash for PC bit. */
 	if (addr_hash.pc.xor_enable) {
-		temp  = bitwise_xor_bits(col  & addr_hash.pc.col_xor);
-		temp ^= bitwise_xor_bits(row  & addr_hash.pc.row_xor);
+		temp  = hweight16(col & addr_hash.pc.col_xor) & 1;
+		temp ^= hweight16(row & addr_hash.pc.row_xor) & 1;
 		/* Bits SID[1:0] act as Bank[5:4] for PC hash, so apply them here. */
-		temp ^= bitwise_xor_bits((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor);
+		temp ^= hweight16((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor) & 1;
 		pc   ^= temp;
 	}

--
2.52.0


