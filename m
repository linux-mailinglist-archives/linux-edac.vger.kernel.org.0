Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9AF36DC5
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfFFHuX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 03:50:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58834 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFHuX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Jun 2019 03:50:23 -0400
Received: from zn.tnic (p200300EC2F1EFA008DFA61B32E935F4C.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:fa00:8dfa:61b3:2e93:5f4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18CEA1EC0249;
        Thu,  6 Jun 2019 09:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559807422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yv5Jyf2/aHF2MK724YeYv/G4bYAcwOm2MJNBI2PllQU=;
        b=MPE1somu2iyfymhz5QPSlfO4vY8gAn+MU40tBZLYjDo6wEJ8AGmNSar897xHgxVQAyy3TV
        SShoDlG71WQI53MbwI7g6KcnxFDslYTytyEXZzaaIh29wAnIXVt9T4zzVOWcLKs36lrfbs
        DnKPn+ttugDqi/g1hre848w4rQhLx54=
Date:   Thu, 6 Jun 2019 09:50:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Fix memleak in mce_banks
Message-ID: <20190606075015.GC26146@zn.tnic>
References: <1559804967-46320-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1559804967-46320-1-git-send-email-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 06, 2019 at 03:09:27PM +0800, luanshi wrote:
> From: zhangliguang <zhangliguang@linux.alibaba.com>
> 
> The mce_banks is leaked in the error out cases during
> __mcheck_cpu_apply_quirks and mce_gen_pool_init. This patch fixes it.

Maybe my reply from last night wasn't clear so lemme repeat it again:
this patch is not needed because we're removing the kcalloc call there
and the banks will be allocated statically in the future.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
