Return-Path: <linux-edac+bounces-4042-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8822AC80EA
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6393A80DE
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE022D4D0;
	Thu, 29 May 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGQbDOlV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E118BBAE;
	Thu, 29 May 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536285; cv=none; b=VHId0pIFWS4eRE1SP/Vnyf08tNOmSNMMFpYWtfcYiF6ljlz8iw1JrA1tbf9l4hqKEYZ14YVpdiurAk8J2JC0/1hCM248iCVMsAdta7WwBDjdAksRPDTbxaNt5k3DO9Gyn0ZCJ9HioV7XVeQfunHJb5+FmGubgnZ/SwaEkGLMY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536285; c=relaxed/simple;
	bh=pVqOptwVIEJrB92m9v9hCrnXgBCkGjD6FuJ/yT5Xq3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qe40TZnpbC7ZFWLZU1gFKr/SfYk4suSkTjzrVBw3PR3aXR6UlRB0CNGZae1IYW5/cW+oj/Uthwk/Tc4aBhNZOUGpXQuNTbL35u08KNojsaYhUItjkAcobpPyyE3UPve5Ve8q5XX7GkLcMr5VK9rckwQcrJ/+jkVRIc1pXWU+cJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGQbDOlV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fab467aad1so14334276d6.0;
        Thu, 29 May 2025 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536282; x=1749141082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XA2Ki9NRYNHOZRbWGGjsZITQGLDBsTPRYqVMiX4q2U8=;
        b=iGQbDOlV0tD2u55QsyRSgVuhLS+iC9WiPxsJmFZqUwIFPkwyBK7gQ0sPz1cya8CpBw
         SmdCUH3FCBEH4iIHZY+ngC05QsNUS375YENxMUDX4vc0+zRxqN5nKF+GgOOBuIPzN8hv
         Wq+1yC/eWMxAj3gPo8bXK8ybeKjdUgbZtYv7slL8xeYjB4NfbYHz1DWX45zijeT6HEEV
         eFrZO2yDOo4ETVjPWaJbpl5u4705A/I5eiJdUJQX/eAQX/04oMacPnTqyW1YRgNoFD25
         rPFaWwxwR9ECJxeagdkoIm4EO05zc8KbrnjKohtvdVkJwEQ+FrxOg++48vTs+YjuWY5L
         AAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536282; x=1749141082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA2Ki9NRYNHOZRbWGGjsZITQGLDBsTPRYqVMiX4q2U8=;
        b=VvbkAcXlXobknReWwA7CZtSQTu3cW05jDf5T1JBBTWR0C/hnfVE3rB+oy2hzqqJUgM
         IzSfbYBtoM0jpLO6iDqIx3dD6ZHQB9w4Wr8+Oa/VqN3ob8HJJkOebmaXddy6NeKytv/t
         DE+b9jiJlZiuUuhIxWhuLNaPSSglr0QbexNwCNCe4Ltj828lo9G5Z0Bs3TOnsn2wjKbm
         BsmV967pC9M8JSObmHx6ta8nRhR/XZd9VZ8f36tjwyOYuWY0wQIZ0+AYhJA46fGJTWhb
         3d+zlCtZzlyDerdwm5Onin3Rcknvp+ZplfSzyT9GV4APYwoPVOieDZ04vtwfNDFGZnuc
         NU1A==
X-Forwarded-Encrypted: i=1; AJvYcCW19cJoqPB60qESBi+EIrXde9TLK8p/T+OQZsnDS1JEu9/eKl7Z12+n/RTm+Spjw8aJr2O2mR4ORHr4un0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjTBmYuK/mvc8858yH+HxjsMaLXv78xLVIXGVcyt9dL2kDoX2
	999qLoEm8H9o6Q1kMvYwlxzIeKOpngs9mAnOCUgHhz9e0jqtYsKwp92Q
X-Gm-Gg: ASbGncuNTVsBiRrHm9ttGg1af+TgabpWzzbPMb+/588jb936KAEMWHo2muFAQPXyVAg
	v7AVDWgToKR8OuAWcpgoB4AMfcoZueYhShs74OvwPEQK02utI65xDriMWYz8/NLZUi1aS/q6SB/
	+NEGGyRdsmYbHZABPVwvz+6A1LGx1GZ2MywARanNq7g45VmV5a/DsP9BUkRkpAJCB/ux9qZ4YvM
	XLBNLz+Gy64HNwreHQaTKn9/KmR2dzKSSxIai0N2UZjmPA9mge7WwHz6Go52+vXvFPOcaeac//C
	Y2Ozr5q0uckLrOfmq4DrF9vo/eaur9UuSFjhOocMNvvwQF/vDNmeySfbuJhHrkvPdmBt+cEnnx6
	Udc0n+OozxfZSmzi9/Mids18B1I+3rMqlGw==
X-Google-Smtp-Source: AGHT+IELrKuH125RVe0G9dhfVARHB67I7OzPzNqYHidj/ThpZw419CnUlH3nBo2z1t7Fzj8aFjPZlg==
X-Received: by 2002:ad4:5c62:0:b0:6f8:997d:fc84 with SMTP id 6a1803df08f44-6faceb8b472mr5275666d6.19.1748536282479;
        Thu, 29 May 2025 09:31:22 -0700 (PDT)
Received: from localhost.localdomain (static-198-44-159-42.cust.tzulo.com. [198.44.159.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b3e7sm11208276d6.61.2025.05.29.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:31:22 -0700 (PDT)
Sender: George Gaidarov <gdgaidarov@gmail.com>
From: George Gaidarov <gdgaidarov+lkml@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	James Morse <james.morse@arm.com>,
	Robert Richter <rric@kernel.org>,
	George Gaidarov <gdgaidarov+lkml@gmail.com>
Subject: [PATCH 1/2] EDAC/ie31200: Enable support for Core i5-14600 and i7-14700
Date: Thu, 29 May 2025 16:29:32 +0000
Message-ID: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device ID '0xa740' is shared by i7-14700, i7-14700K, and i7-14700T.
Device ID '0xa704' is shared by i5-14600, i5-14600K, and i5-14600T.

Tested locally on my i7-14700K.

Signed-off-by: George Gaidarov <gdgaidarov+lkml@gmail.com>
---
 drivers/edac/ie31200_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 55cf54741aa0..1812ebd19ece 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -90,6 +90,8 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2	0x4640
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3	0x4630
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4	0xa700
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5	0xa740
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6	0xa704
 
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
@@ -739,6 +741,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ 0, } /* 0 terminated list. */
 };

base-commit: ea3b0b7f541b9511abe2b89547c95458804f38e2
-- 
2.49.0


