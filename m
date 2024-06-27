Return-Path: <linux-edac+bounces-1410-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA291AE24
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775271F2805E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5719E7DC;
	Thu, 27 Jun 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh3juM87"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA719DF4F;
	Thu, 27 Jun 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509596; cv=none; b=QJKjJuYDbK/MkVdbAVvSmNlxpKXDkJLGAr6T1y2m+NUWltUQ+gFRAL+P690aJ+YQyLW7VLtSactvOSOzUZ/momXBiW27gR0tP1/X6TCSYW8x2ks4ggGw//9MBf30Uq+ySJKxzgfI9lA8RY7qWc4YnRE71pOxtaGuh9e9Z/LsuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509596; c=relaxed/simple;
	bh=BqEd6da9F4463LYl6+ER/h//adnPjI5i6gHbK7MZVdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmQmoaMaxMBIav9JNeOJEaaukEpM50ZJbNdwhlUATt44gXss7zeft0rKGsZ2M8KBAZV8DsDMHnBiJUptDtRYomCuq8VRbdgbDXoSl03gF6OhHRWpqgiIkHzmKJ7bYhKJszHMFmib/L1Z5G+caZ7HvWGHMOLT692DNAurudKIGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh3juM87; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso8167751fa.1;
        Thu, 27 Jun 2024 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509593; x=1720114393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Uw3IgAb9IVTJOJNh2JjGljnjQMbkdW8wc0NmcHbiU=;
        b=Uh3juM87B2RmaAQHusiRCSVmKx4j8x/GL0mSE+bBxlEH9IQ150s51cLJ1Xsve62xgF
         oZzS4NRvdCxtVO8PyJj2js6WGpsBKp1+jPTECx/b35TlI5D+tgHZOScb8NXuZHMgWDUQ
         ddE3IszvFQfllPMplD8LKoQdlJ4IvatMegTXZ+2ghoD8c4lCZvcYGaE/HMt+r1oV1k6k
         kdkRCIF5bsXm+TB3GWewCM4b23Ntqa948LV2CpBkHV69jQUWWAy8odFqSOw1RMvx1n0h
         NLT/ZaMHdEThwCNokyEU1k28XUCm9XFIVmEZ+c062lsK4yUfVB/3sx3Bmp/Vqvq4LdFQ
         tD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509593; x=1720114393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+Uw3IgAb9IVTJOJNh2JjGljnjQMbkdW8wc0NmcHbiU=;
        b=HaSbZGJS6Cybpagg0vNT8hrX9QY1XR/+991f6XKmv7tkGqojn1QDX81LqL3QxAH2/k
         1NJxdXThDIoY0mfgM10CMyEkeAgJA0qWOdD7Zgo/XK1SIuAhdTjQPwor0QxS3J+jBSgg
         QFOJ+gDZp2zWGu13WCHmW5+5Rl99MKSqwz112BNPQgDXfirHgaXhqlg0mXN32FYQl8RI
         XJ6/xop86Nw8l2lnHGKYiM5vVADu3p2mMykYyfdBh+XWLZTDraH8e26zFYI6YKdf3rpH
         /mljpUgCnvoUM2tokUP6HV5y4AbiS9GNGBijSAT2fnYMEDAxr/LWcX4XAkPjcr6ivqBU
         clZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL/7iR6u3a1ra9T1V9cTYu+FamLISGffToABoFJY8J/mfYGOPU6iR7kcv67lz+t44N3KUB3o6oXj5jY0LG/cNebNI922A94Nkr1G4pvIMgVp3r0oXERIXfOckEThe8NDW0Hrx6HZeGiA==
X-Gm-Message-State: AOJu0YyrU/2HTZznJZH9VsBDyXtFtGe+3yHLCPMgFtBq0yziQtqff1Tx
	IIRyuScs4NvFyh9YEoF/+bug1P0rY/TQyx4CFV/+7eyhxZSF7uCp
X-Google-Smtp-Source: AGHT+IF1Fx4EAdZ921plT84eKS9IyWWDzNEDRNmYtPMmeAdtKnurY/J4deXF23iDXxe5jAvFtEVn6A==
X-Received: by 2002:a2e:2e09:0:b0:2ec:51b2:2cba with SMTP id 38308e7fff4ca-2ee47dca15bmr10671811fa.0.1719509593114;
        Thu, 27 Jun 2024 10:33:13 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34f66fsm3217771fa.30.2024.06.27.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:12 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH RESEND v6 07/18] EDAC/synopsys: Drop local to_mci() macro definition
Date: Thu, 27 Jun 2024 20:32:14 +0300
Message-ID: <20240627173251.25718-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The to_mci() macro was added in commit 1a81361f75d8 ("EDAC, synopsys: Add
Error Injection support for ZynqMP DDR controller") together with the
errors injection debug feature. It turns out absolutely the same
macro-function has already been defined in the edac_mc.h (former
edac_core.h) header file. No idea why it was needed to have a local
version of the macro, but there is no point in it now. Drop the local
macro-function definition for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 07aaf4562847..230818a3969e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -940,7 +940,6 @@ static const struct of_device_id synps_edac_match[] = {
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
 #ifdef CONFIG_EDAC_DEBUG
-#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
 
 /**
  * ddr_poison_setup -	Update poison registers.
-- 
2.43.0


