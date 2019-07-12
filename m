Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BA6653D
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfGLDtm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:42 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38365 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfGLDtS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:18 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 56C2C891B5;
        Fri, 12 Jul 2019 15:49:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903355;
        bh=BJ2SJfxvV+LPkP/KkZxVCosBZT+65HxPtxnVwz2cPQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wJbd1FHymZGn9JDXfHO74bsoIRhlneIm7XlZg2GupITaSg6T/cAnm3A5hkWbCzb9m
         lR9Y8Ykt1sQ6Us/v2exkX6P4skTKHDY2SpKFppHqYdH4+unUatB+AgSbm/088POQLx
         9b4k/ogaOdrlMwYXVGPr992fSTNa5XFCHGOt2QRF98S4FFaqbPnAFQ2eiVp94vLX2B
         xeSthFzfmP+QO1hiW127U/Q2uzj/ZThiKVPAuNv0g+DZ7vk/Gw0l0SeJqi6RmuV+iC
         Egey5bzKSdhyWqhGxZvSp168p/rT7sXMmVief2D0saERAr8KghdODmTORMh7UdHXbN
         09EQdOIkbW05w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0008>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 23E0213EF9E;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5B8351E1D82; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 8/8] EDAC: armada_xp: Add support for more SoCs
Date:   Fri, 12 Jul 2019 15:49:04 +1200
Message-Id: <20190712034904.5747-9-chris.packham@alliedtelesis.co.nz>
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

The Armada 38x and other integrated SoCs use a reduced pin count so the
width of the SDRAM interface is smaller than the Armada XP SoCs. This
means that the definition of "full" and "half" width is reduced from
64/32 to 32/16.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/edac/armada_xp_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.=
c
index 3759a4fbbdee..7f227bdcbc84 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -332,6 +332,11 @@ static int axp_mc_probe(struct platform_device *pdev=
)
=20
 	axp_mc_read_config(mci);
=20
+	/* These SoCs have a reduced width bus */
+	if (of_machine_is_compatible("marvell,armada380") ||
+	    of_machine_is_compatible("marvell,armadaxp-98dx3236"))
+		drvdata->width /=3D 2;
+
 	/* configure SBE threshold */
 	/* it seems that SBEs are not captured otherwise */
 	writel(1 << SDRAM_ERR_CTRL_THR_OFFSET, drvdata->base + SDRAM_ERR_CTRL_R=
EG);
--=20
2.22.0

