Return-Path: <linux-edac+bounces-5745-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAUwDbnEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5745-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:20:57 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D417D838
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B23E31534FE
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165EF379971;
	Mon, 23 Feb 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="azpk/Na7"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72E3793AA;
	Mon, 23 Feb 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881432; cv=none; b=SZbbyDIwSC31enBXOcD0R+Acmvz1phCwibDVvwWM7vp0hy/gCw7W81p1OllBv91fagLZ9SSYLHTxYGt3KQe2fkJtOc/hnPEs5HWUqUzK4Mt8vn73nyo5fugZ/Aq0CmhUmU8Cj1M7OyZUuAlboGxI6Cv8GOSas4AdUQoGYAprk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881432; c=relaxed/simple;
	bh=lGzYjD0ui7QuV8qqwy9PRnEooyHvUrDsTD6oAyW6U90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlN1YORvBLWCMsjYUo/oOepHvDUwaYAiWohZgosyNh4zIDkK/y9KSq34J7YtXpKq5bln/sv4nHO67rh+MZMHBosfCAEmK+U4O0MPgJEqW+Zlzcf5lkC+1Ukm86xCw5ghUS+i26FIFLG1IIXU4NCXeRHp7FVH5OIrrRH9VbNkP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=azpk/Na7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881426;
	bh=lGzYjD0ui7QuV8qqwy9PRnEooyHvUrDsTD6oAyW6U90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=azpk/Na7uKDLpuAcaT/7w2dwiX2r4Oaof58Rr9lUo7f2aiiZvBe2bWv1hEPs19uLr
	 r8aHf1eyK3jtRm2SvLqAk46RYR4TnjEcnWzlCMoHusHYhMgB+cYjL+kKLhe5wIO97S
	 HbSIuHNtR1d+mQ0fJ4qPaPgqlZeCiRKKvSg1uukE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Feb 2026 22:16:34 +0100
Subject: [PATCH 7/7] EDAC/mpc85xx: Constify device sysfs attributes
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-sysfs-const-edac-v1-7-3ff0b87249e7@weissschuh.net>
References: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
In-Reply-To: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=783;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lGzYjD0ui7QuV8qqwy9PRnEooyHvUrDsTD6oAyW6U90=;
 b=s2T0Lnmrc13QHpczKa05M45URkx7jHf6laLpgSDL8BWyf7FHu+s7PZK7mhvb9LNnPjoJFHXyZ
 d8EEC7SbUOQDSZyHfn/n+IJW47mRIytr71wJg1Ah/64Oj4HFs4XVhqd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-5745-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,alien8.de,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:mid,weissschuh.net:dkim,weissschuh.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D0D417D838
X-Rspamd-Action: no action

Now that the EDAC core allows the registration of read-only attributes,
make use of that in the mpc85xx driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/edac/mpc85xx_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index a45dc6b35ede..277f1c6bd522 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -399,7 +399,7 @@ static ssize_t mpc85xx_l2_inject_ctrl_store(struct edac_device_ctl_info
 	return 0;
 }
 
-static struct edac_dev_sysfs_attribute mpc85xx_l2_sysfs_attributes[] = {
+static const struct edac_dev_sysfs_attribute mpc85xx_l2_sysfs_attributes[] = {
 	{
 	 .attr = {
 		  .name = "inject_data_hi",

-- 
2.53.0


