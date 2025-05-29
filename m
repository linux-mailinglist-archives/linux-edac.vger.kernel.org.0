Return-Path: <linux-edac+bounces-4043-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4DAC80F0
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688D91C02725
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6322D4FA;
	Thu, 29 May 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtX2/Q4p"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4B2288C3;
	Thu, 29 May 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536328; cv=none; b=CZ1hMAmzZfKDjAH1SpbV2VbY1+6cOj4TM9YMLnqBTWht0mO1i9pYNTMiOg1SzeS4T3kV+sMjBIEkv2YFPOw98htPTcZXYJ8GJdFUug/WVMx4cy4KXZOFG0yogMSBCPT8dow3cL6Zn/s2u79kjlJDYb2YhvXcj1jnLN9hazOlDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536328; c=relaxed/simple;
	bh=6BLCx+5MPlkzOTxHiphi/Qzy0q2UMfB5Z+Ufuf/uG8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKpgytfpVLbAXJAexwULe485XdE72BTW4a3qIRaLPPJ24rCKwnyw506aolLays/A+IqrbckyU6WBhhcfEXJgzv+ievItvPBSHmR4UlDSY+K0c0K87efP0l6inOKR/9HxCT97Jovzqrd7EvpAvj34KVsVGSkCA9J0DQErCuRT7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtX2/Q4p; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fab54e8bbeso12029276d6.0;
        Thu, 29 May 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536325; x=1749141125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkBRRqJSagqyTkfCz1bAUQKHe0riFK6F2xCu+0q7Xlg=;
        b=TtX2/Q4pkRgLamUshac4EJW2SF8BnVrMJsvKhdeB4q7FIR/A7DTKvr+5GlthU+LuKc
         jEwGsfzcJwB8W92HOIStRXqQnMWyDFd8DL1G4NJREt68WCvA4828hvawV98WQCaeVzoy
         zuDRwBgQLXn+1jYuij6TOU7vUfOyjosx8k2o1vULP/iGLT6N+FVswi+fLLCAmnLQzsz8
         xgXMf7UvY4+Z9WuiwL+l2pWEfYVyK2+xbyHSLZE9Ga65G4ByEbv5BkLfH0SMUYHtLkJV
         cnXT6eJeaoncbdSKviVXVnjM636fqO4eRRga3qUe5QU9k9Gd9icBpwIXuh1TkoLJDeOi
         xtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536325; x=1749141125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gkBRRqJSagqyTkfCz1bAUQKHe0riFK6F2xCu+0q7Xlg=;
        b=PFfWffGFLaRq8/h6w0JrNAyz7NMNP+0kbA7r4gDGm4vMzV87YpkaXLHvW1qxKaFxST
         GOkAmYBRXPrfkwVAl7o3i6CsrWo+mC4B8vZu4yE/zwiAhwz6dbEmQEM7+STt8TcLbfPc
         VnxBUqlPg/t7mlrHdF0AXntakSSgG9RohSgAVSBo0+XwaRkC17kO0Rd1C18Z4MXJbkUP
         kUfF59nEGqS0AjNYadUDnus1M5vHNYir3YxEAV2ULDncF5qj3gEgOE4VrHviwQxA6Fm5
         cizzxUwFeeGLv2rqhNBOPJf5dt+ohotOtWA+RSIrNPseNDLSj9fm46M89og0Im7pYctl
         gilQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnTftlOABOah4HEL74oRQ1hmFxpf2Ew2JoRquhAik4v9vrVgKzde4PJNPsnECWAJ1C1rLSqN7vE7p4hTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA12XjCe0C/EnUPFDhl/ndA9AenHExAr7/w6YKQKhOtBOzN+NG
	JvivhQqGGAjqOpIBykpn77iYulK2/vWm0tFZM/2c8oBxTrkB7m6iFhAH
X-Gm-Gg: ASbGncvevJi2rrGFgeXOgHauFqHAIXzxZex97kSDFkwX/lQ6/fdTS2zeraRMAi66D76
	8HGiU2c9plUiMNSoxo/jFz442WCL2ltYSE+Sfc3Jcj52Q6runZDnjH3ea9uESLF0LaRm8Gz0va2
	w1D3wWzVhq9Mxf2nrZXHNocqDxys2ADU+u39JqPpZ0Sg87hmnrLggGqeJaiyUOWUzn8gZgG/Z/H
	3CkhqwXz4m2SfyqkQp0WrsHish11DrnMmIa7E5dT2Cm7C40w7/bXnN+mdmkmQ7v8ya807V4TukA
	Gb+J7XMF2NzAwIHh0dxficPsoa9p12+1TmBYcfMs7AgXuakCjBXtYPf1equjsXSsBCbngsHoVJB
	DESi5vpzV1CuG45eqXdit7MeF88rugtYAeg==
X-Google-Smtp-Source: AGHT+IHaIdB1RVflLTevGHMAX/FYpi5gxsFdRsWzGtbC7W5+u10H7UL53E2oLvuyzL5g0UngxWnC2w==
X-Received: by 2002:a05:6214:d88:b0:6fa:bb44:fddf with SMTP id 6a1803df08f44-6facebb6d12mr4355526d6.16.1748536325506;
        Thu, 29 May 2025 09:32:05 -0700 (PDT)
Received: from localhost.localdomain (static-198-44-159-42.cust.tzulo.com. [198.44.159.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b3e7sm11208276d6.61.2025.05.29.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:32:05 -0700 (PDT)
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
Subject: [PATCH 2/2] EDAC/ie31200: Document which CPUs correspond to each Raptor Lake-S device ID
Date: Thu, 29 May 2025 16:29:33 +0000
Message-ID: <20250529162933.1228735-2-gdgaidarov+lkml@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
References: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on table 103 ("Host Device ID (DID0)") in [1], document which CPUs
correspond to each Raptor Lake-S device ID for better readability.

[1] https://www.intel.com/content/www/us/en/content-details/743844/13th-generation-intel-core-intel-core-14th-generation-intel-core-processor-series-1-and-series-2-and-intel-xeon-e-2400-processor-datasheet-volume-1-of-2.html

Signed-off-by: George Gaidarov <gdgaidarov+lkml@gmail.com>
---
 drivers/edac/ie31200_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 1812ebd19ece..42e332ecd6d0 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -86,12 +86,12 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
 
 /* Raptor Lake-S */
-#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_1	0xa703
-#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2	0x4640
-#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3	0x4630
-#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4	0xa700
-#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5	0xa740
-#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6	0xa704
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_1	0xa703 /* 8P+8E,  e.g. i7-13700 */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2	0x4640 /* 6P+8E,  e.g. i5-13500, i5-13600, i5-14500 */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3	0x4630 /* 4P+0E,  e.g. i3-13100E */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4	0xa700 /* 8P+16E, e.g. i9-13900, i9-14900 */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5	0xa740 /* 8P+12E, e.g. i7-14700 */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6	0xa704 /* 6P+8E,  e.g. i5-14600 */
 
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
-- 
2.49.0


