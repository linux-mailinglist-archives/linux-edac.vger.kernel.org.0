Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DE4ED7A8
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiCaKPZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiCaKPY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 06:15:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D71A5;
        Thu, 31 Mar 2022 03:13:37 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KTfJw1hScz9sSK;
        Thu, 31 Mar 2022 12:13:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yqMkGpmu4eRn; Thu, 31 Mar 2022 12:13:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KTfJw0kq8z9sS8;
        Thu, 31 Mar 2022 12:13:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 057648B788;
        Thu, 31 Mar 2022 12:13:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RnsNm-xpBB6N; Thu, 31 Mar 2022 12:13:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.54])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC85F8B780;
        Thu, 31 Mar 2022 12:13:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22VADLir548128
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 12:13:21 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22VADJx1548126;
        Thu, 31 Mar 2022 12:13:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/85xx: Remove fsl,85... bindings
Date:   Thu, 31 Mar 2022 12:13:10 +0200
Message-Id: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648721588; l=3831; s=20211009; h=from:subject:message-id; bh=vGHHyyqAvTlkbKM83RyvQiGuZKiDG+ZcFAXqj4DBm0s=; b=qT9xl0TFxnQZPJzGGdZeuS+z9K8siQA5PCCUQk4FeouIrQNQoAP/b+99e3dQQ4zMXS3knWIxn+eo FgBoJKLmDOWS+OF6TIED5JBW45vpP+0qXjJulpC+EoUAl/xzEAIU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since commit 8a4ab218ef70 ("powerpc/85xx: Change deprecated binding
for 85xx-based boards"), those bindings are not used anymore.

A comment in drivers/edac/mpc85xx_edac.c say they are to be removed
with kernel 2.6.30.

Remove them now.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  6 ------
 .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  6 ------
 drivers/edac/mpc85xx_edac.c                        | 14 --------------
 3 files changed, 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
index af5147f9da72..84f778a99546 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
@@ -25,12 +25,6 @@ properties:
           - const: fsl,qoriq-memory-controller
       - enum:
           - fsl,bsc9132-memory-controller
-          - fsl,8540-memory-controller
-          - fsl,8541-memory-controller
-          - fsl,8544-memory-controller
-          - fsl,8548-memory-controller
-          - fsl,8555-memory-controller
-          - fsl,8568-memory-controller
           - fsl,mpc8536-memory-controller
           - fsl,mpc8540-memory-controller
           - fsl,mpc8541-memory-controller
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
index 8a70696395a7..22ad012660e9 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
@@ -6,12 +6,6 @@ The cache bindings explained below are Devicetree Specification compliant
 Required Properties:
 
 - compatible	: Should include one of the following:
-		  "fsl,8540-l2-cache-controller"
-		  "fsl,8541-l2-cache-controller"
-		  "fsl,8544-l2-cache-controller"
-		  "fsl,8548-l2-cache-controller"
-		  "fsl,8555-l2-cache-controller"
-		  "fsl,8568-l2-cache-controller"
 		  "fsl,b4420-l2-cache-controller"
 		  "fsl,b4860-l2-cache-controller"
 		  "fsl,bsc9131-l2-cache-controller"
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 67f7bc3fe5b3..5bf92298554d 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -609,13 +609,6 @@ static int mpc85xx_l2_err_remove(struct platform_device *op)
 }
 
 static const struct of_device_id mpc85xx_l2_err_of_match[] = {
-/* deprecate the fsl,85.. forms in the future, 2.6.30? */
-	{ .compatible = "fsl,8540-l2-cache-controller", },
-	{ .compatible = "fsl,8541-l2-cache-controller", },
-	{ .compatible = "fsl,8544-l2-cache-controller", },
-	{ .compatible = "fsl,8548-l2-cache-controller", },
-	{ .compatible = "fsl,8555-l2-cache-controller", },
-	{ .compatible = "fsl,8568-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8536-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8540-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8541-l2-cache-controller", },
@@ -644,13 +637,6 @@ static struct platform_driver mpc85xx_l2_err_driver = {
 };
 
 static const struct of_device_id mpc85xx_mc_err_of_match[] = {
-/* deprecate the fsl,85.. forms in the future, 2.6.30? */
-	{ .compatible = "fsl,8540-memory-controller", },
-	{ .compatible = "fsl,8541-memory-controller", },
-	{ .compatible = "fsl,8544-memory-controller", },
-	{ .compatible = "fsl,8548-memory-controller", },
-	{ .compatible = "fsl,8555-memory-controller", },
-	{ .compatible = "fsl,8568-memory-controller", },
 	{ .compatible = "fsl,mpc8536-memory-controller", },
 	{ .compatible = "fsl,mpc8540-memory-controller", },
 	{ .compatible = "fsl,mpc8541-memory-controller", },
-- 
2.35.1

