Return-Path: <linux-edac+bounces-5743-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOIeDiHEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5743-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:25 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFF17D7BE
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3255C30A645F
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F8378839;
	Mon, 23 Feb 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Tu7VHWlV"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F7374759;
	Mon, 23 Feb 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881429; cv=none; b=akIM/k3T9bBqAZQdxnKZv9zq1vYgre7xiPDWysOS51FwVd43OJWQyul2bv5FnsWx5G1/J9/AuFonUJEU8QReOXF4dNdzNHBlyz2885ePDBLlYvvwLWwRCA2Mlx5RbiTQfPCBbNMUXqfXIEI0YHhoQEGAjLRO0LStBUGuaWkDEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881429; c=relaxed/simple;
	bh=OEWT5X2pzgtUky8GC9nV5gnBPw01d2i1GIn3qrr2SI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tV7tYRcLXDiJ3hsBl3dEoiibiSN53uTEl5Kr1GQyadGT1bXetw+19siFw81NNYY30cRGEMBho9GpVZCnZFeFpHS1/z+Rbpk+brmVSUhoe8B1lgGXSc7hw7vQA2+Ktc2MOzybdIxIQIEN4XJadc++UrKFvZlzKhPceAA/TIPmaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Tu7VHWlV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881425;
	bh=OEWT5X2pzgtUky8GC9nV5gnBPw01d2i1GIn3qrr2SI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tu7VHWlVSQ2Ch9aozvGK6W5VUBMXr+pyO38mv1WtKMOaA+I1SweJZxzBu5EKTE/q8
	 sHEci5IRLMF24ZuGHZA9SvydmoYZGbtlLkmHEimsGvenCiccr9OFpeal+qN6ko7SZ0
	 kWMKF1RtfKnEbnezqJYMqFOQPIOs8mHK/+zD/rY4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Feb 2026 22:16:29 +0100
Subject: [PATCH 2/7] EDAC/device: Drop unused macro to_edacdev_attr()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-sysfs-const-edac-v1-2-3ff0b87249e7@weissschuh.net>
References: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
In-Reply-To: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=679;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OEWT5X2pzgtUky8GC9nV5gnBPw01d2i1GIn3qrr2SI8=;
 b=EAgSpXb4W4LmuXY4gUl+gWcmw7Ne7FrN8LbNymWW0TVndGDbXCwMNCMf0ju3PLsRkatUKV2Gm
 pMD2LMcNKvDAf2uzqVvWXlAbQlWR9ds8dMcRJm2umE8wJqf/LGXIlwP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-5743-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,alien8.de,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:mid,weissschuh.net:dkim,weissschuh.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DFFF17D7BE
X-Rspamd-Action: no action

This macro is unused, drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/edac/edac_device_sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index fcebc4ffea26..9cc466b78982 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -21,8 +21,6 @@
 #define EDAC_DEVICE_SYMLINK	"device"
 
 #define to_edacdev(k) container_of(k, struct edac_device_ctl_info, kobj)
-#define to_edacdev_attr(a) container_of(a, struct edacdev_attribute, attr)
-
 
 /*
  * Set of edac_device_ctl_info attribute store/show functions

-- 
2.53.0


