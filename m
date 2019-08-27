Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6159F47E
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfH0Uti (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 16:49:38 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60167 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfH0Uti (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Aug 2019 16:49:38 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1A0AD80719;
        Wed, 28 Aug 2019 08:49:37 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1566938977;
        bh=PIfUy1UaDG+Bm4sZignWk5XvEQ/zp3pqmJ+geIdmjL0=;
        h=From:To:Cc:Subject:Date;
        b=xGg/ts7PoziI5S+5a9MLyXR3CXvJXGUTj1L669GdIu/XYGn9r6xjslEF1ZpHJ6wk7
         09FJ5rvsIAhkQhhcArglrzLanf+/ONLRyfR9tRQbspU9rRjfypE33+YZHL2zLDmBoY
         Eb923LYCdI5Fbphyg/OVRr6krgmwFRGMvfG79CGWT5OnF5Azu+oTxMZcw229KnUr8Z
         PxeH8XEUygujBPGdKTt1kx2LGQwMQUFwMfgUBYrPKpO3M38FAVdJwtHc/kpLoRc4T5
         VjiD4jy6adYRjyH4+KfwtwND99baR7B8xKE5nLjyE+hq6NE3BbLH96I+LDV66Sbmd5
         9wMLGdUlJsACw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d6597610000>; Wed, 28 Aug 2019 08:49:37 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 7C09C13EECA;
        Wed, 28 Aug 2019 08:49:39 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7BBD8289DE2; Wed, 28 Aug 2019 08:49:36 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     patches@armlinux.org.uk, linux@armlinux.org.uk,
        mark.rutland@arm.com, jlu@pengutronix.de,
        gregory.clement@free-electrons.com, bp@alien8.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ARM: l2c: move cache-aurora-l2.h to asm/hardware
Date:   Wed, 28 Aug 2019 08:49:22 +1200
Message-Id: <20190827204922.14832-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jan Luebbe <jlu@pengutronix.de>

This include file will be used by the AURORA EDAC code.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
KernelVersion: 5.3rc

Hi Russell,

This is the missing first patch for the Armada EDAC series
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D8885/1

 arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h | 0
 arch/arm/mm/cache-l2x0.c                                | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (100%)

diff --git a/arch/arm/mm/cache-aurora-l2.h b/arch/arm/include/asm/hardwar=
e/cache-aurora-l2.h
similarity index 100%
rename from arch/arm/mm/cache-aurora-l2.h
rename to arch/arm/include/asm/hardware/cache-aurora-l2.h
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5b251c8ecd45..428d08718107 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -18,8 +18,8 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/cache-aurora-l2.h>
 #include "cache-tauros3.h"
-#include "cache-aurora-l2.h"
=20
 struct l2c_init_data {
 	const char *type;
--=20
2.23.0

