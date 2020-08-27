Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92304253FF9
	for <lists+linux-edac@lfdr.de>; Thu, 27 Aug 2020 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgH0H7I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Aug 2020 03:59:08 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:8942 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgH0H7G (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 03:59:06 -0400
IronPort-SDR: pcQTABDNzCOEZzVXUHdHR+VQg279JaBcMZMVpmFp4+RY4P0r8TpEUcqSdNCdiuaTz3lvgfF1i4
 VQGOE+SdLDOXfrYRNsEiW6Tj/20R0aSR5ayzhL411S0jeVhK2GMjl109fPURBGKpp2/iz2hi7F
 MHfRoSRZuQV/DzQs9bdPtrUe2SnnCcCU34ppC76d5FifhrDGvKKWHoNMJSB3QJCb5h8m8o9eLd
 /pO7JzSsESETJweFOwkAxRHlf9/nTc9WURJcGlq55bXQYxP6I/0isYsL+T3qKm6HKBFjMBAfYg
 1HM=
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="13619585"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Aug 2020 09:59:04 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Aug 2020 09:59:04 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Aug 2020 09:59:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598515144; x=1630051144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Oe/LRi3jeDUnyT2lJ6K1yeZAK9stHhVflXPfWhtYVhk=;
  b=WufcuUywO6Xag/qsdyaGEbHwJ2O1eqkNNC6SmY0gdYk6N//6LTx88QGN
   SwGDgxRFWn4FsR2mZ1xW2qhXZG4NR0fmEj6lq+kaWt4GkhJVpiS7YvTcf
   D3O8o9tbyXlx0MFoxRHpkKTE2uZ93GMrCaHn/gE6wd7820MevshqGKz6r
   IqvLuEg94FwwKaeXqVIIufVVfbP4i6WX6b8/silxEZDCJhWj6qQMYTgMy
   2D8hCCR3bd71ZxcR1x0CzMzHCnQtx5FPkN/+VuuxMqH2VLAanuVb+OTIn
   TFDIxc0rR46qBt9wa+p0EcNa4pmEvcRALnobIdPjsf/zrXVMpFf2e9J3G
   w==;
IronPort-SDR: 9Fyq4A42C5ZokLxgWBJ4iX6M5+kl8NRn9XLfdUEB/cYGt91pe7DrmnL1p8AsSXFops5VDWXROK
 qsi6nj4l7CNS7dpGwm3jwuBAUBOKPqduAl3H8hsdN4IufG7qqxmQDlSDs2ynggyGaLe9BjboGQ
 51xVYgttTNCkrqObbU5aLLQU2SGYIkixVp2ynyLzUPEPCwb02pyuSYSq/B9Uj1ETxSRMhxk+lC
 1tlUQTRfg1kjnhpb4FMM0jCxvKm1JO1ug3ZtGnuSExTdpxsHfYNynBcTQFwxmEWjV7JRPG/+lD
 cSU=
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="13619584"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Aug 2020 09:59:04 +0200
Received: from herburgerg-w.tq-net.de (herburgerg-w.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C7C1C280065;
        Thu, 27 Aug 2020 09:59:04 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     york.sun@nxp.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data message
Date:   Thu, 27 Aug 2020 09:56:00 +0200
Message-Id: <20200827075600.22335-1-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817095302.GD549@zn.tnic>
References: <20200817095302.GD549@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When a correctable single bit error occurs, the driver calculates the
bad_data_bit respectively the bad_ecc_bit. If there is no error in the
corresponding data, the value becomes -1. With this the expected data
message is calculated.

In the case of an error in the lower 32 bits or no error (-1) the right
side operand of the bit-shift becomes negative which is undefined
behavior.

This can result in wrong and misleading messages like this:
[  311.103794] EDAC FSL_DDR MC0: Faulty Data bit: 36
[  311.108490] EDAC FSL_DDR MC0: Expected Data / ECC:   0xffffffef_ffffffff / 0x80000059
[  311.116135] EDAC FSL_DDR MC0: Captured Data / ECC:   0xffffffff_ffffffef / 0x59

Fix this by only calculating the expected data where the error occurred.

With the fix the dmesg output looks like this:
[  311.103794] EDAC FSL_DDR MC0: Faulty Data bit: 36
[  311.108490] EDAC FSL_DDR MC0: Expected Data / ECC:   0xffffffef_ffffffef / 0x59
[  311.116135] EDAC FSL_DDR MC0: Captured Data / ECC:   0xffffffff_ffffffef / 0x59

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

