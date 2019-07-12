Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14B6654D
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfGLDtR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:17 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38290 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbfGLDtQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:16 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 96042891AD;
        Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903354;
        bh=fwvS8jv11krqvXlQA2Z/qa+UCaV2Q8ZSN+LH4FkYBnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wXpa/Ec/bqiUJzEFtX90h1O2Nglu63ADC+sYLIU2Bi/sYkujjX2rd69a+CE5evo//
         SVdXbvUXlmyyRSZLNbeiv2BcANWQ0GwpANCormnUupi5jgsPHOIBqJox/kvvyz7R84
         IlLtcJnra6ceJVzTD7JtvT3crnZ27TyTjhSgnQpe5j5e24qPJPduF7aqiLlByNaN6Z
         dFX9vaGbzwSaWgnJuH6/sWAJfllFai4oRbPrgDtEu7JswWFgPM48o79O7+zsGB7oze
         ogq8OzlzRcU/5pKkAIk/l4cqVjf07i38Edz7b3x9aiqj95TyJbeh61efj3qKi4Wkfn
         PNtUyKh2mHmsA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0001>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 0981D13EF47;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 401E01E1D7A; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Date:   Fri, 12 Jul 2019 15:48:57 +1200
Message-Id: <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jan Luebbe <jlu@pengutronix.de>

The macro name is too generic, so add a AURORA_ prefix.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/include/asm/hardware/cache-aurora-l2.h | 2 +-
 arch/arm/mm/cache-l2x0.c                        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/i=
nclude/asm/hardware/cache-aurora-l2.h
index c86124769831..dc5c479ec4c3 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -41,7 +41,7 @@
 #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
 	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
=20
-#define MAX_RANGE_SIZE		1024
+#define AURORA_MAX_RANGE_SIZE	1024
=20
 #define AURORA_WAY_SIZE_SHIFT	2
=20
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 428d08718107..83b733a1f1e6 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1352,8 +1352,8 @@ static unsigned long aurora_range_end(unsigned long=
 start, unsigned long end)
 	 * since cache range operations stall the CPU pipeline
 	 * until completion.
 	 */
-	if (end > start + MAX_RANGE_SIZE)
-		end =3D start + MAX_RANGE_SIZE;
+	if (end > start + AURORA_MAX_RANGE_SIZE)
+		end =3D start + AURORA_MAX_RANGE_SIZE;
=20
 	/*
 	 * Cache range operations can't straddle a page boundary.
--=20
2.22.0

