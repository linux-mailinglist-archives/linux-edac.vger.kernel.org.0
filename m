Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9613C358A
	for <lists+linux-edac@lfdr.de>; Sat, 10 Jul 2021 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhGJQhz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Jul 2021 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhGJQhz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Jul 2021 12:37:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C65C0613DD;
        Sat, 10 Jul 2021 09:35:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l2so19149885edt.1;
        Sat, 10 Jul 2021 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pCKyPRPE/b6pbaxEj2WfHY82QaiPQRkKPIRtb5R+GfM=;
        b=OUbXjslt/FjsM7He2cpBPldorMy4nk4AVD57sADfgk4do3JoewXd3DWK0J0JcFIf6K
         +u0PmQyY0+CLR27Lu6AcCJ7eJujIvlkDLjA9KPw6U/DyDuf3bKd2FznkQD6HkvtwECrA
         tSF2PbCsxADViJUWwMbxCK6LI+sGjiJ1BKmu0XnjqzkQRyP8MtOLXxyBEA3xIQo7Ee80
         q4sbJNQfeY2XtDVk29BaVkbQVCSM/wbZ34vXQJaH9srLOnqNlllRrOFNmqUAfBkijXmz
         5j1TkPftZs+ftHxQee24xFrNEU4u/L7EdZOq6OOlK/4+UXs9rZNG4ZbSgK+bLdFE5uOy
         7MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pCKyPRPE/b6pbaxEj2WfHY82QaiPQRkKPIRtb5R+GfM=;
        b=KH+Kt9oOscEtwDFOoGRt4WlnyQCPqjTPnlPwkzWsRFdpCm7qxXO2d4SNKa8MNaZPPb
         LRhYRnF87ndq18ocPwRuffqOJYbYumTWXD+w7VGJL4bZZHVvuMGP/Iu3FrQzIwN50Ybv
         yzJGmlgMEe+9CZpG4KpToZzYB6am2cs7oyg5OjKJZn8Gwwte53fvE+nkTYhATySX0wcO
         sd86Ei+DIZo+Vp6CRpzHjRwCX3J9JqaNGK9GdK9IkWuaglXGvbMdfeAprzxsztwFYwiC
         p7loPUWdWwY4d9AZlrdVXWIYHgMP/wc5OqjNiXZCrEFP3/OCtfbQw/2TK8EFVJsBe4nd
         yfvQ==
X-Gm-Message-State: AOAM5312LFjsM0kr8iy+P5ycB76kR84vBgSmyH5m6gUnCvBmJwL+6SUX
        Ff+zBTrohwQkSgOPF3g+B7MaPo2UAfg=
X-Google-Smtp-Source: ABdhPJytWv26eGx+g2wOeq+HmbEMVRT6l0GA3wUobUa7psmHfnuBWaORisc2czRh4Win1KqwGmslaA==
X-Received: by 2002:a05:6402:524d:: with SMTP id t13mr54586135edd.303.1625934907294;
        Sat, 10 Jul 2021 09:35:07 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id p26sm3914834ejn.112.2021.07.10.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 09:35:06 -0700 (PDT)
Date:   Sat, 10 Jul 2021 17:35:05 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND] edac: replace sprintf() by scnprintf()
Message-ID: <20210710163505.GA689509@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace sprintf() by scnprintf() in order to avoid buffer overflows.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/edac/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 4804332d9946..c83653084aa3 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -61,7 +61,7 @@ void edac_create_debugfs_nodes(struct mem_ctl_info *mci)
 	parent = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
 
 	for (i = 0; i < mci->n_layers; i++) {
-		sprintf(name, "fake_inject_%s",
+		scnprintf(name, sizeof(name), "fake_inject_%s",
 			     edac_layer_name[mci->layers[i].type]);
 		debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
 				  &mci->fake_inject_layer[i]);
-- 
2.25.1

