Return-Path: <linux-edac+bounces-1893-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8177797CCD7
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B72283E19
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C981A072A;
	Thu, 19 Sep 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF+nzjoU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5219F467;
	Thu, 19 Sep 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765473; cv=none; b=ZSgORDfdywR7HP4u4I6Se0K7ibh8FQdOlT10CwzxiwZiP/9jwtmAbqSGWqW+kXxmLX4qHDuotnsuJtgDYCx3d1to/+xv8P8cjO3jYDn2eRo0ZpZP3GtpIy+KWK7EKBdTIUFE72B6UszuF8csmYzXDbVdIgS/WL/FEIudcBcAvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765473; c=relaxed/simple;
	bh=ksjCsOblO0xxjYYIysiKL2f0pHUq1rH2S94j+av9qjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T7Qo2282m4YZU8cwiFT7rFABgF0dwfsma5brXWV3otiEh9aMW9lmwZZ7sPzPx+auK1lZQTt/xYnE3qV9awLxfzYIWSc1tQnzYERQLFPPn7R04KyyaCpZJpBaE6rDky+A74TKh2AAfiSxGZM58VMYtvn/3DJboRHSDqugJRWsXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF+nzjoU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53653682246so1244970e87.1;
        Thu, 19 Sep 2024 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726765470; x=1727370270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1L1zJfPg4yvi6JPKM1ckE7Aqz5jOVXysiulNkDL87Mk=;
        b=SF+nzjoUo9YU+zLTVJkwXnSy4rSE0SslZcJjzAERhU+1B+0azLfqXNJWDub06cBDSs
         OaMeRY2bN/C0tvF9C5VWquy7QrXU0Sm8lX8nYEACwqkqQlGgLMY2EkmA05uKJ6nBoltM
         EgNgfzUY5dZs6zOamzC2w4s3f3wvpIBZRmNSvGs3srL8qU50eDnfwu0zCbV6Ja0axgLh
         USv5GtFl6UJLNhJ9l6xjpP3LwVeb8G5F9gQ13R4C+pbaqHANerPP0iVvjzCfEgkcOHxX
         54PyuSPtRtN70OzS3qJpdpGo4xmmeheuHJmPVb31UE90gRyk3XmerU1DSZ+e/gn/GrhL
         Pk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726765470; x=1727370270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1L1zJfPg4yvi6JPKM1ckE7Aqz5jOVXysiulNkDL87Mk=;
        b=GfVkeMxFAYshdKxfrWazn1420O2/Z4b4u92orcs1Qd+nG9akre7NRuvKpTLS9YNJv3
         SSi3rDixox/wYJ2I9B60B9bS1SAz5CKBVQxXsKzHI6x6eV1pyFY7gd10vyk5NxwwC+uq
         ICiHaQID5gS9vSSx3d7af/T6MWJ/L+j+wTRr8gxEbwm7+R/jJIZwVHTR4V1GPQT5MgYE
         haADbP/RO8R2XYqX97/b88CG1HhcIyo7DpJB+hXVlq5ILJk9Jclucv9LZOmvO7Um/Dr8
         baCJnDMSDoGOVQyd+rrjUvPhmlsSGCHseEjP1OA/ZvQ3b8WO2/yMC1wqIemX7ne0xoZg
         7KCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzaqtW8iO5qLaBs5p+yFOD0oEPi3WHoZawjIYy32YSY0kdVUh9f1cUIm3JeM50WVPW37pgOMGnsuyaZqaq@vger.kernel.org, AJvYcCXGX1S2ixoapBCH/O1orFdwYwUNaBIjJpt+//zkoAhP9QAKGcUmr+nIxJAA3f6O0PqQXDh8tGOsdQGl@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDi5wQlJqda+lKuv/ukodyjvNkP2ARiQ/PZVA9YV375pVFdiv
	GIbgSxJgSzpKFfffU7i5N1v6nfQeWStQ7n+8g0MzHP2sfrktD4/j
X-Google-Smtp-Source: AGHT+IFX5cY1X7Vde4l7dtqRdfynCbBSfVa4GbkyllzuZwYOdUkl31o3mjTvBUIIhsUdk5er0AXKDw==
X-Received: by 2002:a05:6512:6d1:b0:52c:9906:fa33 with SMTP id 2adb3069b0e04-53678feb1ebmr14662285e87.43.1726765469676;
        Thu, 19 Sep 2024 10:04:29 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75440657sm26857985e9.20.2024.09.19.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 10:04:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] EDAC, pnd2: Make read-only const array intlv static
Date: Thu, 19 Sep 2024 18:04:27 +0100
Message-Id: <20240919170427.497429-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array intlv on the stack at
run time, instead make it static. This also shrinks the object size:

$ size pnd2_edac.o.*

   text    data     bss     dec     hex filename
  15632     264    1384   17280    4380 pnd2_edac.o.new
  15644     264    1384   17292    438c pnd2_edac.o.old

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---

V2: add note showing that this change shrinks the object size as
    suggested by Qiuxu Zhuo.

---
 drivers/edac/pnd2_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index f93f2f2b1cf2..af14c8a3279f 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -372,7 +372,7 @@ static int gen_asym_mask(struct b_cr_slice_channel_hash *p,
 			 struct b_cr_asym_mem_region1_mchbar *as1,
 			 struct b_cr_asym_2way_mem_region_mchbar *as2way)
 {
-	const int intlv[] = { 0x5, 0xA, 0x3, 0xC };
+	static const int intlv[] = { 0x5, 0xA, 0x3, 0xC };
 	int mask = 0;
 
 	if (as2way->asym_2way_interleave_enable)
@@ -489,7 +489,7 @@ static int dnv_get_registers(void)
  */
 static int get_registers(void)
 {
-	const int intlv[] = { 10, 11, 12, 12 };
+	static const int intlv[] = { 10, 11, 12, 12 };
 
 	if (RD_REG(&tolud, b_cr_tolud_pci) ||
 		RD_REG(&touud_lo, b_cr_touud_lo_pci) ||
-- 
2.39.2


