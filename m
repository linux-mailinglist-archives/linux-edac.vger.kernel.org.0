Return-Path: <linux-edac+bounces-5747-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKcwAtHEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5747-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:21:21 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A308817D854
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5271316EBC7
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B19379982;
	Mon, 23 Feb 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eNACA1w5"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C33793B0;
	Mon, 23 Feb 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881432; cv=none; b=NeItcPhsqVAyFYJwg+AZHLe/y69+/4zooh7dXL7UoZCtrKWPMNwL0D709esW7B02oHPShfxouhF/nHdZD0jR9/H1i4zUci/eJ8E57o0utvUhzRZDGV7tgbHngGw6xVykVmA33Jbc5E0ZRcL4B9PeSCOYI51SDO5Fq9AthabiAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881432; c=relaxed/simple;
	bh=wX5oiGqLv37w2xOfmI9Zm5xOoRjsTLXZ19/2Ce2Okjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvHwfsA41LTcvqD0XgMkYJpqvt/5wPwjj42r5WZucQeONtAxIs+U4BLBQfJqJzEnAauaGHGN2KGTmovZEywZusk8iDRsFIOMNJs1GvvWbKjXLsuKyMN3CpJYFmENLKwEtMKqznbnCDpQIDzzCiLWn5uOhprB4KSLiepaNR63xgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eNACA1w5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881426;
	bh=wX5oiGqLv37w2xOfmI9Zm5xOoRjsTLXZ19/2Ce2Okjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eNACA1w5lCg0tqwlZhXGvg3dBEV9K/kGl1b3lWgleLutmKqj506FkP7JjRZQHWS8A
	 HDTvoyQlXVvLPzU+XlIOX/NU0ScNN+BWoM/4egJjHRPLdIm5z+0WiVZ/dBsRFlaHUU
	 qQVY2oV8ScnjwfpLbKB4A5ywVqCTnlQV2hZYES9U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Feb 2026 22:16:33 +0100
Subject: [PATCH 6/7] EDAC/device: All addition of sysfs attributes
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-sysfs-const-edac-v1-6-3ff0b87249e7@weissschuh.net>
References: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
In-Reply-To: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=1863;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wX5oiGqLv37w2xOfmI9Zm5xOoRjsTLXZ19/2Ce2Okjo=;
 b=zhpkBYjByzu1sjWxKgQw1kjmdrkh1O1Gl86tlyBh0RcEl/xfue4oVGxuV9vF277P/odgpuRZb
 XlB8e+tIcxiBZVKYSQYMxJuG9aveLFKTm9qBSAzVMO3/2Gn1XqNb762
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
	TAGGED_FROM(0.00)[bounces-5747-lists,linux-edac=lfdr.de];
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
X-Rspamd-Queue-Id: A308817D854
X-Rspamd-Action: no action

The generic EDAC sysfs code does not need to modify these structs.
Allow the drivers to add read-only ones.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/edac/edac_device.h       | 2 +-
 drivers/edac/edac_device_sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 034711d71ebf..24c1921aa490 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -163,7 +163,7 @@ struct edac_device_ctl_info {
 	 * If attributes are desired, then set to array of attributes
 	 * If no attributes are desired, leave NULL
 	 */
-	struct edac_dev_sysfs_attribute *sysfs_attributes;
+	const struct edac_dev_sysfs_attribute *sysfs_attributes;
 
 	/* pointer to main 'edac' subsys in sysfs */
 	const struct bus_type *edac_subsys;
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 754d44827942..b1c2717cd023 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -723,7 +723,7 @@ static void edac_device_delete_instances(struct edac_device_ctl_info *edac_dev)
 static int edac_device_add_main_sysfs_attributes(
 			struct edac_device_ctl_info *edac_dev)
 {
-	struct edac_dev_sysfs_attribute *sysfs_attrib;
+	const struct edac_dev_sysfs_attribute *sysfs_attrib;
 	int err = 0;
 
 	sysfs_attrib = edac_dev->sysfs_attributes;
@@ -752,7 +752,7 @@ static int edac_device_add_main_sysfs_attributes(
 static void edac_device_remove_main_sysfs_attributes(
 			struct edac_device_ctl_info *edac_dev)
 {
-	struct edac_dev_sysfs_attribute *sysfs_attrib;
+	const struct edac_dev_sysfs_attribute *sysfs_attrib;
 
 	/* if there are main attributes, defined, remove them. First,
 	 * point to the start of the array and iterate over it

-- 
2.53.0


