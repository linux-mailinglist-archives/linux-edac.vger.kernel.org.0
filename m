Return-Path: <linux-edac+bounces-5746-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBt2O7zEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5746-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:21:00 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5817D83F
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2AC3157F1D
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B50379974;
	Mon, 23 Feb 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RRVi7lqq"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B43793B6;
	Mon, 23 Feb 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881432; cv=none; b=jZPpXpjMtGvX9+XxcgW5pCXO7uiFlAbWy2P95IBXnFmD4OaQI6NTnsS5eAO2hrD+0fnTOnrWeqarCvwuJDx0qVHyn8Eu5vvNtIFFDX1JwOL0v7JW/QFAaZqMRhJTQnEgvgdxJIO65IO5Ax0PgD4eVA5lKt42ng0dFoNBvcZcIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881432; c=relaxed/simple;
	bh=a+yIMqJ7dUxkiRYKVugG14fCgSuZdNdFzRaiCa3EvvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OlFZK/eVGjcB4siGX6jSYreQuIUIUPVjJu1QV171A8YMK/qVJs5PdR/zCvtq4XI89WDy8APA6EP++E7BHx32gE+PYXD8yqfqHHigAKPokZVyIYjDa1YRfPW5Vof0JChKowTaSnfow9cT3s18Ok2JeThY6MomhujJk7TOqUPOVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RRVi7lqq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881425;
	bh=a+yIMqJ7dUxkiRYKVugG14fCgSuZdNdFzRaiCa3EvvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RRVi7lqq8sB4FqUPTu92IJlH+jb2QmOEsl/Hr1K3fOWqhZhGxbShmYLLUZy2d9tiI
	 uaeHyeoCK5qSAvS2wcantPFDI5JPCi0nf+cWYElUJIK/AkAFOkBRJ+0RbWfAVvV34d
	 I9OhWPmvW3uIe/nrWx7DtZF/bI4xnh4vKuBkFSGU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Feb 2026 22:16:31 +0100
Subject: [PATCH 4/7] EDAC/device: Constify info sysfs attributes
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-sysfs-const-edac-v1-4-3ff0b87249e7@weissschuh.net>
References: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
In-Reply-To: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=2510;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=a+yIMqJ7dUxkiRYKVugG14fCgSuZdNdFzRaiCa3EvvM=;
 b=viQonSwMb3B5u2rAP0Y3UAPDGfuw6FPK+XkzQwaZzGTU1HYc6Q7OWK2NeCtw9Ofv4FNCBGubx
 9vEfncFIdFRAPRvRrGqZnkhk2D6UiITQ0Ve7s6gQLvyg9iicFGw3gw1
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
	TAGGED_FROM(0.00)[bounces-5746-lists,linux-edac=lfdr.de];
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
X-Rspamd-Queue-Id: 59F5817D83F
X-Rspamd-Action: no action

These structures are never modified, mark them read-only.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/edac/edac_device_sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 1e79f36a91fa..754d44827942 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -109,14 +109,14 @@ struct ctl_info_attribute {
 };
 
 #define to_ctl_info(k) container_of(k, struct edac_device_ctl_info, kobj)
-#define to_ctl_info_attr(a) container_of(a,struct ctl_info_attribute,attr)
+#define to_ctl_info_attr(a) container_of_const(a, struct ctl_info_attribute, attr)
 
 /* Function to 'show' fields from the edac_dev 'ctl_info' structure */
 static ssize_t edac_dev_ctl_info_show(struct kobject *kobj,
 				struct attribute *attr, char *buffer)
 {
 	struct edac_device_ctl_info *edac_dev = to_ctl_info(kobj);
-	struct ctl_info_attribute *ctl_info_attr = to_ctl_info_attr(attr);
+	const struct ctl_info_attribute *ctl_info_attr = to_ctl_info_attr(attr);
 
 	if (ctl_info_attr->show)
 		return ctl_info_attr->show(edac_dev, buffer);
@@ -129,7 +129,7 @@ static ssize_t edac_dev_ctl_info_store(struct kobject *kobj,
 				const char *buffer, size_t count)
 {
 	struct edac_device_ctl_info *edac_dev = to_ctl_info(kobj);
-	struct ctl_info_attribute *ctl_info_attr = to_ctl_info_attr(attr);
+	const struct ctl_info_attribute *ctl_info_attr = to_ctl_info_attr(attr);
 
 	if (ctl_info_attr->store)
 		return ctl_info_attr->store(edac_dev, buffer, count);
@@ -143,7 +143,7 @@ static const struct sysfs_ops device_ctl_info_ops = {
 };
 
 #define CTL_INFO_ATTR(_name,_mode,_show,_store)        \
-static struct ctl_info_attribute attr_ctl_info_##_name = {      \
+static const struct ctl_info_attribute attr_ctl_info_##_name = {      \
 	.attr = {.name = __stringify(_name), .mode = _mode },   \
 	.show   = _show,                                        \
 	.store  = _store,                                       \
@@ -161,7 +161,7 @@ CTL_INFO_ATTR(poll_msec, S_IRUGO | S_IWUSR,
 	edac_device_ctl_poll_msec_show, edac_device_ctl_poll_msec_store);
 
 /* Base Attributes of the EDAC_DEVICE ECC object */
-static struct attribute *device_ctrl_attrs[] = {
+static const struct attribute *const device_ctrl_attrs[] = {
 	&attr_ctl_info_panic_on_ue.attr,
 	&attr_ctl_info_log_ue.attr,
 	&attr_ctl_info_log_ce.attr,

-- 
2.53.0


