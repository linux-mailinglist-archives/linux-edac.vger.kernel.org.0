Return-Path: <linux-edac+bounces-1051-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB598C3A7A
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 05:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD31028127B
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 03:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A404145B30;
	Mon, 13 May 2024 03:29:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EFAE1145A11;
	Mon, 13 May 2024 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570969; cv=none; b=ZOtWabiQfC/rEkaNicVApHFk7GtCRFCenc1NjabquBxhP6diz06IFPSj9A2HKNkCeH4m+isHqcthabVLIVcqdEfIhmL3Gq43hW8Y8Il0uSNpvNikU8uzLfV7gH7BVXzNAtmny0K/EWgjZitcPvGlSpAvCRwBrigBgdmndBv7fZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570969; c=relaxed/simple;
	bh=tkh8eCP0pbd39xurVRNii2rqP0hk0zpbzdUfZw4bnTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t2VsBvyMV4thKEEBu08H0R+bNq+xNqnX5AD8I2kADPw7PHD4GR8jM/bhOrX6A7cZJ3op9DAEbVMQG6ew7xXA1kZg0/PQMIEpQGFEvnWKMIpcJ3OhY7SOv4FQ6DGwiLL1UyGb2lfF9P/rgDZXrb490LAatYeGS3Vz8y5g1aIGBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 8E9B56046A8C1;
	Mon, 13 May 2024 11:28:45 +0800 (CST)
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
Subject: [PATCH] ACPI: video: Add force_vendor quirk for Lenovo X1 Carbon.
Date: Mon, 13 May 2024 11:28:31 +0800
Message-Id: <20240513032831.7983-1-dengxiang@nfschina.com>
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


