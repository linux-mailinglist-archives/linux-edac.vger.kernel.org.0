Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C1468CFE
	for <lists+linux-edac@lfdr.de>; Sun,  5 Dec 2021 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhLETdQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 5 Dec 2021 14:33:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60854 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237946AbhLETdQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 5 Dec 2021 14:33:16 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D9B91EC01DF;
        Sun,  5 Dec 2021 20:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638732584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lwMdT1+VGcbyLG7dHIl+8q+JM1I2kluwGbfmD2p+DLU=;
        b=hcRQHXcdv4avPsgyPkGuaNimYMm7lrBoqcbzqEV9DAHBnrKDyfvvcX3csRO7284YBfit8U
        FNO6NKUOHvcvO4jWHUfzSr5Uc0h1T+vahL8MU8lT0vg7G30Q/QO77TEVP9+v30vkwHRIXH
        St5EVEFA/6dSG+xTh/vCztqQy666KeA=
Date:   Sun, 5 Dec 2021 20:29:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] EDAC/sifive: fix non-kernel-doc comment
Message-ID: <Ya0TKe1m+WfoCFWv@zn.tnic>
References: <20211201030913.10283-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201030913.10283-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 30, 2021 at 07:09:13PM -0800, Randy Dunlap wrote:
> scripts/kernel-doc complains about a comment that begins with "/**"
> but is not in kernel-doc format, so correct it.
> 
> Prevents this warning:
> 
> drivers/edac/sifive_edac.c:23: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * EDAC error callback
> 
> Fixes: 91abaeaaff35 ("EDAC/sifive: Add EDAC platform driver for SiFive SoCs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Yash Shah <yash.shah@sifive.com>
> Cc: linux-edac@vger.kernel.org
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
