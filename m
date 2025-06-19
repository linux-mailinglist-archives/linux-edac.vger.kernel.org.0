Return-Path: <linux-edac+bounces-4188-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A59AE0E90
	for <lists+linux-edac@lfdr.de>; Thu, 19 Jun 2025 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F97188BE56
	for <lists+linux-edac@lfdr.de>; Thu, 19 Jun 2025 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164224729D;
	Thu, 19 Jun 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6gszazx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47626209F2E;
	Thu, 19 Jun 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364605; cv=none; b=incoWNd5zt/TI1zglyNyatIE95volFpej+t8olVZboe4zHIKLeAqWZHxpytFubxbC93JWbI9xcQguQuzaLuPmloIudN+kHKYd1btlNWRHd+y7rTjUO9M8/Or0x890Djo8lHWsQiygFEF9Y319uD/PEKqus3JZ5vYGIBgckUhhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364605; c=relaxed/simple;
	bh=6Z+Lr29kl/c7pwUb6n7LMj+IZOon/O/gvj2xYKSCLVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gRb193HGnXO+rYF2TnfaKiYcaIpZUPlUzL6Wepa4U9+bQoKyv7IkWWJaSV7yGcN5FfHtkpuirFXU/XUXrLckus3eStDnRVEAdEhB+CKkTeyjOuJZRDmEWzOFP4LBuP/Y+Ylb1hv/nGj4eAy799SGrTySUwgns2QLFMuTS7e+Hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6gszazx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2353a2bc210so10149625ad.2;
        Thu, 19 Jun 2025 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750364603; x=1750969403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrYGJsuypre3Z7nW8DXdS5477XT5Cbwa9Q2vGlevBAI=;
        b=G6gszazxCA2FtijZ8gx0aV2acpV9SPWpYotDfYlgc7GEggrDFdcbW51QPVAm3KduGQ
         krMIxnDjvu7OcYtPEGubjcekM5H3Q9hibBS9Ws/zJCNs+qkjy8svXWA6028gV26DKRDa
         9Qgebo0RsFK1rwNx19XQBvSju1a7naV/QScT8GLJ5isbToMnhgvFEEy1gCyQmbadaGfE
         puowqAso2Biy/FTM5APRsRBIy29yPkT++qcY0tFidxWWVT3Dt27aE7F8RC08QsUR7HAj
         P5ZqqMwytzQ5tCfIlh3zZOnXRuWBN3xlCbq8QbFUjVuTo1lt7AvGCmeoBcmtl96Ma6eS
         YRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750364603; x=1750969403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrYGJsuypre3Z7nW8DXdS5477XT5Cbwa9Q2vGlevBAI=;
        b=FJ/r8Z6ajkCiNmRVDmLo83vy9k4RnXKDQEa3Sts/IDna6UDyNLYJu3Hp+Mx/WPi8gK
         rQUkRDSqdGqZOtI7R9EkvQ2WBCNs71zQHW5wByDGHxp9E9KAGxbkEjv7K8WpwdycipF/
         D5XWhXhNn7HULZc1XDjQywFgnDf4UxHrdZR8iCfDz7NcmT0izJEDW3N4hC7C8PNVXWDK
         OXLFt3gRHd23I93u/kvars/ae1Dkoi2sdCiG3brMLChwgdsT6ncKOVH/c9g7PXjxelpL
         zmFCyB0C+k5BVWbhGcpttGk6R5lliWycbq2hKVpBhGyjVwDiiOKd3Wv+LQAlraJVWY0v
         D40Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpNQ/Ccj1ftQbdWjaOupevG68SHyOW7CiwgkG997i7LBuTpskgt/G6XdEWXKIIbWiElcwo4RFdFTKmm2Um@vger.kernel.org, AJvYcCXON62youYUZYUBZCcAhszj57X94TLNcBkN8ENa2lVG19nf+GFRdK5uSgdyOEK1/4J5Dwxg6KoERCpb@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDWbGK8Chaml2CxczbyMmo4YpGOETj7AiMoMi8B51TyGWxY29
	Mkq9Fy0yOqxTOSiXayW5xFCkKUw004yyXuGiehtjKPda1sGOZqpxxTTM
X-Gm-Gg: ASbGnct+xIWEjspouTNwJku551CfZZ4SBYZNwiUnoE6ubbdX8PZ6DGCLpZeFeVHxwjK
	+3mt9fRpq720XrbUzPauTtzhFlz1o2LLyiUsCe76QKbzFiLGNJHp+dwV3p7zfHMjF5C868MKpfp
	EDsApFZy9eH8m95mmj2bEzccvQXMTPvzAV2+RqHGwKSJHlqquXvMnKbqNkeAWAT/9052M8rYx1r
	Etfn1h3qr+J9JinWu5SJ2frrypNT9znwOi6L6vKrkHt5Jp2eimp/GhmaGMC0NKVVjC+6HjROMzI
	HC1Krc4/ElB1SGFRleDf8JMhCo2RyzcmNqCNzfv9dComQlWADRy6xIkNz24KSfE4
X-Google-Smtp-Source: AGHT+IF1p7zbV+G1dyNemKIN5cDcN6DcrHIA3F6fwW3tefaouBCLINGO5gYdhSlmsd+cyBKasTynuQ==
X-Received: by 2002:a17:902:e752:b0:237:cadf:9aac with SMTP id d9443c01a7336-237d98e2a87mr2436615ad.29.1750364603511;
        Thu, 19 Jun 2025 13:23:23 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c94:78d8:2e45:4d78:9feb:bce6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226f64sm2707659a91.4.2025.06.19.13.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 13:23:23 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: bp@alien8.de
Cc: tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH] edac: Use sysfs_emit_at() in dimmdev_location_show()
Date: Fri, 20 Jun 2025 01:51:34 +0530
Message-Id: <20250619202133.11843-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the use of scnprintf() with sysfs_emit_at() in
dimmdev_location_show() to format the output into the sysfs buffer.

This change improves clarity and ensures proper bounds checking in
line with the preferred sysfs_emit() API usage for sysfs 'show'
functions. The PAGE_SIZE check is now handled internally by the helper.

No functional change intended.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---
 drivers/edac/edac_mc_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0f338adf7d93..1b611650de3f 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -500,7 +500,7 @@ static ssize_t dimmdev_location_show(struct device *dev,
 	ssize_t count;
 
 	count = edac_dimm_info_location(dimm, data, PAGE_SIZE);
-	count += scnprintf(data + count, PAGE_SIZE - count, "\n");
+	count += sysfs_emit_at(data, count, "\n");
 
 	return count;
 }
-- 
2.34.1


