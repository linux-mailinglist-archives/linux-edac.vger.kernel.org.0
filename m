Return-Path: <linux-edac+bounces-5740-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKquARPEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5740-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:11 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED117D7A2
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CFF308AFF0
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019D378802;
	Mon, 23 Feb 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dlzgQp3R"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDC305E10;
	Mon, 23 Feb 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881429; cv=none; b=g71vYFteuYHDYSsH7NEkRHc2O3lPUgsdl95824gMAVD5OEFeO2hpWvtI9lGPrZYYPhKYGOTm3ptq7L6XMvFIWWXen8BpA+rGFAWbXwGeRYczG21U/3rI+b8w8EbhL6wQP7neG4WS04Ewkh2hUcsJ2WlAp7kGdYKGuSo1GX4WWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881429; c=relaxed/simple;
	bh=d66Pu061jZ1MLr2Gb+zXKHBMduZKmte9jKmRSaqae1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Og7TfcopM0IdarGHn7/q7p2az+tp+GSvex3kCQ9M8CW2cc3HsWA+z1Ke3d7e8o8hD0mqywur8p7SDiD3neIIzTERBEKUCFr+H13EH0kjjUk8CjW2d80qL7yklJlULQ6DNAHJX9axeBW546E2Szpg0HxFV2tHokmw/VVV3++0seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dlzgQp3R; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881425;
	bh=d66Pu061jZ1MLr2Gb+zXKHBMduZKmte9jKmRSaqae1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dlzgQp3RtOAzp6RgVW4rW+arEuoiwcg3vVnOncE3GJGmZqNU13yDkCK+sVfHOimD2
	 7izHzhokWWHAhkQoSb2rHHOL8cIL091cEyx/QdLJLHRg2Pw3qpKBgzGsk4Tm+ctrQr
	 DovN+1z5KCNXsJTyK4AzBf4KnvoPSvPdJIfPAHYw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Feb 2026 22:16:28 +0100
Subject: [PATCH 1/7] EDAC/altera: Drop unused field eccmgr_sysfs_attr
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-sysfs-const-edac-v1-1-3ff0b87249e7@weissschuh.net>
References: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
In-Reply-To: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=605;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=d66Pu061jZ1MLr2Gb+zXKHBMduZKmte9jKmRSaqae1U=;
 b=DBZ7U1VFetZcQzGtky0xiQ1oDPrfLW0BI6HF4VZxLZ4Z+DkMZgYYdyeFArTn+/g4m3jFT1hFw
 YolaKdr1LCvATXiRrnkc7BVFLVdhR/audua7bCUMt9rDpAsRY0EW4do
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
	TAGGED_FROM(0.00)[bounces-5740-lists,linux-edac=lfdr.de];
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
X-Rspamd-Queue-Id: 5FED117D7A2
X-Rspamd-Action: no action

This field is unused, drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/edac/altera_edac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 7248d24c4908..f3e84172caa9 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -172,7 +172,6 @@ struct altr_sdram_prv_data {
 	int ecc_irq_clr_mask;
 	int ecc_cnt_rst_offset;
 	int ecc_cnt_rst_mask;
-	struct edac_dev_sysfs_attribute *eccmgr_sysfs_attr;
 	int ecc_enable_mask;
 	int ce_set_mask;
 	int ue_set_mask;

-- 
2.53.0


