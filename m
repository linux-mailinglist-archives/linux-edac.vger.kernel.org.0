Return-Path: <linux-edac+bounces-5449-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F48C61C0A
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53F93B18F6
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32223B638;
	Sun, 16 Nov 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAzXvS3S"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386861FFE
	for <linux-edac@vger.kernel.org>; Sun, 16 Nov 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763323179; cv=none; b=tocGX4H49LTl36GECILxoGF6wJ8IWwj2pGFDdQRcZu30XJCI4pmnZq5t/zrAbCo46i39dvlcCUFYcn5QXr2Rxaz1oSBXmHcQ12NcgEhmn+eAuV6sMUZbgoIMClXGBcD6lW0y3gtTQotDXEkm0GwW3ItfumbXN2gVCNBQGwr+rhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763323179; c=relaxed/simple;
	bh=zYlzZRH4jYO7iqyS55q2todvTyMRJzBUxyCqJYQL7W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEfiYgMenyq7l7S5VLiHGzdYqFDjEZpkA84FddqM3uE5SgqpmlI+Yh5m3jbSCd3mHUCsZNNAGBczFNbP0fNSwcd43gj7SQ1/XLm69PNQzWUL3vfq3WDW805E64vjmkJPRNbCsO5Hd4vZ0EWHxfRjsm1LJqj47UK/l/0gQrQD0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAzXvS3S; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3438231df5fso4295108a91.2
        for <linux-edac@vger.kernel.org>; Sun, 16 Nov 2025 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763323177; x=1763927977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4suhYP/UOmc6/kF+t3dbtFt9P+PrNVGMoEivY7lTST0=;
        b=mAzXvS3SJU6rzE0XX/rQkqJjxis9OFAz+xgfyop9O0iLPnFTgzpMUDczo0vEd1C2mU
         2TyegqgritghzKgs3uhiYpgSXt5lckdsgxXepSdviIJgW4x26Wq04CwfVDX3yCyTbQOK
         gxqSzUPaQ5g/YbWmNw0Yb/Gv6q5hQgJLPoMLwzIcUoWKW0Uf+SnLWl6VwobbEk0c/Z8l
         dRfpI/fYZ8tm5D6ZecmbwLsVIoo+d1W2o2DOqOwlc+SxA+7RPNAbbpb/3xEHepO9j2A8
         9iuaim7ubPZJo2qxo1GR1NR3U1FrC4IV5+/8fyyB4hfm2O2cBalG6Mo1lseBz9SGW9Qj
         w49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763323177; x=1763927977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4suhYP/UOmc6/kF+t3dbtFt9P+PrNVGMoEivY7lTST0=;
        b=dSB/pj3fAlWwRoRWIwxM+0KM0DH8LfQSuiIB5Y/GQa5y3mTxw/Vz9cm37vo89eQVfp
         lNHcGwBjwApsMWhBR7yvNAtYuENECUoyXz1DBbKVYaM5I30E5lbl4koNYTRq/SE0Q+Cp
         o8aRCEZQJiw7kDlhegZEEgIdDIrbXvPavNf7+84Np5qs4IrSrrpAbtELu3x4V212X4zw
         A62t2rXH/4gsuw1/BKd0+4/0o29Z+pF0aZguQGP/IF9Q0FyTdVQVFVj6wpzSUdNu32Ky
         1RhL3ca3jlRRGPEPlBl/VFZBpIXnunkwP0XjO7lkiN0EwLGOccRll0LIKOQwpG2F3vQ+
         WHXg==
X-Forwarded-Encrypted: i=1; AJvYcCVVR7aZIhuvi5iVUuG0NpIzJS1jFo1vuW1ZJ1JRb+t4hlqRutsqfb+Q5FdlPwi2rnTsgAi9d8MzAtSA@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNUQFYhct/fUEiajyQlzFqMXQkuyXHNRPxQE/Fm2/Hdm0405k
	4P4keJKawLjS1pF5A1GjLFtM2YaLdtLv/Pk2OWSwJ8goO34130e9Z6Bn
X-Gm-Gg: ASbGncuGS1H40DG17Ji4ISf4ReaTEnVgfoguQYZZkwfSj5a+rOHGSVP63JxMlZjbRKG
	ne6DQy6XYRlioXYABohWFYKKcx/UImam1Y2hlaeERIOptdaILnx7JnY1eS6u2ju56FaLx8Uuemj
	DNOJW1ExNbKz3LiLrkKe6RYPqbXahJZD80S2QrWfi+N87DXX41NcWHSOP9C1lDrKdK5yFWeWpzJ
	FM3ceKo6xuQx7XX+3mnY8jMYXsgEqwGKJjXHC1wtgBmjz7BucwW3s+6Fyo5uz9LbfRtOrqs3kbQ
	Ehuyvk3s5PhocWi7a8pEXHfH0/GQyMsB8y0its5Kcvyd0+bHZu5zuLtEyZcBdtzOj+OVGdjATCL
	gnwLpWqKeAUXe7AyhRgZOR9vppnD3LZhTqs7nkIDyFkuDKIrGZTj/Ox/v4AfV4w1p5rRUFjpNVC
	VcQYh2nhrhEJzqlAu+VPk/UUM5Z697HMT7sVor
X-Google-Smtp-Source: AGHT+IGSHNVUcGiFEJWlWDKNMeb3TekcTkHRR1n6JLfap01hyW0w1tq7l5pRMm8lF7zDpp/LSqOHMA==
X-Received: by 2002:a17:90b:58ef:b0:341:8c8b:b8e6 with SMTP id 98e67ed59e1d1-343f9ea65acmr12705192a91.16.1763323177020;
        Sun, 16 Nov 2025 11:59:37 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e0624f3csm15673907a91.0.2025.11.16.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 11:59:36 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: bp@alien8.de
Cc: shubhrajyoti.datta@amd.com,
	linux-edac@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH v2] edac: versalnet: Use kasprintf() to simplify string allocation.
Date: Mon, 17 Nov 2025 01:28:58 +0530
Message-ID: <20251116195858.18214-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116120243.GBaRm9YwFA1cMr5zGR@fat_crate.local>
References: <20251116120243.GBaRm9YwFA1cMr5zGR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the kmalloc() + sprintf() pattern with a single call
to kasprintf(). This is cleaner, simpler, and avoids potential
buffer overflows from the fixed-size 32-byte allocation.
Handle the potential NULL return from kasprintf().

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>

v2:
 - Add NULL check for kasprintf() as requested by reviewer.
---
 drivers/edac/versalnet_edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 1ded4c3f0213..69a9da8c58a3 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -812,8 +812,12 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
+		name = kasprintf(GFP_KERNEL, "versal-net-ddrmc5-edac-%d", i);
+		if (!name) {
+			kfree(dev);
+			return -ENOMEM;
+		}
+
 		dev->init_name = name;
 		rc = device_register(dev);
 		if (rc)
-- 
2.51.0


