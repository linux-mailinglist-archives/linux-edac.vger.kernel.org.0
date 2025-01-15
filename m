Return-Path: <linux-edac+bounces-2913-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA5A11B05
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 08:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C500E163FB5
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E922F3B9;
	Wed, 15 Jan 2025 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k9yeJ0Y7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k9yeJ0Y7"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE361DB120;
	Wed, 15 Jan 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926626; cv=none; b=hXTDXIcrB7XXl1lSljboDZ9Ai+KxEMZrLyLDCi1uccz2evVrCuG8uKO2cJ4Los5hAHCQlohj1nRkqm8UkOTAe17d8bpjcwwQryAIkz5Wds1TX1kd4AW/ESMTYIo+rYjXMlg4kt9o7Pi4ZZn2cH5gRCM2JFLFAv02zcV4kh80tBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926626; c=relaxed/simple;
	bh=JJFTPshd3fMg74+giI8EB2XWX1V/bLhkD6UJGu/x1Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG36e2mGR9yVrt8HK+psWZ6SqkeLzJ5S/7gCg86SR3gzbgwQL3TIw5uAJIhPDh+RgDwgLtqrzOtk35B1Ae22cff4cQeNOjTwt/q4XQ8aT799LJOUxVWvwW/2xw86W4i8du2jIdyYrwhwKQfdwevjoCuZkqH9XqRl4dFaD0QnZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k9yeJ0Y7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k9yeJ0Y7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 396EB1F458;
	Wed, 15 Jan 2025 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736926617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFLgiDGYGlBqrIhaqjLRhVZ+xw4MgkplKTgJownvhUc=;
	b=k9yeJ0Y72icPn2EZ+rxDUUTwT5lKLhuYqVOW2he5jEniLUGkGNfyVFJrY8z4VqGKCk4HGy
	7Rq2jqzhT5BaWrtODciwsb2sTSWLyJf5Xk/RWPxL+IRvMUWwuldDqV7Ln4NzKBMt7PtwXR
	dabYcGt5fKEjIjQlIauN9ErzVOY/3ts=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=k9yeJ0Y7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736926617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFLgiDGYGlBqrIhaqjLRhVZ+xw4MgkplKTgJownvhUc=;
	b=k9yeJ0Y72icPn2EZ+rxDUUTwT5lKLhuYqVOW2he5jEniLUGkGNfyVFJrY8z4VqGKCk4HGy
	7Rq2jqzhT5BaWrtODciwsb2sTSWLyJf5Xk/RWPxL+IRvMUWwuldDqV7Ln4NzKBMt7PtwXR
	dabYcGt5fKEjIjQlIauN9ErzVOY/3ts=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D850D139CB;
	Wed, 15 Jan 2025 07:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3bKHMphlh2crawAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 15 Jan 2025 07:36:56 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [RESEND PATCH 0/3] Make mce_notify_irq() static
Date: Wed, 15 Jan 2025 09:36:37 +0200
Message-ID: <20250115073640.77099-1-nik.borisov@suse.com>
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
X-Rspamd-Queue-Id: 396EB1F458
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Patches now rebased on core/ras

Nikolay Borisov (3):
  x86/mce/inject: Remova call to mce_notify_irq()
  x86/mce: Make mce_notify_irq() static
  x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY

 arch/x86/include/asm/mce.h       |  2 --
 arch/x86/kernel/cpu/mce/core.c   | 45 ++++++++++++++++----------------
 arch/x86/kernel/cpu/mce/inject.c |  1 -
 3 files changed, 23 insertions(+), 25 deletions(-)

--
2.43.0


