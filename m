Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD7B587ABA
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiHBKbJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiHBKbC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 06:31:02 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C858B49A;
        Tue,  2 Aug 2022 03:31:00 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Lxrqk6BQ2z9sj9;
        Tue,  2 Aug 2022 12:30:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UkjpvLsEMlqe; Tue,  2 Aug 2022 12:30:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Lxrqk5TZRz9sj8;
        Tue,  2 Aug 2022 12:30:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC53A8B774;
        Tue,  2 Aug 2022 12:30:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hS7Kwt6VBiCs; Tue,  2 Aug 2022 12:30:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.234.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F5E88B76D;
        Tue,  2 Aug 2022 12:30:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 272AUn2L2286835
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 2 Aug 2022 12:30:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 272AUlTO2286788;
        Tue, 2 Aug 2022 12:30:47 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     linux-edac@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] EDAC/ppc_4xx: Include required of_irq header directly
Date:   Tue,  2 Aug 2022 12:30:38 +0200
Message-Id: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1659436218; l=905; s=20211009; h=from:subject:message-id; bh=cKpEoB+cofUpoNAq/M/B3Dp8umJsSlsnWcCGFfflJZk=; b=maWXA7spO7ssoHS3X+jZ3jVuxKdR9ZNtix08JrXhYGlvQIxvLuwO9XyN8ZbBwxxTIdKZuMY2fjR8 b/CRzA8VCYUFqrw3lSwjdmp+Sl+YZp78oX/fgNYDRKcsM4QBYEf2
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h
and asm/pci.h") that cleans up powerpc's asm/prom.h leads to build
errors in ppc4xx_edac.c due to missing header. Include required
header directly to avoid the build failure.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/edac/ppc4xx_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 6793f6d799e7..0bc670778c99 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/types.h>
 
-- 
2.36.1

