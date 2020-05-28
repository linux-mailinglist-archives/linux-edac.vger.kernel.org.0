Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEB1E6CAF
	for <lists+linux-edac@lfdr.de>; Thu, 28 May 2020 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407320AbgE1Ufp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 May 2020 16:35:45 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33088 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407311AbgE1Ufe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 May 2020 16:35:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49Xzwk2HDrz9vmdT
        for <linux-edac@vger.kernel.org>; Thu, 28 May 2020 20:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ceajXPrAVomt for <linux-edac@vger.kernel.org>;
        Thu, 28 May 2020 15:35:34 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49Xzwk0djrz9vmdM
        for <linux-edac@vger.kernel.org>; Thu, 28 May 2020 15:35:34 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49Xzwk0djrz9vmdM
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49Xzwk0djrz9vmdM
Received: by mail-io1-f70.google.com with SMTP id a11so47154ioq.13
        for <linux-edac@vger.kernel.org>; Thu, 28 May 2020 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mqu7gI4QVys8rtXwsMUtQ4ipaqsDcZVMy4ODpZfEEB4=;
        b=Qar0iZGnZTOmqVYbtvV6Bqi3LAkl3rpcSO2bfkQuHgwL1hZF0//9lMQMlMJTwceFvL
         XSq/fO0OV0Wfc/J7UGGZDZgR9ltgK2yz81m68ZYAxqQJSGhEXFR4ATTa4mHldJ2dhBry
         nXiC0IrJzyijGnzaiLgjXlp9aDcEzZCEeuha3bsIpBoLeLWPeayFqFvUryomq9DHPIoR
         EEG2hkh1oTANinUNsd9A8P5MBvJS5svc2vt/zx6hEqC3Nt4hpEHvuSzdIhYGCvk/V/yA
         ElDHwhpT7MLOi6EZ8s/v2P2wfK49Tmk4a+t4Q+iafHlY1rcVa6C1oNrWWUfuQW9dVO7l
         nCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mqu7gI4QVys8rtXwsMUtQ4ipaqsDcZVMy4ODpZfEEB4=;
        b=pXyQgOAXitl1aCPhKiAZujHaoNhy9VjHHr3oEyfHPJJU8ay5j2B5/e8k8xPUXZEL6E
         zZ/1UkdV/+kbVeVFERNB/lKWL5+7z8zkvVWzdW8maiTrwyiXPeTPPf6e3KsSaafWy9LJ
         eF8MldkAqnNEpvxJX159POqfzCUbEf7A2uR6GxH+l4Di8xZb96/El+y6oA1vHQQ7tpT4
         4+xq2OK3XMQuTREuayRfx/l8z438jZYAIiDeavE/Kk01dYGxuqUzZBbay2xnY3Jm4d16
         7zNihly0TznntN8zsJrQgHFrIgx6/7FXiItfxQtt1kM/gZCgG807DpUwnMDOQBBpC/RL
         feRw==
X-Gm-Message-State: AOAM532hfCp/CaLpdwFCgdSgGgg4AFV0aA+9kRn3zSqkWp/2/eUZehF3
        3dGK+l5VnlTfZl9VQsd+4aH0ixVy+loPK9LTXaD5vcV6mP9IBvwnQygjUApcNTHWsJAFRE8XD2T
        2DSmuq2l7SXtwuxUOTafcDleSzw==
X-Received: by 2002:a92:b0d:: with SMTP id b13mr4533082ilf.225.1590698132457;
        Thu, 28 May 2020 13:35:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVTzTdO4UtcoTiTguZKte9c73KtyMrLZemXQsrQkcm5GCYIsZ7eSH3Lp2M+AWyg8VqZX3J0g==
X-Received: by 2002:a92:b0d:: with SMTP id b13mr4533057ilf.225.1590698132154;
        Thu, 28 May 2020 13:35:32 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id 17sm3671353ill.14.2020.05.28.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:35:31 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] edac: Fix reference count leak in edac_device_register_sysfs_main_kobj.
Date:   Thu, 28 May 2020 15:35:26 -0500
Message-Id: <20200528203526.20908-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() should be handled when it return an error,
because kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/edac/edac_device_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 0e7ea3591b78..5e7593753799 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -275,6 +275,7 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 
 	/* Error exit stack */
 err_kobj_reg:
+	kobject_put(&edac_dev->kobj);
 	module_put(edac_dev->owner);
 
 err_out:
-- 
2.17.1

