Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB72298B8B
	for <lists+linux-edac@lfdr.de>; Mon, 26 Oct 2020 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770424AbgJZLMe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Oct 2020 07:12:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35904 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771284AbgJZLMe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Oct 2020 07:12:34 -0400
Received: from zn.tnic (p200300ec2f07cc003725ac6034898aff.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:cc00:3725:ac60:3489:8aff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D67191EC038E;
        Mon, 26 Oct 2020 12:12:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603710752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mq7M8zYeHH/cqq7FDh8xmEzvAW1UknuyrQuGqgk7n6g=;
        b=CLzpTkCnvuRNZa0loxAPiMG+hjZqyG3D+hDCUgUJmlfko6dgw0JWERcHPYUgBn3YC+ioS4
        9jF4PDYvndlnL/gxmSePDv6q974N7q9ThSjFZ+wujD2bKZ3bIiU2V0d3D1FpYG/hU64aQJ
        oHu57hz19oMU2Bn0uYQqEAtZ1FowKGE=
Date:   Mon, 26 Oct 2020 12:12:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     james.morse@arm.com, rric@kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, linux-edac@vger.kernel.org
Subject: Re: [PATCH -next] EDAC/amd64: Discard unnecessary break
Message-ID: <20201026111228.GC22116@zn.tnic>
References: <20201026091103.67780-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026091103.67780-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 26, 2020 at 05:11:03PM +0800, Zhang Qilong wrote:
> A 'break' is unnecessary because of previous 'return'.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/edac/amd64_edac.c | 7 -------
>  1 file changed, 7 deletions(-)

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/commit/?h=edac-misc&id=f09056c1decec889721c24c72f99730376918044

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
