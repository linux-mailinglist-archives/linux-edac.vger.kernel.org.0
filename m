Return-Path: <linux-edac+bounces-4464-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6632B158FB
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 08:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B6F3AA561
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62F1D7E54;
	Wed, 30 Jul 2025 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAOsoTtC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DA2629D;
	Wed, 30 Jul 2025 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857120; cv=none; b=M0K2nchhZFbLlOtSkmC3T+v/rWypYmdPSGGZ0viJV3V5hyim/DFEEsa5nrufNlHb/CjX291uBzPNqykiuX8edKE3mjL0qH2Q0V9TMpT2y9XTRR93OPEhsda1ohS/hFTT+wjjR57ZU6KWHCiTN5s1igBghXXmcBztSE9/qLRBlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857120; c=relaxed/simple;
	bh=kxv5Gy1KyXxspx2uODeZUwYo5EVFmhwTBib9zYEQBIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RBe/HeRZgYulUiPTJbLrl5kWyiM0qbkv9hRK0+G6jH5QXXC+0FTip84K+skvQHg6zrQj/fuI87JrklHmkYahaSv+42tqqKlK2EVyRA3/+2J8bMVemslgfSn5i80rO8JPwxhjU454e7R8L9kagv58uSj13KdngctvNHzMtuqhJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAOsoTtC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so1474132b3a.0;
        Tue, 29 Jul 2025 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753857118; x=1754461918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uB3+SIO6qA8oyFlUumi5OJO3sZoV3HuBnZCYSn8E4dg=;
        b=bAOsoTtCv0tDEOL3vAQdoPteoY4vVfvrt25pytGoqWV4edB4Lax/jVhUrwyXXReRoI
         7JdxJA39DYSSSEzTKlIEZHd9Kv+TIIxsr0hNZskgMUKNflzLKFTjh12NN5qV8D7WQsIf
         xH6AcJVebmZZ8YZhBHx4+QKZgBVmtxRKSpibp2EApSQ8QHcWnmE9+SeU5MMp1sHEmnbg
         BraVT+unNmwIX45aevWDnMCwtBxEkyIYsBykFCkbVmjiFiPS4ZLk4eJ7QfEiBj22sVg7
         MFbjOhpr+O035OntpXi5eXoDyidSGdKyvVuA6G3D14jfZOsWDEgaGCpP170QEi/cVPjb
         r4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753857118; x=1754461918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB3+SIO6qA8oyFlUumi5OJO3sZoV3HuBnZCYSn8E4dg=;
        b=ZpbgFyVjo9XSWLtdrU9TecG8d/o80AQjhJoKf+TFD7AQuY+BO3fOsHfuZbfbWv5XZP
         cackxYOQhdGCqCi1mDzv9LS7TK+REOHIhz24EGmASqkF3FNbMWe4bFb7IWfxAkJBVLzy
         QoHrcxE9vvpNbCisgm8Qbj4wQwIgY1A2knkfKHaKfdemWKVStjl9oGKK2V2FGznVPbUJ
         7E4N7jAtLHlSf3DCaP7A0N4HmKyCPmv65zuyb+w5MlFTaPRpF6VPrZRHOx64aZlxsN1R
         OQT7kF68K0OciU/fXLxYOsrg6Xj5Gm6K3H76u/PlodD32QiMVD/V7kAHYBMeE3i9B+Rt
         681g==
X-Forwarded-Encrypted: i=1; AJvYcCUS/+BciN+3WOJQ1tHeGHVHSK5cv3st7vqhiOdhzDNU42Tayc2XEXYWo+07UL/aPhxhfatQb39nsz1x@vger.kernel.org, AJvYcCV1f0sXtN4GqPof/dPCiCt3pORtncUEjsJkpyK++K8kpgzh5i/4jDmJZtym1TNAYlJyjO6C1kkrI+IS8/6k@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMbBoj6LzYouVsYG95/mc6hZT9bWf8VzOLXT5/t+mrHgDYrde
	wyQ1I+TzPiFoQLhTK/yva/GWRAx6ciRZ9hwMT13DyZcn+8HOVY7JzE6H
X-Gm-Gg: ASbGncuerjnHJJubnG3acFhooQF5zWT9LxftES1VpoZKMDMSXxfSHVfpnw8CbAEraDr
	CoAqZxT34dHlyxD/mrCjoECMTh7Z76BR/lqmYwfv8v7UMRnOy78Fju1mg3Z1vVTXrq1vQss7DYC
	ILpK7Rf1ZN4RtEzzuU1DvkvLW2oWecFCBTwLw5K/ymc9kdPYmARIwSv3QWkOc3brdckUJaZpvr7
	1m4tuD7v6G1ewachT8ATbwZepprNq61025NvAoWyvpJo7rtNtMDLmrh2YZCqkWjco9WsVFlvO7T
	LCSTaS5sJA0AbE1tLgqjFOZRqrT4dv8vWkVfMQA8RQN41ol1tanKTJc+isqXYlBLYuYdwL13j2L
	EAWKrBhfQooc1/krfyqKzKyUvWySvuKit/ui63ZOVze4Hy+mMaLE=
X-Google-Smtp-Source: AGHT+IGNwnBA8YEqF5nvJyPxatvrwOdfNKJextLwZZjLL+IVGB134VLwbcX2uDhp9LYJQqI+fR2hjg==
X-Received: by 2002:a05:6a00:1d9a:b0:748:fcfa:8bd5 with SMTP id d2e1a72fcca58-76ab1021910mr3523688b3a.3.1753857118212;
        Tue, 29 Jul 2025 23:31:58 -0700 (PDT)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408feb6casm9687396b3a.59.2025.07.29.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:31:57 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM size calculation
Date: Wed, 30 Jul 2025 14:31:55 +0800
Message-ID: <20250730063155.2612379-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skx_get_dimm_attr() function can return a negative error code,
which is then assigned to 'ranks', 'rows', or 'cols'.

[    9.344702] EDAC DEBUG: skx_get_dimm_attr: bad ranks = 3 (raw=0xffffffff)
[    9.344703] EDAC DEBUG: skx_get_dimm_attr: bad rows = 7 (raw=0xffffffff)
[    9.344703] EDAC DEBUG: skx_get_dimm_attr: bad cols = 3 (raw=0xffffffff)
[    9.344704] ------------[ cut here ]------------
[    9.344705] UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:453:2
[    9.344707] shift exponent -66 is negative

The 3 values, rows, cols, and ranks are all -EINVAL(-22), so this line
   (1ull << (rows + cols + ranks)
would become
   (1ull << ((-22) + (-22) + (-22))
Which leads to shift exponent -66 error

Add a check to ensure that 'ranks', 'rows', and 'cols' are not
negative before they are used in the size calculation. This prevents
the use of invalid values.

Fixes: 88a242c98740 ("EDAC, skx_common: Separate common code out from skx_edac")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/edac/skx_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 39c733dbc5b9..36dd14320d70 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -436,6 +436,9 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	rows = numrow(mtr);
 	cols = imc->hbm_mc ? 6 : numcol(mtr);
 
+	if (ranks < 0 || rows < 0 || cols < 0)
+		return 0;
+
 	if (imc->hbm_mc) {
 		banks = 32;
 		mtype = MEM_HBM2;
-- 
2.43.0


