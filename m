Return-Path: <linux-edac+bounces-1834-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CC9724F3
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 00:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5561C223EC
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE118C92B;
	Mon,  9 Sep 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2nvGm2F"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7318A920;
	Mon,  9 Sep 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919762; cv=none; b=V7ZnSKj6gANL909b/j2uUBVD5OCp6Va1z+LVS1Sn5fgcvLJ7MDfU1B1Fg7Hua4S/blGgS/K8NDfRYS7jym/B8UTKEaB4KSkJI6iOkyMNkWgENts+eDicBfPsI4fYluuzs9BImsft2g2sTJk88niq3F1INEsyxM5UDfpPCakoYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919762; c=relaxed/simple;
	bh=xAan0RdLevLXlBWZJIEkjT6XCXYGpk7zDfotdpBDGoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/ryrHZCKGm9gw36YpkOEU660gG/PgnePQLZI0Cqu/4BtepeOqLOVIBf7InUgEeDHHC0ZpEJfd6ZOSQRW60RtnGVEM/leg+wJXt+NvBA2tf8a+w4nPAQtgQv6NiGkHdb86Kwhl0BE8iknqW7FraWg6+FZqqWp+/JiFHJqgIuXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2nvGm2F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so12809135e9.3;
        Mon, 09 Sep 2024 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725919759; x=1726524559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsPDqkVnY6G76KUOE5YeGyTOTZj2B3ANCn40xAGj0dQ=;
        b=D2nvGm2F3gwT90qkc7EyoPf6g+Mb9DjrxStLZXpX2vUWDi4/R00Ml8A6+pbp+OIGyX
         BAfBVwWreFfDwoVCerBfpYYkfJ7e5SwNnDjZsqN58WK/JniYiBo04CwsUQ5qUOk7y0oG
         CeLNmiD2YAvKC9RLGkjmVeKLYj5aLsjUJY3oT64QWVcQLBvF3F7aEYYufNCopZmMs/Sj
         ddUUIKjnlMF58yXUd+pxcSoShrdwzqUSVaXgIt5GUQzLcZXK2QBaCQhgDaiMIbMl4CVI
         Lr5US3JF08YhTlcCBsxzRaonkCUhKpHyZZA/px98yrfQNVRUkzUsVv9YX8DKsYj1BoZa
         iLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725919759; x=1726524559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsPDqkVnY6G76KUOE5YeGyTOTZj2B3ANCn40xAGj0dQ=;
        b=TG9Iv3e1j398mmo3vnELYH2EeL8+xrH2IfdPL9+tXWb0lX+w8oPMPyCde7NKu6nAiZ
         Q/328LZZSy9d23X84aKhHlqY/rdOGvdKIFCicHtb3Mz0ZlmzVJu0OlkKqWj11fS/eTb8
         fTQVNscxqow12H80+c8lplfxRrD6EkIr+GHLoqitzZU0M5LwkIIgKVlP6XZEyHZfbCfj
         JDHHolhaTmQ/tvFypzChdOSYo4//3BKcjAeTLM35iSKv85d+ogO1h7O1NkoRTN3XPJCO
         5WTdJpiGZyuqctCdqM+uwX0NT8OXjInMjcDnxKzhxicjseS6/4NqmXFXVgKxku51rvA+
         f0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUnoxAuHz3RoOjWbyCjc+pI2q7bLo1pFhvQqYqRJcs1ZLitRTqAxTmWxumvQNnHux6gBLWcFfPQ6z7TicvIPGk=@vger.kernel.org, AJvYcCXvKP7cWpvtIxODbeZ2uoW1JnTH/gBayRMJtTwNs1oQU1euItE6COoUjTlnDxCC6cumUHRZrBOT2uSi9joS@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCUJNe/ewSfpqTIT4LMtlvCrNu6jAMIop1qW8oOICMBqwSUZs
	XPE94SV9wrkPMKbpwx26aly2M4qtcQAxIUG5gM9HRkHr19d6AZV6
X-Google-Smtp-Source: AGHT+IGTA24UWctI2WhTeyP5yfImnBelxgK80xoDKneqoLWLg+fsK+poqgxMhAw3AklJuPb0kl/NiA==
X-Received: by 2002:a05:600c:3c94:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-42c9f9d7c3dmr91573115e9.33.1725919758150;
        Mon, 09 Sep 2024 15:09:18 -0700 (PDT)
Received: from void.void ([141.226.14.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb815f4sm90110955e9.30.2024.09.09.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:09:17 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] EDAC/sb_edac: Fix typos
Date: Tue, 10 Sep 2024 01:08:49 +0300
Message-ID: <20240909220904.11461-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/edac/sb_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index d5f12219598a..d47f1240c738 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1797,7 +1797,7 @@ static void get_memory_layout(const struct mem_ctl_info *mci)
 	 * Step 2) Get SAD range and SAD Interleave list
 	 * TAD registers contain the interleave wayness. However, it
 	 * seems simpler to just discover it indirectly, with the
-	 * algorithm bellow.
+	 * algorithm below.
 	 */
 	prv = 0;
 	for (n_sads = 0; n_sads < pvt->info.max_sad; n_sads++) {
@@ -2055,7 +2055,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
 
 	/*
 	 * Step 0) Check if the address is at special memory ranges
-	 * The check bellow is probably enough to fill all cases where
+	 * The check below is probably enough to fill all cases where
 	 * the error is not inside a memory, except for the legacy
 	 * range (e. g. VGA addresses). It is unlikely, however, that the
 	 * memory controller would generate an error on that range.
-- 
2.46.0


