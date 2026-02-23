Return-Path: <linux-edac+bounces-5744-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBdHN0DEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5744-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:56 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 884EE17D7ED
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D992530D06A8
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E99378D7F;
	Mon, 23 Feb 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DRCQ1x3T"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8A377576;
	Mon, 23 Feb 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881429; cv=none; b=FsRvg5o8fFm4J1EpUGu6XRWbeFXdGTCax+C7bavdV/VhfnYTXd9ZTlIzd+Ys5g9N4SjKWiMB1NvkzB0JoOs0fjg1km3dl7w0uyauoEfMXeOI8hBG0McNHnOr4sIAxpKxowmyUfm6g19cL4Fffn5P7TrCtUaqFKsBFSQqrCQzzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881429; c=relaxed/simple;
	bh=yr4qx6td7d1BPQGTgBRZZYWFHwmZENKtcBXJTDjjkMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFrlapedk7h3X3Zdihx0M9u2bqosvykFmKQFISm8l+UPHuXQqRP1usOoPI5ZLgsqdDAXk8uNkLk/LavubF8y+H8E5XOWtUtxReVNw2txsGhVGaidYlmZmbZaTcF0s+U3IUNe2mNywHvyfSi98urOqXERDhrfpxYWJszOi99j+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DRCQ1x3T; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881426;
	bh=yr4qx6td7d1BPQGTgBRZZYWFHwmZENKtcBXJTDjjkMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DRCQ1x3TflgLNTT4Xmgc+EtJGcROSGzMfsbzmgbOqA2DRZsNLE1unyuX78+Uoc5SE
	 JsP3GpxuNrXc3tj0HqVzrs/MLfkUJ0smi5gyKfB6BNOfoR5ZHf1hLp15y3MrCLqds5
	 WzqkzSR6KcgNk/qRv0BiAtV5y7/7RbUxtt0IicVo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Feb 2026 22:16:32 +0100
Subject: [PATCH 5/7] EDAC/pci_sysfs: Constify instance sysfs attributes
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-sysfs-const-edac-v1-5-3ff0b87249e7@weissschuh.net>
References: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
In-Reply-To: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=2447;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yr4qx6td7d1BPQGTgBRZZYWFHwmZENKtcBXJTDjjkMk=;
 b=KBpyO/8Iz8Q1+FIKuKHdJ7IeJjsT6bL/zu7H1XazunZN1vOx6B9tczC1p3+yMdXIZSSmfRVl/
 o+z/BeiYaaoDs8NQy4asJEEQbkCUgiNwDaic6GiEiR4akNwhhGgKcwo
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
	TAGGED_FROM(0.00)[bounces-5744-lists,linux-edac=lfdr.de];
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
X-Rspamd-Queue-Id: 884EE17D7ED
X-Rspamd-Action: no action

These structures are never modified, mark them read-only.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/edac/edac_pci_sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 446fef0a9399..9f437f648e4e 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -68,7 +68,7 @@ static ssize_t instance_npe_count_show(struct edac_pci_ctl_info *pci,
 }
 
 #define to_instance(k) container_of(k, struct edac_pci_ctl_info, kobj)
-#define to_instance_attr(a) container_of(a, struct instance_attribute, attr)
+#define to_instance_attr(a) container_of_const(a, struct instance_attribute, attr)
 
 /* DEVICE instance kobject release() function */
 static void edac_pci_instance_release(struct kobject *kobj)
@@ -98,7 +98,7 @@ static ssize_t edac_pci_instance_show(struct kobject *kobj,
 				struct attribute *attr, char *buffer)
 {
 	struct edac_pci_ctl_info *pci = to_instance(kobj);
-	struct instance_attribute *instance_attr = to_instance_attr(attr);
+	const struct instance_attribute *instance_attr = to_instance_attr(attr);
 
 	if (instance_attr->show)
 		return instance_attr->show(pci, buffer);
@@ -111,7 +111,7 @@ static ssize_t edac_pci_instance_store(struct kobject *kobj,
 				const char *buffer, size_t count)
 {
 	struct edac_pci_ctl_info *pci = to_instance(kobj);
-	struct instance_attribute *instance_attr = to_instance_attr(attr);
+	const struct instance_attribute *instance_attr = to_instance_attr(attr);
 
 	if (instance_attr->store)
 		return instance_attr->store(pci, buffer, count);
@@ -125,7 +125,7 @@ static const struct sysfs_ops pci_instance_ops = {
 };
 
 #define INSTANCE_ATTR(_name, _mode, _show, _store)	\
-static struct instance_attribute attr_instance_##_name = {	\
+static const struct instance_attribute attr_instance_##_name = {	\
 	.attr	= {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,					\
 	.store	= _store,					\
@@ -135,7 +135,7 @@ INSTANCE_ATTR(pe_count, S_IRUGO, instance_pe_count_show, NULL);
 INSTANCE_ATTR(npe_count, S_IRUGO, instance_npe_count_show, NULL);
 
 /* pci instance attributes */
-static struct attribute *pci_instance_attrs[] = {
+static const struct attribute *const pci_instance_attrs[] = {
 	&attr_instance_pe_count.attr,
 	&attr_instance_npe_count.attr,
 	NULL

-- 
2.53.0


