Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6466E366D47
	for <lists+linux-edac@lfdr.de>; Wed, 21 Apr 2021 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbhDUNzl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Apr 2021 09:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbhDUNzl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Apr 2021 09:55:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC6B611F2;
        Wed, 21 Apr 2021 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013307;
        bh=JD5ziEk/FB8CNzMad7zbcOvmZivcvUwNl7nwAGloB5w=;
        h=From:To:Cc:Subject:Date:From;
        b=i0gTfVfze0/PUJiMP682KpT9c250YJgN8nYi7fAF1ZSJklOTRE7NrVvG0j+02PR45
         Ls4m1q+1KehLZmP8q3ld7gfP5y5ufPdyN8SFN0xnzE22DmWq4tAfQEbrSKcfQeH4U2
         zkaX3jmIYXWFa2dQ1RJsAZWtXW1pKR1xeZ/E4tmsKb/AADmC5HcISI008N6qAZb3hp
         2UrWjqEd0UOtC9nVlQesswvXD9QYKaUYqvPXazujPkCfwoY2LwvAQ+dFR+KNXMakFD
         MK0Ms+CkWg9nJuuzex4fZo4CxhWInZ1CFfIWxmUYk1GrFNmtLg13+tdKO4MFpJni6A
         ZJX8EbmUw/AdA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Joel Stanley <joel@jms.id.au>,
        Troy Lee <troy_lee@aspeedtech.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/aspeed: use proper format string for printing resource
Date:   Wed, 21 Apr 2021 15:54:53 +0200
Message-Id: <20210421135500.3518661-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On ARMv7, resource_size_t can be 64-bit, which breaks printing
it as %x:

drivers/edac/aspeed_edac.c: In function 'init_csrows':
drivers/edac/aspeed_edac.c:257:28: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
  257 |         dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",

Use the special %pR format string to pretty-print the entire
resource instead.

Fixes: edfc2d73ca45 ("EDAC/aspeed: Add support for AST2400 and AST2600")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/aspeed_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index a46da56d6d54..6bd5f8815919 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -254,8 +254,8 @@ static int init_csrows(struct mem_ctl_info *mci)
 		return rc;
 	}
 
-	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
-		r.start, resource_size(&r), PAGE_SHIFT);
+	dev_dbg(mci->pdev, "dt: /memory node resources: first page %pR, PAGE_SHIFT macro=0x%x\n",
+		&r, PAGE_SHIFT);
 
 	csrow->first_page = r.start >> PAGE_SHIFT;
 	nr_pages = resource_size(&r) >> PAGE_SHIFT;
-- 
2.29.2

