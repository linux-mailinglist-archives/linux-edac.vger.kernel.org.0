Return-Path: <linux-edac+bounces-5515-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0BC7F688
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 09:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 837F94E247C
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6222EAB8E;
	Mon, 24 Nov 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JHBMVif7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="crADgmnQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F171B4257
	for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763973622; cv=none; b=Vu37thn5Q3+Q6nxTMeqdPwgEeuYic5lZtszRbh2kaEaqq4SJhb//MEQnakXV13ApirFjIkhFOGCNeGpzz0LWeEvM5m0OiPlccvMTERvz5k/f99zzHAA/FTTx9816lt7DXpa2bX3tJq8qlrZiRiC8pHoXukd6QEjHaCq1GG5eyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763973622; c=relaxed/simple;
	bh=0gVSSlkfZ7/G/ViXIJGF/a7AS/PSsMXtmDfqXMvGemE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kY+Vt5sXeXkfU0K20Qd/iPXGnr7DiZ/Dx144PpXxKiHLRtIE5DZG7RLq2bOZXcsmekolEyxozLdGXB8eT0xr3l4W//AJrDCqOp6oveOtS3j4ShXld1PvAxaslJTJkYNOFqwWhG79J65uxU2bj3ECkIFPizFxzTqSWM7iwR5oG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JHBMVif7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=crADgmnQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4E915BD79;
	Mon, 24 Nov 2025 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763973619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7Q5k407pMWHn13JviZaygSuNBa3cflMA83SB44GzADw=;
	b=JHBMVif7w3Ywcl6L2TbvECEb81JSIaF7LPloC8CrBmc16oPYceon6AVPGf30wh0jEwo3wJ
	YHRHWlOlSZdFOri95pDwRok0A2CZtsd9PLnzqxCZcGaYkP5ueQ/1GFLB2LgfjzVwOwVO0q
	5t2HhKTbHiPBpPmYrnjRW7n2Q7wkBQs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=crADgmnQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763973618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7Q5k407pMWHn13JviZaygSuNBa3cflMA83SB44GzADw=;
	b=crADgmnQQzJp7hWwBj6/G+Z2zEGfRUvU5uKcaRzeppjDV+nxPk/GaWl1pGgfAzc++A0D9b
	9BjLsRaHPaEn6FcBYiCT6EvQBxlPJCM4iBNeWj0xYe//qPdYhBerwwWkclmQYCm82BDN78
	RX4NX2wya0ZQ4mZy41/nZV0vm+MmehM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6F83EA61;
	Mon, 24 Nov 2025 08:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HhpoH/IZJGl1OwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 24 Nov 2025 08:40:18 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Yazen.Ghannam@amd.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Date: Mon, 24 Nov 2025 10:40:11 +0200
Message-ID: <20251124084011.1575166-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D4E915BD79
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Both LLVM/GCC support a __builtin_parity function which is functionally
equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
relying on the built-in. No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

Changes since v1:

* Reworded the commit message

 drivers/ras/amd/atl/umc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 6e072b7667e9..7ff4a5a1c5da 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -49,18 +49,6 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
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
-
 struct xor_bits {
 	bool	xor_enable;
 	u16	col_xor;
@@ -250,17 +238,17 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 		if (!addr_hash.bank[i].xor_enable)
 			continue;

-		temp  = bitwise_xor_bits(col & addr_hash.bank[i].col_xor);
-		temp ^= bitwise_xor_bits(row & addr_hash.bank[i].row_xor);
+		temp  = (u16)__builtin_parity(col & addr_hash.bank[i].col_xor);
+		temp ^= (u16)__builtin_parity(row & addr_hash.bank[i].row_xor);
 		bank ^= temp << i;
 	}

 	/* Calculate hash for PC bit. */
 	if (addr_hash.pc.xor_enable) {
-		temp  = bitwise_xor_bits(col  & addr_hash.pc.col_xor);
-		temp ^= bitwise_xor_bits(row  & addr_hash.pc.row_xor);
+		temp  = (u16)__builtin_parity(col & addr_hash.pc.col_xor);
+		temp ^= (u16)__builtin_parity(row & addr_hash.pc.row_xor);
 		/* Bits SID[1:0] act as Bank[5:4] for PC hash, so apply them here. */
-		temp ^= bitwise_xor_bits((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor);
+		temp ^= (u16)__builtin_parity((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor);
 		pc   ^= temp;
 	}

--
2.52.0


