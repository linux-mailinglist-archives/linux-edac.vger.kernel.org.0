Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346CA105A83
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUTlN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 14:41:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45610 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUTlN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Nov 2019 14:41:13 -0500
Received: by mail-io1-f66.google.com with SMTP id v17so4835104iol.12;
        Thu, 21 Nov 2019 11:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rTdqumcx4hyAoyV5+43F9AC3ezcwjCUap0sK21MadY8=;
        b=AZpkqB7xJCxl8Cf2MphTC6AjnJoPvgotZF7k80BNtY6UYxPYqXr76qZQgQFoOX/hGa
         Wkhu9gdcdNVBPD9oHvhSCjPvxyMN8CuQccMYPqKmim1ojnijYE1so5jnWkyc7aDOrKc+
         SMrL2SVBrbpnBd3LT/7+6hqzF8wE3/WOt5yoGM19wh/DcQWrOxd8XkWDnm4KwCQ2aktj
         AJtsqq7n62HjoFYEEzmK7iVj7iqebjg2Eqr6okD1roWdXsB2zg4HO/05VYzBoslcywkt
         R2r80GLQDT6FyJJE10tAgdNZienguWytyj29vhmZQ3MyKA8wdToEI1jyWZkk+OAuh1wR
         d+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rTdqumcx4hyAoyV5+43F9AC3ezcwjCUap0sK21MadY8=;
        b=fEGRz8/TO6q8mlbav7NmXpiI5uqZrBeDSXTVnEF3TmjhLB9GkRVKmh7P37ojXxq1Kn
         W61DIjf/RDWrVFhOPa2yDGaXXck5kPsFfsx1vAgqClnOKY1gaYgI0CLbAyd6pxAvN0jx
         0HFXF4kuNwDocXKSQDxw2KjXFHtcDPDC4JLDL/sLAOB/SQmLRXCZPD91WBXaG4xwbdKA
         d+dqnNRrzSOkiYwtHn9zWPXkvGW/KD8AtSCu8Z3xSTgDdlJdJL0xSDR4MvT9NrsCp6+z
         WdKdWnF4R4ehS3w87pBvl+rYCBWYVOArWWnBTXVGtOvv9++hfzfdC+QcY3GWFPBKCiDW
         atow==
X-Gm-Message-State: APjAAAXfEDtJSNwyN2kJR2oPrXg4kSN6/g16n4Dh5jRlB6c2u/iw8Bdx
        eyztWoCmBt0PTClkKzsYqWM=
X-Google-Smtp-Source: APXvYqy/vP9BhqNyhJvf4gRGdP5QPQNsW3eF1kA8NfMV6/o0HVljPXwdY6Ce4mFIo1Ph2HV9Fnr02g==
X-Received: by 2002:a6b:b88a:: with SMTP id i132mr9670189iof.1.1574365272450;
        Thu, 21 Nov 2019 11:41:12 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id e5sm1588104ilq.77.2019.11.21.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:41:11 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] EDAC: Fix memory leak in i5100_init_one
Date:   Thu, 21 Nov 2019 13:40:41 -0600
Message-Id: <20191121194043.22378-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In the implementation of i5100_init_one(), the allocated mci is not
correctly released in cases of failure. The release via edac_mc_free()
should be reached by label bail_einj and subsequents.

Fixes: 52608ba20546 ("i5100_edac: probe for device 19 function 0")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/edac/i5100_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 251f2b692785..710fabd5fba1 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -1149,12 +1149,12 @@ static int i5100_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 bail_scrub:
 	priv->scrub_enable = 0;
 	cancel_delayed_work_sync(&(priv->i5100_scrubbing));
-	edac_mc_free(mci);
 
 bail_disable_einj:
 	pci_disable_device(einj);
 
 bail_einj:
+	edac_mc_free(mci);
 	pci_dev_put(einj);
 
 bail_disable_ch1:
-- 
2.17.1

