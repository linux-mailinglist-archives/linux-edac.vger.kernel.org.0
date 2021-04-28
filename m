Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8646536D494
	for <lists+linux-edac@lfdr.de>; Wed, 28 Apr 2021 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhD1JMm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Apr 2021 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1JMm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Apr 2021 05:12:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF3C061574;
        Wed, 28 Apr 2021 02:11:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lp8so2386129pjb.1;
        Wed, 28 Apr 2021 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iQOGR/2YT8/Z7BrRyEx1F0d6zkucK73DKDrSJaYPxMs=;
        b=AnZhkOW2tSH7XfBDl4GA1Ao6XimYSjF7ybfvw62NWSwrQvNZyEBuyQiRO6vaK9eoLJ
         hmmruyTB71wQDCJY8HSYHbs7O3oWkoXGL13x9peZCv8Bfy+rYtgiWFjx763AZ0927z46
         g2dUsOyz/O76R8aGbnr1vGsXkVJwlLrFSCeJbQFxdp1qCaLvu5bi4bRJB9G9WQeSZ1CO
         d1JAow+qIKwGrNoPxfG9bCkxdRyhUGDiqm33zTfJFkt0SqHqoiC0jnqIrmNzw4HV3/jN
         D5NGYK+0ZeRtlzyD7ejLSjmIQFOK5J69vWAzTri/fwcrzp5sWkL4eqRv+We87Hfc+eyL
         4VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iQOGR/2YT8/Z7BrRyEx1F0d6zkucK73DKDrSJaYPxMs=;
        b=LYeZV9IyRSjFSqpGay4LW6/aUExcoh9cy1/mpxZMEZ0F1kjsaamTTHA2VBZl1ivHKj
         FHyhSHGvzDsP2qQzKt7MHfTgtRStiNUZtnc25eJXg8duVKyVuW7y/0JzGr8I8AIssPXq
         Euq6ynrIu9Ds3I4/MFUDQ2gD0gygQeoalVaxCIITL8xbvZCEfMSqHW+h4d8iGtZOUo1n
         mevWBh4tZP+0fihYfwQJ83KNzpU3yyOzFleQQWGN8YYL5D6uD2S7vmAANm2Il2C1LxGw
         W+b89Rs2rsADp0cv/oUYXU/wJTQiNw7ZCacYoMsaD6pg02VOS9C8l4bzdEK0l2e5hXkV
         UcFg==
X-Gm-Message-State: AOAM532iivJrqoCrCKwY9zD3vUnD2ORj4qKmaWF+AN32EPTtdKP/8EQJ
        B/1+H/qbQZ+AKrdocEGL67o=
X-Google-Smtp-Source: ABdhPJxUV1Ev49YYlRiPWsk1AT7k99z/mOXMbC0yaPajecidZAO3bOgJOWRHOKJ3eOawQSpTf1L6JA==
X-Received: by 2002:a17:90a:f283:: with SMTP id fs3mr3105955pjb.122.1619601116074;
        Wed, 28 Apr 2021 02:11:56 -0700 (PDT)
Received: from localhost ([115.99.221.24])
        by smtp.gmail.com with ESMTPSA id g14sm4408848pjh.28.2021.04.28.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 02:11:55 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:41:50 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove space before tabs
Message-ID: <20210428091150.2c4qymxaxe2k4wqo@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Spaces are removed before tabs to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/edac/edac_pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_pci.c b/drivers/edac/edac_pci.c
index 48c844a72a27..46a68a70d30a 100644
--- a/drivers/edac/edac_pci.c
+++ b/drivers/edac/edac_pci.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(edac_pci_free_ctl_info);
 
 /*
  * find_edac_pci_by_dev()
- * 	scans the edac_pci list for a specific 'struct device *'
+ *	scans the edac_pci list for a specific 'struct device *'
  *
  *	return NULL if not found, or return control struct pointer
  */
@@ -91,11 +91,11 @@ static struct edac_pci_ctl_info *find_edac_pci_by_dev(struct device *dev)
 
 /*
  * add_edac_pci_to_global_list
- * 	Before calling this function, caller must assign a unique value to
- * 	edac_dev->pci_idx.
- * 	Return:
- * 		0 on success
- * 		1 on failure
+ *	Before calling this function, caller must assign a unique value to
+ *	edac_dev->pci_idx.
+ *	Return:
+ *		0 on success
+ *		1 on failure
  */
 static int add_edac_pci_to_global_list(struct edac_pci_ctl_info *pci)
 {
@@ -161,7 +161,7 @@ static void del_edac_pci_from_global_list(struct edac_pci_ctl_info *pci)
 /*
  * edac_pci_workq_function()
  *
- * 	periodic function that performs the operation
+ *	periodic function that performs the operation
  *	scheduled by a workq request, for a given PCI control struct
  */
 static void edac_pci_workq_function(struct work_struct *work_req)
-- 
2.25.1

