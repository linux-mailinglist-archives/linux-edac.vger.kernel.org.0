Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647C419B57
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEJKQc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:16:32 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47619 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfEJKPn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 May 2019 06:15:43 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9C3C3891AB;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557483340;
        bh=MiPXzREL9W1jwb0qqv3Cp/VmybxETnuh2vjHwP0eucw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WsjCO92j0IOB4jd+tn7TjfIi6I+yo6SCkUbe+smuu+fNk+vV9DMOWr7S98TVt26xw
         y3zv/Oo+NtCJ9VGt2ySw//uhoLOL/utK4wCNkI+hp4awDqO3++AK8OKscb3T27fTIU
         WgdYH36Ob+dS4N1Nea+0/02NEPbQVR5bWHTJETkHDXdFNH3MA3hmHigAESYENpCGNl
         7OKodWgRq+2kws6wOKh2XbeD0yIZiFwCdK3RowAb+dQXO+FFSgeHz0Xd97Ea0yuSGj
         529c2JUlg+jXW0vM+Ke1gESCkbw2Rvdk3mWpHTJaqDbsFm02fwrzk3zEmTMxNE5jKQ
         9z4D8TTuc9FpQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd54f4c0001>; Fri, 10 May 2019 22:15:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id AF00F13EEF9;
        Fri, 10 May 2019 22:15:39 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 43E741E1D5B; Fri, 10 May 2019 22:15:39 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, mark.rutland@arm.com,
        robh+dt@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 1/9] ARM: l2c: move cache-aurora-l2.h to asm/hardware
Date:   Fri, 10 May 2019 22:15:28 +1200
Message-Id: <20190510101536.6724-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
References: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
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
index 808efbb89b88..a00d6f7fd34c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,8 +30,8 @@
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
2.21.0

