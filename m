Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9512622C43F
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jul 2020 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGXLUa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Jul 2020 07:20:30 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:56516 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgGXLU3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Jul 2020 07:20:29 -0400
IronPort-SDR: +mN8OmgKNqY8FGU2mp2llN6LXlD8infC3173m6xTi/aqnan2hYx9I8Yhb0cmfexEzDoREDr5n/
 bMq+wZcrRmk+4NgGQnvzRZwWyxfttrGMIupyrAOBfa0r3WcLyDNDfo9IxBNkL1cTCXpIcyHI7k
 kG3P5pX3RWOmxDuEpGWXQy1SNSN/pypu7hBSNyWEeGGLwbXC50LzKJ7QxsAfTYDcTKOlqxiVAF
 lIuA5UMiZqCgO4nwrppYlRIxSw/m88gLCnArqr990weAN7md5bqPuNeSMMRAq2IhhbphjhANtu
 u+g=
X-IronPort-AV: E=Sophos;i="5.75,390,1589234400"; 
   d="scan'208";a="13228502"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Jul 2020 13:20:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 24 Jul 2020 13:20:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 24 Jul 2020 13:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1595589624; x=1627125624;
  h=from:to:cc:subject:date:message-id;
  bh=gBgGUJe7SvJAq1Z9RuFP5VQ/8iajrgNUuzmMJsiS5Ew=;
  b=G2BoOrHOhucrUCnJ+x8jw9Lpm9vtAX4Tqpo6Oq7PO7rrBUfogv4VBmEe
   BLjBxa8c1T/5oDQrjgIYDthH4p64grWpTfPY5OrCUwtSd/SADUg7adrx5
   qMt5Lvp5qBYyJLDrD7YFUOf6SBVltQ5G2/D0MzIkxC+af/y7YnV5zNtCy
   sQFoa/3TPz5UPsanoO4x9Y9M03P/Vlppmfo3vIp1F+qDT3k++hinazBh6
   otxGaH/bWNgQCa/iG5uB+fYHH6rD7LDtXYJktIvmxIYy7gg0ijWd+ky6E
   NCHd+6aZzEvkxL45juTE87uTW79+32juSYc21SuS/jw3lE98Pg8l4WeS1
   g==;
IronPort-SDR: isC0Ja7bsaxbNXRgTWuxn2sP58DGikXYGgUtTouH87DQh/OG7S6k7LzRiUoDZhXw59VXIhe/AP
 GqBWlLP7TSl1BC1o3nF27tUot883dEge2EFuS9JwFLDMYcNDq9b2EuAgqEWCcbzqpqA4z8tWQw
 46kiaLwNDLDaAtVSNT6azPlyclrVzXw/AhC54mLzJMGOqCqmSy2VY0bjuOKuOyg+Pf7A94Mkr5
 nDE/ZgPnwzToqwxxtYeGJCZVqzkAH56U/9K8Jr5CxOGyrsQozmc6P1wf1PKZPS0WwoiGkv1IXg
 2x0=
X-IronPort-AV: E=Sophos;i="5.75,390,1589234400"; 
   d="scan'208";a="13228501"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Jul 2020 13:20:24 +0200
Received: from herburgerg-w.tq-net.de (herburgerg-w.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 31CA0280065;
        Fri, 24 Jul 2020 13:20:24 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     york.sun@nxp.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH 1/1] edac: fsl_ddr_edac: fix expected data message
Date:   Fri, 24 Jul 2020 13:18:46 +0200
Message-Id: <20200724111846.24432-1-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In some cases a wrong 'Expected Data' is calculated and reported.
When comparing Expected/Captured Data this looks like dual bit errors when
only a single bit error occurred.

On my aarch64 machine it prints something similar to this:
[  311.103794] EDAC FSL_DDR MC0: Faulty Data bit: 36
[  311.108490] EDAC FSL_DDR MC0: Expected Data / ECC:   0xffffffef_ffffffff / 0x80000059
[  311.116135] EDAC FSL_DDR MC0: Captured Data / ECC:   0xffffffff_ffffffef / 0x59

Fix this by only shift the register where the error occurred.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/edac/fsl_ddr_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 6d8ea226010d..4b6989cf1947 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -343,9 +343,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 
 		fsl_mc_printk(mci, KERN_ERR,
 			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+			(bad_data_bit > 31) ? cap_high ^ (1 << (bad_data_bit - 32)) : cap_high,
+			(bad_data_bit <= 31) ? cap_low ^ (1 << (bad_data_bit)) : cap_low,
+			(bad_ecc_bit != -1) ? syndrome ^ (1 << (bad_ecc_bit)) : syndrome);
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,
-- 
2.17.1

