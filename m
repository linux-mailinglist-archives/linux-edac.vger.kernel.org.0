Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059B7252E8A
	for <lists+linux-edac@lfdr.de>; Wed, 26 Aug 2020 14:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgHZMPl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Aug 2020 08:15:41 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:47994 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729373AbgHZMPl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Aug 2020 08:15:41 -0400
Received: from localhost.localdomain (unknown [210.32.144.184])
        by mail-app3 (Coremail) with SMTP id cC_KCgCXP6gxUkZfNt8_Aw--.39637S4;
        Wed, 26 Aug 2020 20:14:44 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ericsson.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: i5100_edac: Fix error handling code in i5100_init_one
Date:   Wed, 26 Aug 2020 20:14:37 +0800
Message-Id: <20200826121437.31606-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgCXP6gxUkZfNt8_Aw--.39637S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rCrWrXFyUuw17WFW8Xrb_yoW8Gr4xpr
        9xG34fAry8WayY9r1UAr18XF15tFWqva43KFWxC3yag3ZxZFyktFWSqay7CFnFvFWkJFW3
        Xwn7ta48uF18AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVAFwVW5JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5rWrDUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0EBlZdtPrBDAAKsP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When pci_get_device_func() fails, we don't need to execute
pci_dev_put(). But mci should be freed to prevent memleak.
When pci_enable_device() fails, we don't need to disable
einj either.

Fixes: 52608ba205461 ("i5100_edac: probe for device 19 function 0")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/edac/i5100_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 191aa7c19ded..410bbe55cd3f 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -1061,13 +1061,13 @@ static int i5100_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 				    PCI_DEVICE_ID_INTEL_5100_19, 0);
 	if (!einj) {
 		ret = -ENODEV;
-		goto bail_einj;
+		goto bail_free;
 	}
 
 	rc = pci_enable_device(einj);
 	if (rc < 0) {
 		ret = rc;
-		goto bail_disable_einj;
+		goto bail_einj;
 	}
 
 
@@ -1136,14 +1136,14 @@ static int i5100_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 bail_scrub:
 	priv->scrub_enable = 0;
 	cancel_delayed_work_sync(&(priv->i5100_scrubbing));
-	edac_mc_free(mci);
-
-bail_disable_einj:
 	pci_disable_device(einj);
 
 bail_einj:
 	pci_dev_put(einj);
 
+bail_free:
+	edac_mc_free(mci);
+
 bail_disable_ch1:
 	pci_disable_device(ch1mm);
 
-- 
2.17.1

