Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6816119B64
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEJKPn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:15:43 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47643 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfEJKPn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 May 2019 06:15:43 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D7C10891AE;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557483340;
        bh=vwc1YfUtcojvhLFHHpCxjQw0m2BEKd7mFTY7Bja52pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KJP+zxpR724yy88dudp+bMh4tPzOvNM7mrSj8K9sEsmWbgyM+vvmkmRMg6bnX8hVX
         y7+ayiSVkx+nUpyKLKR91mDesR9TKxZPp2RAV5/BaI5bb7ke8Uf6CvbjGsRoIYnuv1
         5fYB06h6vSAeRzMctUna9hCiDmBTfuJDSS1Qd2qubSq0HZ0O0NEIYiQAruMe9PW0WL
         098EHjlN434xQPLAX4nz7tI7PK3ZqgX9OcOrtPn+CJD9z3N4J2Bq0ELxmLgZSAgw67
         0lFAUywtE6sxR6U5T3zuwbUZddd9QVwqDxKXQNFMkU7Rn235wKcEmio77mddQOea7i
         OuDIOumkjVvsQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd54f4d0000>; Fri, 10 May 2019 22:15:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 2F7E113EF9D;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id B8CCB1E1D5B; Fri, 10 May 2019 22:15:39 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, mark.rutland@arm.com,
        robh+dt@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 5/9] dt-bindings: ARM: document marvell,ecc-enable binding
Date:   Fri, 10 May 2019 22:15:32 +1200
Message-Id: <20190510101536.6724-6-chris.packham@alliedtelesis.co.nz>
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

Add documentation for the marvell,ecc-enable properties which can be
used to enable ECC on the Marvell aurora cache.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v7:
    - remove marvell,ecc-disable
    Changes in v6:
    - new (split binding doc from implementation).

 Documentation/devicetree/bindings/arm/l2c2x0.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.yaml b/Document=
ation/devicetree/bindings/arm/l2c2x0.yaml
index bfc5c185561c..913a8cd8b2c0 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.yaml
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.yaml
@@ -176,6 +176,10 @@ properties:
     description: disable parity checking on the L2 cache (L220 or PL310)=
.
     type: boolean
=20
+  marvell,ecc-enable:
+    description: enable ECC protection on the L2 cache
+    type: boolean
+
   arm,outer-sync-disable:
     description: disable the outer sync operation on the L2 cache.
       Some core tiles, especially ARM PB11MPCore have a faulty L220 cach=
e that
--=20
2.21.0

