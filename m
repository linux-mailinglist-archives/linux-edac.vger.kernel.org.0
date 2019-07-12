Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1F66541
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfGLDtm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:42 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38358 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfGLDtS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:18 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2B5C9891B2;
        Fri, 12 Jul 2019 15:49:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903355;
        bh=YlJL9VdfrtMa6MepsmOIBxWXF9RyXS2+R/9YZ01ZhYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b4O8Arsuyiu4cA+g9S2zTiH0XVjl4tf46+3e6b7T7XEFbjZGC5BgtYYDiV6xbxBOL
         XI1EHpV3nsv/kd5vy9cOrri7gcgaBT3XDbbgPu14YxLIt7yiGXoin+gN0Yz+g3pSl1
         RUy2HE06EHLDxpJB81madb37x6GumSMHP8BqPCLqE3iRYGNc0QQEgAlohvaHipWRn/
         IAiI1aRSkPm7x3yjYOQdzXgYCmk8vkG9qTidXst/4OKeRQcI1qw6FYkA1SMenrJm+O
         dO1xdzSSVNhQlkzaTkcaD1lbuKjZNzrAsmqdJ5AM7MySzGyw77/lhsytIYRLkxpiAa
         Shd1kYlNXzvGw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0005>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 197EC13EF9C;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 512AC1E1D7A; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 5/8] ARM: l2x0: add marvell,ecc-enable property for aurora
Date:   Fri, 12 Jul 2019 15:49:01 +1200
Message-Id: <20190712034904.5747-6-chris.packham@alliedtelesis.co.nz>
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

The aurora cache on the Marvell Armada-XP SoC supports ECC protection
for the L2 data arrays. Add a "marvell,ecc-enable" device tree property
which can be used to enable this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
[jlu@pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---

Notes:
    Changes in v7:
    - remove marvell,ecc-disable

 arch/arm/mm/cache-l2x0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 46a616ec6b0c..12c26eb88afb 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1493,6 +1493,11 @@ static void __init aurora_of_parse(const struct de=
vice_node *np,
 		mask |=3D AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
=20
+	if (of_property_read_bool(np, "marvell,ecc-enable")) {
+		mask |=3D AURORA_ACR_ECC_EN;
+		val |=3D AURORA_ACR_ECC_EN;
+	}
+
 	if (of_property_read_bool(np, "arm,parity-enable")) {
 		mask |=3D AURORA_ACR_PARITY_EN;
 		val |=3D AURORA_ACR_PARITY_EN;
--=20
2.22.0

