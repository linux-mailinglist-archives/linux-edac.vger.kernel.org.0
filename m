Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46D5EAF66
	for <lists+linux-edac@lfdr.de>; Mon, 26 Sep 2022 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIZSOk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Sep 2022 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIZSNx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Sep 2022 14:13:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF022104;
        Mon, 26 Sep 2022 11:03:45 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e74d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e74d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D13D1EC01CE;
        Mon, 26 Sep 2022 20:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664215424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Ax6Qk2VeZ/itYpNnm8xHuzAF57pMAJEdLyn4jvZuAS0=;
        b=I6XdqcYror20urJTlW35hLhzFae49NS/qfGibiERdiemlm4a5eofryEIvvf3h82nHHW1qc
        P5njd7q1RMgqzmGjaV8PSIWAtfaRTZ6xlyGGbqgpB9KBd9HRhZatCsTad4ipts77UvYOgb
        l9detcxoq7FTtCa1ac6fsOAPF+0PhwY=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Make Mauro reviewer
Date:   Mon, 26 Sep 2022 20:03:43 +0200
Message-Id: <20220926180343.23346-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Mauro hasn't really been maintaining EDAC for a long while now. Make him
a reviewer instead.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..935b42c7f52f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7314,9 +7314,9 @@ F:	drivers/edac/thunderx_edac*
 
 EDAC-CORE
 M:	Borislav Petkov <bp@alien8.de>
-M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 M:	Tony Luck <tony.luck@intel.com>
 R:	James Morse <james.morse@arm.com>
+R:	Mauro Carvalho Chehab <mchehab@kernel.org>
 R:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
 S:	Supported
-- 
2.35.1

