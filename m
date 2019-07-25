Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458C8753B4
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2019 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfGYQRq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jul 2019 12:17:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfGYQRq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Jul 2019 12:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YeWUVHzUnbVi15A0M7gIPQwXS4K0+cqPBBcbBnuSLlw=; b=GJEVo9syQdeELHFTQkzyUhcFo
        b1IYW/CLBgY0wo0MBDlsvySWVjqqrZXoy3c27LHJvPJWyOPakF344QKnMtDStIJpuKlM4UCOVi1mP
        P6ueXrcUROE/j1CX+4U1Yq8ZnX7xl3d7UxjdEesYCBdxKpM3B7yh4PGw9TUb3PlZn3ASr/MoYGLVk
        3cvK/yzKa2t84HXndTT6jUkvwfQA6hhd23Bx727izcP/LTLF/Jbt7QMN6KSYYF+5I9m1tAYw96/4l
        X9ybMqb05rj7KAXH/CQF1Sr+W42HwjjPaTOnmSZ1wIQ+RZiQrvhDecY96/9xT3byd4Ug5Wp/ZTiB0
        Wh71Ed3NA==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqgR7-0007w4-BD; Thu, 25 Jul 2019 16:17:45 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hqgR5-000APJ-3U; Thu, 25 Jul 2019 12:17:43 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] MAINTAINERS: update EDAC entry to reflect current tree and maintainers
Date:   Thu, 25 Jul 2019 12:17:35 -0400
Message-Id: <1eb2d09e58500bef18428e2b3f52b54d3cd707d5.1564071419.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Tony will start to officially maintain EDAC trees. Also, we'll
be using a single tree for the EDAC development.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..7c22905b5aba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5781,10 +5781,10 @@ F:	drivers/edac/thunderx_edac*
 EDAC-CORE
 M:	Borislav Petkov <bp@alien8.de>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
+M:	Tony Luck <tony.luck@intel.com>
 R:	James Morse <james.morse@arm.com>
 L:	linux-edac@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git for-next
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac.git linux_next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
 S:	Supported
 F:	Documentation/admin-guide/ras.rst
 F:	Documentation/driver-api/edac.rst
-- 
2.21.0


