Return-Path: <linux-edac+bounces-2903-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63CA10C6A
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8FF7A042B
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DA1C3C0A;
	Tue, 14 Jan 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DcyNMIpI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YYdjZAIs"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E7190077;
	Tue, 14 Jan 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872655; cv=none; b=aDEqfvjtM9zM+aek+sE6hUD+acNdrrteQzromHOaf4rGXCWDBAmZnsOV2FmCCvuJdAtASxpM//qBn4K66xaTfJKgUk+BaEKGlPr2OeXwHAOy7HOi2onx9bPqcwUAbFEA9rXLsz/BEQKetn5+QZCtnwwDzkmX+jTq/bAWOxDG2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872655; c=relaxed/simple;
	bh=r8WLse0+NYHOTFvn/7MlTvtI6eWUtB8PwFyUCVPP5Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUoi/9J+Itg0NdepAYfX4PnwBtrXMU2HUtf6wH0uYnjbk9KzoU6/gRFLTLDkWTdVTCFjfqxYfWqAoKEk8Tmjy4f4YiNGQu1pXQfiYRYFja3AwmvVCdLft0KbcWod6Si1zhCtk7hV8rPXerUcq/smhavWIsKCOUBen/NO5SSpqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DcyNMIpI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YYdjZAIs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD07D211F8;
	Tue, 14 Jan 2025 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WPCNFRKh6LuwLnfHCkt6uKEbjconuO+YW1mkO+kpjl4=;
	b=DcyNMIpI1Zcxb+bXoj+1Cd7WI6ee9jjFyNpIAi0/PzqRPoTemZd6UDRJPh/u2jcDQvfas/
	Ct0mUn+dRaEoGdr1rkNGTrK2SwLb5OZoa/Xc+9dfmF82bQXrzaK+12xgc/lUIxTmioe0XS
	4ROTnZtCKLx5aTwweq8VVBxw7C/uzcw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YYdjZAIs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736872651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WPCNFRKh6LuwLnfHCkt6uKEbjconuO+YW1mkO+kpjl4=;
	b=YYdjZAIsX7N1Si/uP4oYEFK7hi4Sq//6pXQYUaygETC/e8bTLZBShP45S+9Qx6bIK/3AAv
	wPeU5LYWxY8sIyE3DCtLJIO1cU7pbZ2QFJ9Pamh4OmwTP7Wz/rjHuKPtuhV5NOFD3bT1va
	RptLW4nPjAm66hjbGqXquNMuXjTqN00=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA6E61384C;
	Tue, 14 Jan 2025 16:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xOyyNsqShmfpCgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 14 Jan 2025 16:37:30 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 0/3] Cleanup mce_notify_irq usage
Date: Tue, 14 Jan 2025 18:37:19 +0200
Message-ID: <20250114163722.34850-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD07D211F8
X-Spam-Level: 
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO


Here are 3 small patches that result in mce_notify_irq becoming private to core.c
and unexporting it. I have one pending question that I've put under the scissor
line in Patch 3. But overall they are pretty self-explanatory and obvious.

Nikolay Borisov (3):
  x86/mce/inject: Remova call to mce_notify_irq()
  x86/mce: Make mce_notify_irq() static
  x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY

 arch/x86/include/asm/mce.h       |  2 --
 arch/x86/kernel/cpu/mce/core.c   | 44 +++++++++++++++++---------------
 arch/x86/kernel/cpu/mce/inject.c |  1 -
 3 files changed, 23 insertions(+), 24 deletions(-)

--
2.43.0


