Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556674147D6
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhIVLfj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 07:35:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhIVLfj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 07:35:39 -0400
Received: from zn.tnic (p200300ec2f0efa008ea00e11d58cbc58.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:8ea0:e11:d58c:bc58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 517E31EC051E;
        Wed, 22 Sep 2021 13:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632310444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jiiv8SpQ/CjmhmUczANXkD+A4815hJePunK0lOlYXLU=;
        b=NKkzztWPJBhz/loxLIp3g00YXHWetTU8mIEimwTJxR24rTpEm6BCG/0rhWa7dUE00Ijh0T
        TaCuEsyzjg1IP2ydr2OcGMHkEUAJxsal5DOE7WZbnXQFS0W72hLFu1WeXpomk8H9wUWCpg
        fiA7/NT8AKskBiFcHlSfS3auvj1ym/I=
Date:   Wed, 22 Sep 2021 13:33:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mukul Joshi <mukul.joshi@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Message-ID: <YUsUpkvP8zpz8yRz@zn.tnic>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913021311.12896-1-mukul.joshi@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Sep 12, 2021 at 10:13:10PM -0400, Mukul Joshi wrote:
> Export smca_get_bank_type for use in the AMD GPU
> driver to determine MCA bank while handling correctable
> and uncorrectable errors in GPU UMC.
> 
> v1->v2:
> - Drop the function is_smca_umc_v2().
> - Drop the patch to introduce a new MCE priority (MCE_PRIO_ACEL)
>   for GPU/accelarator cards.

Patch changelog information goes...

> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---

... under this line so that it gets automatically removed by git when
applying the patch.

Alex, how do you wanna handle this?

Want me to ACK this and you can carry it through your tree along with
the second patch?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
