Return-Path: <linux-edac+bounces-1864-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC3976A49
	for <lists+linux-edac@lfdr.de>; Thu, 12 Sep 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3531C21472
	for <lists+linux-edac@lfdr.de>; Thu, 12 Sep 2024 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00371A706B;
	Thu, 12 Sep 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBRNsFuG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AE1A2641;
	Thu, 12 Sep 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147055; cv=none; b=jt0JKfIv9jXHJt7Yb0H8pFZc9H1ZhUaMiqV5fH141K/V65P7hGnUjAg8PzDsDTWTZaFngrts0ScmjOr2VJa5PJkhqt71NPY+2Z3H0e9wwr3jedYt/LEF+Gk/qC5DbaM1O7vYyMlQnaovyoZmrbgS4eeTIi3m3cixBkn95l4hA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147055; c=relaxed/simple;
	bh=K1r5aTSERKfF00tNzsjXwR4UzRjP0fmcaifJ7kHqDfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LcuXmhRM1sUKs+xQ/QZz9T4Xq4YHJ3qCnQMP+vTSO8S1NFZFG4S+0Wl+81yNE10NikFAdRgqFwJ5QAQ2BPn05euF8lHndomsCsLaIZZbkR106Y+Su0aUqhRwTJcn0GwcjK/8XzP3hqo5+Chk1Z64CI/Gpq0reftxmymDeqK3SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBRNsFuG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb806623eso8277135e9.2;
        Thu, 12 Sep 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726147052; x=1726751852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVCiz+GfbXXcZjaWdHj1FGnRfFqmbDnDvMXfgNHyN9c=;
        b=QBRNsFuGiuJiVc/p3MVgYJNru9ydz3pbFKn1A33IH/bWSe3ZFmyt+aEs8ndjcZy34h
         X1Y9KGEqtp9TdgEJPgwH6JzY7cm4mIenbRg1DM+jrZu5GlgItTDqC0ODWyIZWjHhoBIQ
         t1PEqN2d2CxT9b3bpJbUc0x/veTJ5mtTaSfg9jkUlSmwvyTYGCx6Hrh8Yhn9rmlC4eG5
         Vdg10ri5yYFhZTblKxYVftJ9nHPmtHqo2WMP/L7ke3Eve5YLqI+Dhp9W8ATHCGLVfN1v
         hqmqkjXSQo+FSP8gfwJUPiImjV6IYDM96tKldqJzHHK7GuoV5Mgi3nCCoQ29KgDfbnzX
         xBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147052; x=1726751852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVCiz+GfbXXcZjaWdHj1FGnRfFqmbDnDvMXfgNHyN9c=;
        b=oQseJuVBSy3D95kz27j6zBkke9RRCeU+VC7C0isrQcMztCKvqTwpP4dZcc8j4xB8fT
         cmcRDuQKeX742UkbsyM9a4piwN1lt7z7OR/t1KALMzA9xxlW1H5dybw4M8/t6iiAg+xY
         Gszz8eQbX6hKngNXxXHjfJbOPfWpfhnNkRWohpjEAc3qBpfR0h/R0X9Vs8oOdATo/HRE
         fZlQ7VmN8gBptBMAV5G0KO67YqR0Kh+OkeZx54TDEMJygf6s+9zTX3qrdPxEERq4Rgr0
         lYEV6aoFP6Wsb2uNjpjnmwTf1wBzxm2BoONv2SMwQQPpy4uqgoPXoM8GmfOJ2rh/pIA9
         SLKg==
X-Forwarded-Encrypted: i=1; AJvYcCUexfw0hQ6aO1HKSKaF8y4YfpmwPRsTFnCU5eE8UcaQUTIO565DN7b9l0NP5SLFEMHaxrJ5DXjItPRG@vger.kernel.org, AJvYcCWnYLshiMGmnmAcnM86sTxdeqdHLynsl+xnSd59ZuU15VZ7MDsJRI1XMca/onSU843MBhhJle2S5iSQbcPh@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8CzELCwGFgkOpYys0YhxlQhBZpGRdfg3v1y1xA/bIX+PGYeL
	UV8SrjP29CA/3kedwjUgG7CcDp1DiIP2HUpngtx8DpOXitnRiOjU
X-Google-Smtp-Source: AGHT+IGinFsn/IDIoimF7gK6JCHIlBd9EvXDNaB9+t+mIHn7EPvmjRWe3N7Si/my4wteiQ6feV4waw==
X-Received: by 2002:a05:600c:4ecb:b0:42c:b8c9:16cb with SMTP id 5b1f17b1804b1-42cdb4e6aecmr21661315e9.5.1726147051905;
        Thu, 12 Sep 2024 06:17:31 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8ada3sm170610095e9.43.2024.09.12.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:17:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] EDAC, pnd2: Make read-only const array intlv static
Date: Thu, 12 Sep 2024 14:17:30 +0100
Message-Id: <20240912131730.588673-1-colin.i.king@gmail.com>
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
run time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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


