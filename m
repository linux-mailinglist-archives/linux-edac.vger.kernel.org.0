Return-Path: <linux-edac+bounces-2433-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9E9BBD53
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62CBB20DD7
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AA18C926;
	Mon,  4 Nov 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7R5Tb9H"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518418BC37;
	Mon,  4 Nov 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745280; cv=none; b=FOt80nEZvGLS9fcndPSogUA+DiWZuR2o/Cegx9iWAMh7eubmTTTIbh/BV+Yo847gIEcrtZ+cJNgrliQNoD1f2j6AoF+UfAb3MQFOjxaNBsWsv4ePkaUaWndPlboPs7ZQN3LLd/5BfhD4eYbW+s9mtMJFBM3jXFKxQ9h0izDb7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745280; c=relaxed/simple;
	bh=xkyANICZW1kiYDTrWIyd8eKXgxkDF0Yd/a8mxZXj8eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SMvbPuLFNpqZIrRTrq2mBYC0u3KGfARsarTpfkLqyAhR5H0BJBzW6VXl01SoIo8DulczVOtjuh3SrizKbVqEyN8roQ1lyvEYp9yUDxp4yyWeYpwOhP3N7utrnsgkzXY8weZKcD5J3BllW+bh4ZyURSH+IUNWOjtaefOgA7+zZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7R5Tb9H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee386ce3dfso3633392a12.1;
        Mon, 04 Nov 2024 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730745278; x=1731350078; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KR/WEu2lX1QBKt9y1/WE/LUdXQDB5UntMfmib0e4qE4=;
        b=j7R5Tb9H6X/ay3dQJi/aGqODUuKfCm5BpRO5Kp51MAW2obtWUEk4LFWj2+rOz3EjU0
         cUNQsm6ENGNnLzz25x/Cg2pfvkgFSGSEFPkvwFwYpiCbq9sWp7PJwL/YKmWgdXoL+afy
         KcgaUyyK8nOqYuSBkQWASFAZQMT3iZtawuSJ/JJstq4igykoBlqv9UKJX/TL3vaDCIaO
         C/kNdZtKsdeWOuJYvKQrm6ZNuww/+us4DF5bSL91KXMOQnB5X0pooz/Dua1p/6OXcx7g
         pmpB/nLnQYtUQLcBi5rD1vJcWWZ+T0nZIiqOa+SaiYoPTbBNijz0FvPPfnos1KOSXawa
         Lk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745278; x=1731350078;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR/WEu2lX1QBKt9y1/WE/LUdXQDB5UntMfmib0e4qE4=;
        b=iyLWitsJV+l1pS9qZg3icBVuVOjT3Fov/hkHh7cGTV42MYRP/Ch9X2OtZ1e1vlLfEI
         ykdKN1mOJ/ooK4oScPmMfnvsny9mGBTQc37E6qu61VODvEkCINubciC1Y0fmDsMO1lfV
         hF4KL4m+46LWHxkhd/pttt0u6Md2gBf7liKebOrMdoyl44L3zdKINHNt7I1UP0GplqOa
         JPzdzc0DPdXUjJP2QDj8Rb9F3nfs45ghEbCq8TkfTa4GFM0p4xAE+rLo3ur8QThSnw2x
         V0SfBTpR1JFnziAlofaGPE+eOYPE98xGIC/sewlklZICZ8FRUJwO1JGHlcwWkEp5R8/C
         sWkg==
X-Forwarded-Encrypted: i=1; AJvYcCUVX7TJh5SJyQPaxaE8qNEbfx9fp/TcChlcalljfxTcNNlGBBtmxv3aFgxpDwsiMAL1fFn0AQqLCM9kvUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaR6mI99/45fq74jmNgivawwPmpTBMG7zIwn3Fg5v97Ngf4xI
	8yWUTTPoMObJjHJZudUAuj3R4sdhkwVNr2ETv7uQAO2c/6549Rk/
X-Google-Smtp-Source: AGHT+IE6GGmKKm1PKO2XkugXfeNvDAWYYIdohMSgW5qNcth75bL0c+3VeBsGBqZFp6TOu1+yYbBQ/g==
X-Received: by 2002:a17:90b:3c8b:b0:2e0:8780:ecb with SMTP id 98e67ed59e1d1-2e93e0ac64fmr24732115a91.12.1730745277924;
        Mon, 04 Nov 2024 10:34:37 -0800 (PST)
Received: from Emma ([2401:4900:1c97:5a7:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc0087asm10185650a91.47.2024.11.04.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:34:37 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Mon, 04 Nov 2024 18:34:22 +0000
Subject: [PATCH] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK0TKWcC/x3MQQ5AMBBA0avIrDUxRairiAU1mE0rrTRE3N2w/
 Iv3b4gUmCJ02Q2BEkf2TgLzDOw2upUUz9KgC10hFpWyPok4LqxNWZom8uroPMh9UDWtNZO2Guc
 aQRZ7oIXPf98Pz/MC9+VVFm4AAAA=
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730745275; l=982;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=xkyANICZW1kiYDTrWIyd8eKXgxkDF0Yd/a8mxZXj8eI=;
 b=J+UQsh270gZBqOES8cP2KldJBwUtaVzLqyCZP1sWXO0af9CUOG5szgduspOIB1rL2pB0BcOlV
 dtyFT3uNR3RBkqiB1vnM/sfgmXz+gp+Hk67XzU50pyd9uWJOAh8DHcg
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Explicit cast pc to u32 to avoid sign extension while left shift

Issue reported by coverity with CID: 1593397

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity  Link: 
https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
---
 drivers/ras/amd/atl/umc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index dc8aa12f63c8..916c867faaf8 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -293,7 +293,7 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 	}
 
 	/* PC bit */
-	addr |= pc << bit_shifts.pc;
+	addr |= (u32)pc << bit_shifts.pc;
 
 	/* SID bits */
 	for (i = 0; i < NUM_SID_BITS; i++) {

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241104-coverity1593397signextension-78c9b2c21d51

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


