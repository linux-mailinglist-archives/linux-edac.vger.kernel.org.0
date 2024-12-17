Return-Path: <linux-edac+bounces-2732-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13E79F4E71
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 15:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1826F16CA76
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD21F756A;
	Tue, 17 Dec 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bs9ZmfDb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bs9ZmfDb"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01821F708C
	for <linux-edac@vger.kernel.org>; Tue, 17 Dec 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447086; cv=none; b=Tp+syRgDViHNEqOD6fa2uv4f4+3UZxqNDmWOdvJ1MtCd3YIT/DLfdnwjdJbP2QKnMovJngNmyE8fKQmpsc9J3+qGcN3xSXKZeGi0Ci6BRo1EZXhAn2gHhseOY97S5MVtokLPjQzW4xdqoh+1Z3JP0r+3fEKASlYxpV6RU61WdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447086; c=relaxed/simple;
	bh=nNORcNpWlQJ4FNKR4REHoQBv4NhiyTd0l//AvgF611o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScNBj8Hsnwew8JoGeYeco8QJrOgmeIzXU/RKCwbNaDisc37T7iCPaiI3fVjSonB5AF17PGz/GpfLeUTTpICwg5mzUDchp5edtbdSdkOuvRnRNWJJ6G3B1WMnostaIOEIILVV9Anfjvx4yV/OEm6ivKE7ddiZY5BjplIOJ9D84dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bs9ZmfDb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bs9ZmfDb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2CC41F456;
	Tue, 17 Dec 2024 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734447081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DumRuF/tkV7j4R0RnbUBno2FNMow6FiCqxNHGduhTYw=;
	b=Bs9ZmfDbbtndyWg046UDZ5+NEwPW5+eekRPul1ZQ/Kp1grlASLQweSXsdxrxjAee4b3f7I
	ackVuyi0zLeA9Mj6vv/8dLSzG5MxVCBm1awAOwhhhK79tE4Bo4N6dBzy3lokkAad1n29pm
	aiYtCo2AbOrdDU90khsonbTcY1C/N6U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734447081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DumRuF/tkV7j4R0RnbUBno2FNMow6FiCqxNHGduhTYw=;
	b=Bs9ZmfDbbtndyWg046UDZ5+NEwPW5+eekRPul1ZQ/Kp1grlASLQweSXsdxrxjAee4b3f7I
	ackVuyi0zLeA9Mj6vv/8dLSzG5MxVCBm1awAOwhhhK79tE4Bo4N6dBzy3lokkAad1n29pm
	aiYtCo2AbOrdDU90khsonbTcY1C/N6U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D40132EA;
	Tue, 17 Dec 2024 14:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qVHnIOmPYWf7FwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 17 Dec 2024 14:51:21 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-edac@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/mce/: Make cmci_supported() return bool
Date: Tue, 17 Dec 2024 16:51:17 +0200
Message-ID: <20241217145117.155990-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
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
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

It's the last function in this file which is not returning bool when it
should. Rectify this, no functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index b3cd2c61b11d..db0436e9c891 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -75,12 +75,12 @@ static u16 cmci_threshold[MAX_NR_BANKS];
  */
 #define CMCI_STORM_THRESHOLD	32749
 
-static int cmci_supported(int *banks)
+static bool cmci_supported(int *banks)
 {
 	u64 cap;
 
 	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
-		return 0;
+		return false;
 
 	/*
 	 * Vendor check is not strictly needed, but the initial
@@ -89,10 +89,10 @@ static int cmci_supported(int *banks)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
-		return 0;
+		return false;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
-		return 0;
+		return false;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);
-- 
2.43.0


