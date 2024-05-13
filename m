Return-Path: <linux-edac+bounces-1052-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786D48C3A81
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 05:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3301C20837
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6F145B38;
	Mon, 13 May 2024 03:38:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A3E4542A86;
	Mon, 13 May 2024 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715571534; cv=none; b=NX82lTzI7MBajK6ie09aw300JVr3AC3UaWDffDyRbh0GC8POdG6yf/pNMTgjXb3Oct9vddKZHNJQGwQPEtm1Cbx8mVFNRR8z4f8yIz+CwwGFvMkOpX6f4EBljhBmwCeE4OF4HXDRPZrxACOZZ+XYAuT/7mOokpe6lgYzt7T5yKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715571534; c=relaxed/simple;
	bh=tkh8eCP0pbd39xurVRNii2rqP0hk0zpbzdUfZw4bnTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6Ghsm/7jOlqabeglz8VxyWDg4KcNw6btIFXNCZw28I12l/9d/Q60nhZpiHMjhsrxaoVQOHsHQRqvylUt2wK79oTYK821rObEVRa5ZYypYqvMxTltvu48BlEygMkNVyOYyrZow2bMiFhO8q/KIQFvB7QeGuUIAGxvsR1McPVcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 13F916046A8C1;
	Mon, 13 May 2024 11:38:47 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: dengxiang <dengxiang@nfschina.com>
To: lenb@kernel.org,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	wanghuiqiang@huawei.com,
	prime.zeng@hisilicon.com,
	tony.luck@intel.com
Cc: dengxiang <dengxiang@nfschina.com>
Subject: [PATCH] ACPI: video: Use vendor backlight on Lenovo X1 Carbon.
Date: Mon, 13 May 2024 11:38:34 +0800
Message-Id: <20240513033834.9174-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo X1 Carbon advertises both native and vendor backlight
control interfaces.But Linux defaults to picking the native ACPI
video backlight interface, which will make that the vendor
zx_backlight interface to not work.

Add a DMI quirk to force use of the vendor interface.

Signed-off-by: dengxiang <dengxiang@nfschina.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2cc3821b2b16..e647186b4e83 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -875,6 +875,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Lenovo X1 Carbon */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "KaiTian"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "KaiTian X1 G1d"),
+		},
+	},
 	{ },
 };
 
-- 
2.30.2


