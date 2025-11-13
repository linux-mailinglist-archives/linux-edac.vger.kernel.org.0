Return-Path: <linux-edac+bounces-5436-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47887C571F3
	for <lists+linux-edac@lfdr.de>; Thu, 13 Nov 2025 12:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B791A3BDA02
	for <lists+linux-edac@lfdr.de>; Thu, 13 Nov 2025 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C13396E8;
	Thu, 13 Nov 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TRCJCCoT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TRCJCCoT"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CF33B6DD
	for <linux-edac@vger.kernel.org>; Thu, 13 Nov 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032297; cv=none; b=ooyNESxD6xe30vInN5ZWOBWb+R3DooWcgImm2WaWMvbxiEhGAss8NYpU3GpF53I31HjgXB32nyu/GPyEClqXGvvUCO7DwuHY9l9RVlCI0+bkVPSrZhA/rEoralsNWjjptJM+iacfZwfaOW1pTHyoVuT6seHJwO8YFgBaI6Qte0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032297; c=relaxed/simple;
	bh=1/FPQVsnQzjrhTBdNlAXMKIfkauK1gmj7sm/TRh4/0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIn//dTdCC6DsRYuyYbKM7AlVuWo7BSND29gvCkbbYX1L5MjwNMwLjaHIzN0thUK1lm9NSbVlSZa3ehTY/28RTe8va6cgYWVhjTXzw0gstkCIZ38H+B4R6DBOy6d40mZ7wilVEffkfaU/tNWjROYZigFk6KKP/7unweckeUp1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TRCJCCoT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TRCJCCoT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 706F11F894;
	Thu, 13 Nov 2025 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763032287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1I9SGJKsb/GK/Y/jlbo+QZ+I4rf+T9CoVcsICkpyoJk=;
	b=TRCJCCoT0AXPBYCCD2mTyJDuS0Wp8ssfjYRrI8wEWRSw153B9MswJCahHWfryfRY8JBR6r
	dKrejh8LeEjIC5agiBzlr+USVQEMQgQ/qiNbyfx+9DtoNgOYBfCEZfbp/VXrNf5aPnWmNJ
	a9P63WGJUw/Z5cZU4WYaoPqTzGlSgUQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TRCJCCoT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763032287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1I9SGJKsb/GK/Y/jlbo+QZ+I4rf+T9CoVcsICkpyoJk=;
	b=TRCJCCoT0AXPBYCCD2mTyJDuS0Wp8ssfjYRrI8wEWRSw153B9MswJCahHWfryfRY8JBR6r
	dKrejh8LeEjIC5agiBzlr+USVQEMQgQ/qiNbyfx+9DtoNgOYBfCEZfbp/VXrNf5aPnWmNJ
	a9P63WGJUw/Z5cZU4WYaoPqTzGlSgUQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18ECE3EA61;
	Thu, 13 Nov 2025 11:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LzazA9+8FWllWgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 13 Nov 2025 11:11:27 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: Yazen.Ghannam@amd.com
Cc: bp@alien8.de,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] RAS/AMD/ATL: Remove bitwise_xor_bits
Date: Thu, 13 Nov 2025 13:11:25 +0200
Message-ID: <20251113111125.823960-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 706F11F894
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

The name of the function is somewhat misleading, it's not just XORing
bits, but is calculating the parity of the passed in value. There's
already a compiler builtin function for this - __builtin_parity. Just
use it. No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
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
2.51.1


