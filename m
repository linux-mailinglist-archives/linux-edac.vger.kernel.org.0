Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FAE1F6009
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jun 2020 04:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgFKCcx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 22:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFKCcx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Jun 2020 22:32:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10219C08C5C1;
        Wed, 10 Jun 2020 19:32:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so1875102pgn.5;
        Wed, 10 Jun 2020 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gtC7gk42q9Gil9motcJotL/bdjuqtagoSxa8dX9Y100=;
        b=LyqW8zS8nhwfM8aORPjfvi+AWEMrdNS58HxcHf6F4LYpoGHBnbe//AR6fwPML51FWE
         5O7L2V/1D3I4y5iiAHs9u7HrG03yWS9mgvGh80caSyly4ZILyfQEze/SfCdfCVw954+p
         Zmmky/UNDGO/LqveYJLFQjBVbfy4F7VSFfvmAe8iD6tdJGImW801wxG1UQcCFDq/EpQZ
         I0/ULYkYXNZWI+GQYFhsNKidjnVmEWjC6hddwcgxueneX9H/8ruFHBtH4yEiacdThxso
         lG1Vh5F5VtqBzJa7UsWNZSvCdekc+ZK5KcvJsLvACWUtooXNIgdzlyHln6Sa8k4lEMf4
         MYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gtC7gk42q9Gil9motcJotL/bdjuqtagoSxa8dX9Y100=;
        b=qvwIH5fI/Q3w3bBv4orrP3EipFPMo9QYA3+c/zSEhXiihiD+PZWtvE7AGuJYO/yClN
         T99NpvfpF2Mkhxx28gVaSjWyOGsTzL/siEYM17EPRJ5ze3h9KAw/fUiLxq+vAhQpMzeL
         yz0sNf038obF+qPGq1h/yDfTnKhi9uEnsucy0YIae7ldxEbXh02XINjIknFQ+mSEPuNI
         Q7UJF/TKb1pA034DlenfAD7HaFjUVEunIEwtj79wkisGoHPCPShTv2Nua6TEL4xEYTH/
         47a5qlfGsB9ZNBgu4FTEjXLp2kVF2JHHlXuEEyVS/DERwhX2ZcAmQZUnlJBv3Rkkvhj4
         /FpQ==
X-Gm-Message-State: AOAM532mQGFF5PozCKvrxvGCaMrjOAdOhoGtFZMdZ5GfqmygIJXfJzes
        Z5jAxLw8nlF4MuZUfZlyS7B8OqS8
X-Google-Smtp-Source: ABdhPJzzFHv0FdmPEv2nuvMFQEWlARORsmk3q5TjZrqF7Y9dv1HR92EFhCcBtUOmeVGfxr4bUITMzw==
X-Received: by 2002:a65:5688:: with SMTP id v8mr182533pgs.48.1591842772059;
        Wed, 10 Jun 2020 19:32:52 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id o18sm1301393pfu.138.2020.06.10.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 19:32:51 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     x86@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] x86/mce: fix a wrong assignment of i_mce.status
Date:   Thu, 11 Jun 2020 10:32:38 +0800
Message-Id: <20200611023238.3830-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The original code is a nop as i_mce.status is or'ed with part of itself,
fix it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3413b41..dc28a61 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -511,7 +511,7 @@ static void do_inject(void)
 	 */
 	if (inj_type == DFR_INT_INJ) {
 		i_mce.status |= MCI_STATUS_DEFERRED;
-		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
+		i_mce.status &= ~MCI_STATUS_UC;
 	}
 
 	/*
-- 
1.8.3.1

