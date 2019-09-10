Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48EDAE5B8
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfIJIjo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 04:39:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbfIJIjo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Sep 2019 04:39:44 -0400
Received: from zn.tnic (p200300EC2F0ABE0090E5501BEA8F5D7A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:be00:90e5:501b:ea8f:5d7a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B7141EC0688;
        Tue, 10 Sep 2019 10:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568104782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l97Dgc6UO+XybIZTHRbhH95m+YBa35xzZTNLVyu64qY=;
        b=hazzpvv9pfkJoLEIwtHcJBKqJVCibsEHxikWcNJhrABmf1gxh74nOrHot1KD4xHpnTCR+u
        v8MPiXBjCOv50dGhM6dNUl2ZXecicj5fSNyL03C7OO/J7kL33rwvcmYM1OszhWYodsPecX
        k0v9wLTWude61QxhP7U4uN9boVaj8O8=
Date:   Tue, 10 Sep 2019 10:39:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     tiantao6 <tiantao6@huawei.com>
Cc:     tony.luck@intel.com, linux-edac@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ras: debugfs: Fix warning: no previous prototype
Message-ID: <20190910083940.GC23931@zn.tnic>
References: <1568103739-36667-1-git-send-email-tiantao6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568103739-36667-1-git-send-email-tiantao6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 10, 2019 at 04:22:19PM +0800, tiantao6 wrote:
> fixed the fellow warning when building with warnings enabled (W=1)

"fellow"?

> 
> drivers/ras/debugfs.c:8:5: warning: no previous prototype for
> ‘ras_userspace_consumers’ [-Wmissing-prototypes]
> int ras_userspace_consumers(void)
> 
> drivers/ras/debugfs.c:38:12: warning: no previous prototype for
> ‘ras_add_daemon_trace’ [-Wmissing-prototypes]
> int __init ras_add_daemon_trace(void)
> 
> drivers/ras/debugfs.c:54:13: warning: no previous prototype for
> ‘ras_debugfs_init’ [-Wmissing-prototypes]
> void __init ras_debugfs_init(void)

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=ras/core&id=0a54b809a3a2c31e1055b45b03708eb730222be1

> 
> Signed-off-by: tiantao6 <tiantao6@huawei.com>

Also, if you intend to send more patches in the future, please use your
real name.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
