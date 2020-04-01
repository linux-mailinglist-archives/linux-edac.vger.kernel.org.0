Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D516219A3C3
	for <lists+linux-edac@lfdr.de>; Wed,  1 Apr 2020 05:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbgDADGL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 31 Mar 2020 23:06:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43176 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgDADGK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 31 Mar 2020 23:06:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so24136364ljn.10;
        Tue, 31 Mar 2020 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Cncm8QU/gApJJ/eq3r8THmKymRZL/LY9q5cgRTKRs5I=;
        b=VGtHmylzeqk02q6/FH1ZxxNVuU3blaX1gcapU99VOoalOqQhhGq5dx/euBjGrVPcz8
         cG5HoNR42w/6abzq/JT1XUPZFQqOeRHt5gAmsYGFYo8U8qh1U+DT8zVvWrLqsgrbRc0C
         8c9JyziOiXdH29NqE1kzBou4mae7doLVUd2eTweKZxoWKYRDwZ5uf3oe5RK8HYum9y/H
         CDtQwUVpie6ONcKdyxxaS/9wxAnZK2SFm71Neoekh8xURrVDIQ12GutJi+OV2H1O0+0A
         UkpX5tYeqvAvTOUxCAjY2DZsPUFAb8AwxvlN6YDRbYndkCgtg6DUg98GHRz8E1V/Ep6O
         UIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Cncm8QU/gApJJ/eq3r8THmKymRZL/LY9q5cgRTKRs5I=;
        b=RM2XvgbNrr7ZzX+2EAoaNTQodPNUWoPDc3hkiTjHOcseSNoJ2zWuVY8GLpKPcmbYyX
         aUjCkj4+q7CbER0aB8qMsWeAw9kIEXCe33BUZ89vkh+1d6Hri3hiqSHM7xc43/ScTdRU
         jBug6B29oSly4kdsKKDmA7FO199Qf4vkKKjNi0/OsaaZyfweUwr3sOF6ansoQPtNwSru
         PX1AYIODDbWo6WaEOFHkY52ERl2RWTcDgnxzI9zyCeVi3DkXToWEYXBnCvpewBOhmCGK
         XlsAflUfKyIYFkrQxugIkyIx2QZzm0lqBwh/4Q7Mis9W6S99zpqaL9zHtc0AwbZPLuba
         Y6Sw==
X-Gm-Message-State: AGi0PuYRoFgtTUP+VVKQpgtdf6wcJHtxVLCJntIZ9AMbl6J8VT6myOH1
        Fm0GQHUClk/5PCXtG0nXo9if49klu7LrtqwR9Ec=
X-Google-Smtp-Source: APiQypLI+1TSCwhyI5FaKsxRC08UvwMys/ji4hC4ScQIHFamJxow8zZZfWKmfWcrcTAoFT8MSfsJcfSVAJVGZhOfQc8=
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr11839809lji.150.1585710366578;
 Tue, 31 Mar 2020 20:06:06 -0700 (PDT)
MIME-Version: 1.0
From:   "she90122 ." <she90122@gmail.com>
Date:   Wed, 1 Apr 2020 11:05:55 +0800
Message-ID: <CAMhTFwk8Ei3o8Zwo+gZHzjv+hHtpfeWeOxFqu2s2QpaH6H2bVA@mail.gmail.com>
Subject: [v3,1/1] EDAC: (pnd2) Change the return value of function
 apl_check_ecc_active() & dnv_check_ecc_active() when installed the non-ECC
 memory device.
To:     she90122 <she90122@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Amy.Shih" <Amy.Shih@advantech.com.tw>,
        "Oakley.Ding" <Oakley.Ding@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

Set function apl_check_ecc_active() &
dnv_check_ecc_active() to return -ENXIO when installed the non-ECC
memory device. And print the message in pnd2_init() accordingly.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
Changes in v3:
- Change the return value of function check_ecc when installed the
non-ECC memory device.
Changes in v2:
- Remove the word "error" from output message.
---
 drivers/edac/pnd2_edac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
933f772..27172d7 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1089,7 +1089,7 @@ static int apl_check_ecc_active(void)
  for (i = 0; i < APL_NUM_CHANNELS; i++)
  if (chan_mask & BIT(i))
  ret += check_channel(i);
- return ret ? -EINVAL : 0;
+ return ret ? -ENXIO : 0;
 }

 #define DIMMS_PRESENT(d) ((d)->rken0 + (d)->rken1 + (d)->rken2 +
(d)->rken3) @@ -1111,7 +1111,7 @@ static int
dnv_check_ecc_active(void)

  for (i = 0; i < DNV_NUM_CHANNELS; i++)
  ret += check_unit(i);
- return ret ? -EINVAL : 0;
+ return ret ? -ENXIO : 0;
 }

 static int get_memory_error_data(struct mem_ctl_info *mci, u64 addr,
@@ -1572,7 +1572,12 @@ static int __init pnd2_init(void)

  rc = pnd2_probe();
  if (rc < 0) {
- pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+ if (rc == -ENXIO)
+ pnd2_printk(KERN_INFO, "System is not using ECC memory\n");
+ else
+ pnd2_printk(KERN_ERR,
+     "Failed to register device with error %d.\n",
+     rc);
  return rc;
  }

--
1.8.3.1
