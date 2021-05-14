Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0E3803EC
	for <lists+linux-edac@lfdr.de>; Fri, 14 May 2021 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhENHDH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 May 2021 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhENHDF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 14 May 2021 03:03:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B450C061574;
        Fri, 14 May 2021 00:01:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b2c00f343c5c4aba7bf62.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2c00:f343:c5c4:aba7:bf62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AD4F1EC04DA;
        Fri, 14 May 2021 09:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620975712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMUtS53V+V2XZVbfMA27FWCHdkf2qEP4oFLnuhfpt2w=;
        b=JV4oa6/OljTxTyR8v/j+QigMG9g/lAeyFQeuuKNUjWpVwV2VaaNTgHY6oxh7Xd5gMcN5ZV
        nQN152hxvStR07IbU3Jd9ZEhsbZ85L6cXtxHLE87tlK8BBYgRCPdjr6icSI9fzFZuVabVU
        lrtWDUkU7ZmTpgsw1RgNG3oFOCf4Q+Y=
Date:   Fri, 14 May 2021 09:01:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     kristo@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] staging: =?utf-8?Q?co?=
 =?utf-8?Q?medi=3A_Remove_unused_variable_=E2=80=98min=5Ffull=5Fscale?=
 =?utf-8?B?4oCZ?= and function 'get_min_full_scales'
Message-ID: <YJ4gWq3TL0TZtyKS@zn.tnic>
References: <20210514043539.55212-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514043539.55212-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 14, 2021 at 12:35:39PM +0800, Bixuan Cui wrote:
> The variable ‘min_full_scale’ and function 'get_min_full_scales' are
> not used, So delete them.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
> Changes from v2:
> * Delete function 'get_min_full_scales'
> 
>  drivers/comedi/drivers/jr3_pci.c | 15 ---------------

You shouldn't wonder when you don't get a proper reply with that Cc
list:

./scripts/get_maintainer.pl -f drivers/comedi/drivers/jr3_pci.c
Ian Abbott <abbotti@mev.co.uk> (odd fixer:COMEDI DRIVERS)
H Hartley Sweeten <hsweeten@visionengravers.com> (odd fixer:COMEDI DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/2=100%,authored:1/2=50%)
"Alexander A. Klimov" <grandmaster@al2klimov.de> (commit_signer:1/2=50%,authored:1/2=50%)
linux-kernel@vger.kernel.org (open list)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
