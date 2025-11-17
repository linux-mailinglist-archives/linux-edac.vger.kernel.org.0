Return-Path: <linux-edac+bounces-5452-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52DC63BBA
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 03CAC2422C
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582133343D;
	Mon, 17 Nov 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmakFNkS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA60333427
	for <linux-edac@vger.kernel.org>; Mon, 17 Nov 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377401; cv=none; b=D1h4ZhFROnudD6Lkva3miyWRfyf4wH1md4xvHEzPeYooLUfdisY00sPc4ibsYVTZiaoR5XHvHwhrvogesmcjnzY3+Wzzcg3FlstPhnxylgtzBMq/8FbCrWX816jwn7w260d+YaMfScvoww8OdtkX4EcVo3Vak5r0LLTU2sfC6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377401; c=relaxed/simple;
	bh=v9eA8LLhVMmMuC5QHdSMbflTYhJjNvkbbiVRYbPUVso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2Ztnuj6uJ4dheCoH9ujI1QOBeqdRes6Jq+cQkjDCSwGTlRC8vO97y/PTkfpIhiOeMlFElRJyfjolMbeEm2IjVN9p9/8u+zw6ZZ13DXK/zT1qlo/vbOYWh2I7NJUbxu/t7/3gDfQxymx9QoU0axcftsctw4tlvwC6v+Cy7xA+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmakFNkS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so2564222b3a.0
        for <linux-edac@vger.kernel.org>; Mon, 17 Nov 2025 03:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763377399; x=1763982199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Krc4zJ9g9kGyigXxwDn6nMncaw+VK37JrL9qLp7VuA=;
        b=DmakFNkSLf0f9jHbZS6Ah4lu2cg2wWbYIPAd37fgyUsBXW2/gnDJPbzp+LqRTeKr+y
         beKo5wtZV4s2gVfPnaBBanOwCQh93z+XhTiR2nY2IBkeNa31+DxMzUvMq39n7+sEwBPJ
         DC7sTNwOPAAw2bM3AKox4DfzMh0fwLJRu7RKiuGha1X6rrtIUU434Csgh+NcyJO5nNDY
         +JTbX3G3KTeZCd+jlsZ1JLruRjRhhDbvqcsqOeiDEJoPbL+gY2iOXyDlh5KUYlL08IqR
         x/7xNlIU16YU078+3W0jQpQvi89Q4o5JkGk0C8FOB6F8d8tiVuKl2wOgk8yUx5d0xVWW
         sqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763377399; x=1763982199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Krc4zJ9g9kGyigXxwDn6nMncaw+VK37JrL9qLp7VuA=;
        b=JoAbHEyDUWJFGZp4/EmD+qbnBvOlzneO93xGcGQ8plzhuFcdP3d8jStIwmLDTHx4aH
         FybFHy8N926CiAQSbdeKT3C/VyNOlw5AQigCbES5acrtWLttgdwKR7TEFebKhTWH+/m9
         7t/Vi1zkgcRlq4mcYdzy4ILNhSkbyxpgg2X9MklYd2WGM67li8/t9A+Wt0/l2lrGa59r
         28HvxYYoAXwyxoB4P7ES/ECWFuBjveQgGGGjFh3sIW/o0GpQssTMg0ytsCPjGcxcB0Ha
         kz9bRqoYv97z2Io4oF0iSDUaa9gQoDXEAX1ShioOEnySae1iWPLeQkRQb4ngvxnBaOuW
         nDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ3luRhp6xGBrQDl2BgGN5CSKNs9LftLHD0OtDSTru3AQb7CAlp2v3IT/i7VUVxAuaarH+ZsfKZMR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5TSjE0yWYqn6jtxPaclNql8i4zKcnz60622bKIdLR/f7n28a
	/LJ4FtZxJ7ideWmP+e62m6Maahj6/1LOIP/QMlUcRknG6q+6hX5WEJZM
X-Gm-Gg: ASbGncsM1vC11V4DUdVjo9KQ0wp/aAnqG54tJKRnkslkbGPNelaoQz/ZN/2Cr/ibR+v
	kQtXE57pl6pN10O+v0gRdYaWK067BnRUh/pCN/4w+WeWR09e6+fMHYELUnuM7iBnhzYDbh1AL4o
	HozPfE7A7g3gzemnxt1Cz9+OM/npgcEW4JlW0Q/9lzhkvhr19ee5uXQGtfR2hrqe8PRSA4KQcpN
	qLyPkg3N/DVBvdNANzx2Z5f24Ye8LDQWDgnVtKzKLYuy7y9jbc+8a+m9mH7LRA67K68JF/UQ6U6
	ZG6MJvARG4TywVFfS+nz0yFvY4CWO/+XHGyCXLjkqtHfgy4L7kwWt5Q/AQkSkmq6O2w6BRtQGLP
	3307+TvgHXtTX6ggxyft+aRkTBtiY4RZeJCQvo6LvQY3OBJF2UsLgr8xDQlGY9kDb6JuCe4ro2u
	3LMDHvXrtw7ht+fRPIe8dEQ9lano9q6xMbN6OI
X-Google-Smtp-Source: AGHT+IHdE2uEL3J2fy//Gq2ZU9UOSCTcj9eKn2g5h9sx15grMRRxSWdS4TMZKuIi+fUQwutn6I61SQ==
X-Received: by 2002:a05:6a00:b51:b0:7b1:79be:1273 with SMTP id d2e1a72fcca58-7ba3c087d40mr14779187b3a.26.1763377398785;
        Mon, 17 Nov 2025 03:03:18 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9256b8824sm12915212b3a.31.2025.11.17.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 03:03:18 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: qiuxu.zhuo@intel.com
Cc: ayaanmirzabaig85@gmail.com,
	bp@alien8.de,
	linux-edac@vger.kernel.org,
	shubhrajyoti.datta@amd.com
Subject: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string allocation and fix error paths.
Date: Mon, 17 Nov 2025 16:32:20 +0530
Message-ID: <20251117110219.35852-2-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SA1PR11MB71307704AC76D92F04FC634489C9A@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <SA1PR11MB71307704AC76D92F04FC634489C9A@SA1PR11MB7130.namprd11.prod.outlook.com>
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
Handle possible NULL return from kasprintf() on allocation
failure and ensure proper cleanup on error paths.

Also free dev->init_name in the device release function
to avoid leak on normal removal.

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>

v2:
 - Add NULL check for kasprintf() as requested by reviewer.

v3:
 - Free dev->init_name in versal_edac_release() to fix the existing leak.
---
 drivers/edac/versalnet_edac.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 1ded4c3f0213..360d4f83ed89 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -15,6 +15,7 @@
 #include <ras/ras_event.h>
 
 #include "edac_module.h"
+#include "../../include/linux/device.h"
 
 /* Granularity of reported error in bytes */
 #define MC5_ERR_GRAIN			1
@@ -755,6 +756,7 @@ static struct rpmsg_driver amd_rpmsg_driver = {
 
 static void versal_edac_release(struct device *dev)
 {
+	kfree(dev->init_name);
 	kfree(dev);
 }
 
@@ -812,12 +814,19 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 
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
-		if (rc)
+		if (rc) {
+			kfree(dev->init_name);
+			kfree(dev);
 			goto err_alloc;
+		}
 
 		mci->pdev = dev;
 
-- 
2.51.0


