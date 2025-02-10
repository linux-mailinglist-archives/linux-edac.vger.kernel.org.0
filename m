Return-Path: <linux-edac+bounces-3004-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F3A2F202
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B82161F4D
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE2225A25;
	Mon, 10 Feb 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TOWUZ8xr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TOWUZ8xr"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7424BCF1;
	Mon, 10 Feb 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202438; cv=none; b=giobHaxOESZh5G+E581EkIXI/mkXZNuJLL5Gk6HbeSvJnbMJhqi7NijwAeu22P8LDQ9nRw3Fd09r4xJz1MPGWdI5XJAesCQNp2oYOtbGrC6JVBwxH+POJUpil4/ArSvrkJMCFijZfpewImCbDLxISQhs3Ng705pIaWk9UW7wkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202438; c=relaxed/simple;
	bh=D+EWLBtFF8lYndQh7vIoX7zcdw3vh3nYKoiDH1lmpiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+HqsoddtcCzHNgf80+iM++jzl5iEfjXykoofn7iAHNbg62fSXsaOC1gzCK+qzBoatfN0k3DNT1vHt6g2naQHYD68OfW8Owxfssab9HbsgdRzA036/jCjAfLjqUlRKhtHy7wZH6pa5SidLSJsQU9L4ZiLwLdRa6AyfYzFkdAL8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TOWUZ8xr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TOWUZ8xr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A936E21170;
	Mon, 10 Feb 2025 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739202433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jw9h8rxllQGF8z7VjcuQ/JZbmotoPjilKT8uXVRgFP4=;
	b=TOWUZ8xrbFD/SJFd+4IV6NXkqQyaz1GOzrtioF6cwXnFtDUI/HXvukPwCTdj7nd1TgGFXO
	25OF/LFUyKwS9WTXNzBEdDPg2fr8Q6qw23/BYfmGkHW+XA5h6EeFeWCuhjRAd4phgTERG3
	YzOfCUrAoezV1TYuqA8K+pXEhMUgnMw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TOWUZ8xr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739202433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jw9h8rxllQGF8z7VjcuQ/JZbmotoPjilKT8uXVRgFP4=;
	b=TOWUZ8xrbFD/SJFd+4IV6NXkqQyaz1GOzrtioF6cwXnFtDUI/HXvukPwCTdj7nd1TgGFXO
	25OF/LFUyKwS9WTXNzBEdDPg2fr8Q6qw23/BYfmGkHW+XA5h6EeFeWCuhjRAd4phgTERG3
	YzOfCUrAoezV1TYuqA8K+pXEhMUgnMw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 374E813A62;
	Mon, 10 Feb 2025 15:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X/WFCoEfqmdPPgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 10 Feb 2025 15:47:13 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tony.luck@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 0/3] Simpify mce code somewhat
Date: Mon, 10 Feb 2025 17:47:03 +0200
Message-ID: <20250210154707.114219-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A936E21170
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Here's v2 of the patchset simplifying the MCE proper code. Main changes are:

* Typos/grammar fixes (Yazen)
* Squashed the patch making mce_notify_irq static into the first patch (Yazen)
* Factored out the printing related code from mce_notify_irq() into mce_early_notifier() (Qiuxu)

Nikolay Borisov (3):
  x86/mce/inject: Remove call to mce_notify_irq()
  x86/mce: Move message printing from mce_notify_irq to
    mce_early_notifier()
  x86/mce: Make mce_notify_irq() depend on CONFIG_X86_MCELOG_LEGACY

 arch/x86/include/asm/mce.h       |  2 --
 arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
 arch/x86/kernel/cpu/mce/inject.c |  1 -
 3 files changed, 22 insertions(+), 25 deletions(-)

--
2.43.0


