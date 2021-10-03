Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BA420363
	for <lists+linux-edac@lfdr.de>; Sun,  3 Oct 2021 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhJCSSp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Oct 2021 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhJCSSo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Oct 2021 14:18:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B8C061780
        for <linux-edac@vger.kernel.org>; Sun,  3 Oct 2021 11:16:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g2so12590461pfc.6
        for <linux-edac@vger.kernel.org>; Sun, 03 Oct 2021 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GQhMyogHN7y8nehFLIZCJ9ROYU/DzWV4+WI3lnHC9VE=;
        b=HJXXYtLIklgXaY1BKE1WVSZvqJvgRFJ2bq1B/kZyIKmuyJio1QqAerURv3BoGAPnBP
         iFO1Q69rFetDZXN0JzSr5DJVZ7BI8+AlXG1hz+3f9vlBS48Tjk45M0iLdVaYND48Ctnk
         RugsYl8YFR9fUC6fv9pL/2LGvUNSedKbeNlZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GQhMyogHN7y8nehFLIZCJ9ROYU/DzWV4+WI3lnHC9VE=;
        b=RCwL8Ln/pkloP8E0SbwwAlBjI3dPAzSxrgoE1aSieXI+V9qNzTMno+dCODqXt9zeVY
         9TP3UvLAMIi0vDmY1aiz2LlpcnOJisMIBZGEC18coTknEQYhkBwYX5NgDHMH4rZPAnuG
         uF5CrjO2btsai+nVz7CWrJmXhYs54nYIElQ523TtkochKcmMsgfs6Q/sClWhqWjM79Yz
         NaULsHKsoR7oS0MQMAygBv3g422hIm1/hdLn9c779rJ1slocTXThVX1csshXhQcblNdk
         RxstGOM3NV9xYqSo7j1/CkMjwdsEaEvK9GiCXudyhIHaK0odCJeFTGOBBpiWD4o7CQCX
         dpcw==
X-Gm-Message-State: AOAM532eDQCyLQCZqWpY27r8dE9OJz2xsKtfvIEcU/YmBrS3Mu/l5KNf
        MIwJeMEpnM1yv88Njx6DTup9fg==
X-Google-Smtp-Source: ABdhPJyr4km4MCiJoBD0XdidzykZY8m5fGbJA0/LZPs13VQG6nURhAMkwoirnnMoaWuzJeCGvoRjIw==
X-Received: by 2002:a63:e516:: with SMTP id r22mr7622020pgh.197.1633285016627;
        Sun, 03 Oct 2021 11:16:56 -0700 (PDT)
Received: from ebadger-ThinkPad-T590 (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id j7sm11028777pjf.18.2021.10.03.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 11:16:56 -0700 (PDT)
Date:   Sun, 3 Oct 2021 11:16:53 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     ebadger@purestorage.com
Cc:     Eric Badger <ebadger@purestorage.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Message-ID: <20211003181653.GA685515@ebadger-ThinkPad-T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is cosmetically nicer for counts > INT32_MAX, and aligns the
MC-scope format with that of the lower layer sysfs counter files.

Signed-off-by: Eric Badger <ebadger@purestorage.com>
---
 drivers/edac/edac_mc_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 2f9f1e7..0a638c9 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -744,7 +744,7 @@ static ssize_t mci_ue_count_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ue_mc);
+	return sprintf(data, "%u\n", mci->ue_mc);
 }
 
 static ssize_t mci_ce_count_show(struct device *dev,
@@ -753,7 +753,7 @@ static ssize_t mci_ce_count_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ce_mc);
+	return sprintf(data, "%u\n", mci->ce_mc);
 }
 
 static ssize_t mci_ce_noinfo_show(struct device *dev,
@@ -762,7 +762,7 @@ static ssize_t mci_ce_noinfo_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ce_noinfo_count);
+	return sprintf(data, "%u\n", mci->ce_noinfo_count);
 }
 
 static ssize_t mci_ue_noinfo_show(struct device *dev,
@@ -771,7 +771,7 @@ static ssize_t mci_ue_noinfo_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%d\n", mci->ue_noinfo_count);
+	return sprintf(data, "%u\n", mci->ue_noinfo_count);
 }
 
 static ssize_t mci_seconds_show(struct device *dev,
-- 
1.9.1

