Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DB66545
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfGLDtr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:47 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38301 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbfGLDtR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:17 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CD246891B0;
        Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903354;
        bh=wTJ51EYUTFvk33KdvofLjJFSSQts6tpPR315HfRyeYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=irzal8xpOk12NPzl39lBhX7dilHTq0NBDb8PjzdybIx7VPcmyfHCa8bCJzCPKKDPH
         1Dfm+hH7tkgb3AFK90/XFGR4qvj0FkGSW6y2v6HfB/bH2aeYnHZFjw3qxiLko3HUXA
         zxISt3he39fMC4Sbhvytrg7JKCIgojr9cAzgtLkPpr0iGj1HU9ONfz3p5/N05eVCRv
         6AK/7TYti5BhMYEKS/iCv6qytpaIvTafiW4vFp54WYiApOnKFAGsTBsSLw9htKPSvk
         FEEW7XRSw2NzpceSIcC/WzYyWjk7ieeA0YfEPrULralL6+/ICZPSf/Zs0XyR1LzqeB
         4n5BUmEnxBMRg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0002>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 0B9FE13EF59;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 416E51E1D80; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 2/8] ARM: aurora-l2: add defines for parity and ECC registers
Date:   Fri, 12 Jul 2019 15:48:58 +1200
Message-Id: <20190712034904.5747-3-chris.packham@alliedtelesis.co.nz>
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

These defines will be used by subsequent patches to add support for the
parity check and error correction functionality in the Aurora L2 cache
controller.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../include/asm/hardware/cache-aurora-l2.h    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/i=
nclude/asm/hardware/cache-aurora-l2.h
index dc5c479ec4c3..39769ffa0051 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -31,6 +31,9 @@
 #define AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU \
 	(3 << AURORA_ACR_REPLACEMENT_OFFSET)
=20
+#define AURORA_ACR_PARITY_EN	(1 << 21)
+#define AURORA_ACR_ECC_EN	(1 << 20)
+
 #define AURORA_ACR_FORCE_WRITE_POLICY_OFFSET	0
 #define AURORA_ACR_FORCE_WRITE_POLICY_MASK	\
 	(0x3 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
@@ -41,6 +44,51 @@
 #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
 	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
=20
+#define AURORA_ERR_CNT_REG          0x600
+#define AURORA_ERR_ATTR_CAP_REG     0x608
+#define AURORA_ERR_ADDR_CAP_REG     0x60c
+#define AURORA_ERR_WAY_CAP_REG      0x610
+#define AURORA_ERR_INJECT_CTL_REG   0x614
+#define AURORA_ERR_INJECT_MASK_REG  0x618
+
+#define AURORA_ERR_CNT_CLR_OFFSET         31
+#define AURORA_ERR_CNT_CLR		   \
+	(0x1 << AURORA_ERR_CNT_CLR_OFFSET)
+#define AURORA_ERR_CNT_UE_OFFSET          16
+#define AURORA_ERR_CNT_UE_MASK             \
+	(0x7fff << AURORA_ERR_CNT_UE_OFFSET)
+#define AURORA_ERR_CNT_CE_OFFSET           0
+#define AURORA_ERR_CNT_CE_MASK             \
+	(0xffff << AURORA_ERR_CNT_CE_OFFSET)
+
+#define AURORA_ERR_ATTR_SRC_OFF           16
+#define AURORA_ERR_ATTR_SRC_MSK            \
+	(0x7 << AURORA_ERR_ATTR_SRC_OFF)
+#define AURORA_ERR_ATTR_TXN_OFF           12
+#define AURORA_ERR_ATTR_TXN_MSK            \
+	(0xf << AURORA_ERR_ATTR_TXN_OFF)
+#define AURORA_ERR_ATTR_ERR_OFF            8
+#define AURORA_ERR_ATTR_ERR_MSK            \
+	(0x3 << AURORA_ERR_ATTR_ERR_OFF)
+#define AURORA_ERR_ATTR_CAP_VALID_OFF      0
+#define AURORA_ERR_ATTR_CAP_VALID          \
+	(0x1 << AURORA_ERR_ATTR_CAP_VALID_OFF)
+
+#define AURORA_ERR_ADDR_CAP_ADDR_MASK 0xffffffe0
+
+#define AURORA_ERR_WAY_IDX_OFF             8
+#define AURORA_ERR_WAY_IDX_MSK             \
+	(0xfff << AURORA_ERR_WAY_IDX_OFF)
+#define AURORA_ERR_WAY_CAP_WAY_OFFSET      1
+#define AURORA_ERR_WAY_CAP_WAY_MASK        \
+	(0xf << AURORA_ERR_WAY_CAP_WAY_OFFSET)
+
+#define AURORA_ERR_INJECT_CTL_ADDR_MASK 0xfffffff0
+#define AURORA_ERR_ATTR_TXN_OFF   12
+#define AURORA_ERR_INJECT_CTL_EN_MASK          0x3
+#define AURORA_ERR_INJECT_CTL_EN_PARITY        0x2
+#define AURORA_ERR_INJECT_CTL_EN_ECC           0x1
+
 #define AURORA_MAX_RANGE_SIZE	1024
=20
 #define AURORA_WAY_SIZE_SHIFT	2
--=20
2.22.0

