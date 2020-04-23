Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05371B58E3
	for <lists+linux-edac@lfdr.de>; Thu, 23 Apr 2020 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgDWKOr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Apr 2020 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726997AbgDWKOq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Apr 2020 06:14:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D40C03C1AF;
        Thu, 23 Apr 2020 03:14:41 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0D2E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE2C91EC0D72;
        Thu, 23 Apr 2020 12:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587636880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BdV1Evk1l0MLN6r+R1du8FgzPaUF4x3mnOYmAgBhuyo=;
        b=WNsex+BCR4+GbbWDz7rvnpZqU3fgynJQU7yq28rEGR+JLfochkaSD4OLQ3vaEa15rsxZ56
        D7qsKUDp88ZLRCuwSxCNDAUU8/jghchbPk4UG7y/DLoj2lbciGV4Zac5IxqXkymW7IQEc1
        jgVbVLmoQM2EmSfKSAepRv76+0oHO+Y=
Date:   Thu, 23 Apr 2020 12:14:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     rrichter@marvell.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] EDAC, thunderx: Make some symbols static
Message-ID: <20200423101435.GA26021@zn.tnic>
References: <1587624744-97240-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1587624744-97240-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 23, 2020 at 02:52:24PM +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/edac/thunderx_edac.c:1281:22: warning: symbol 'ocx_dfs_ents'
> was not declared. Should it be static?
> drivers/edac/thunderx_edac.c:1922:22: warning: symbol 'l2c_tad_dfs_ents'
> was not declared. Should it be static?
> drivers/edac/thunderx_edac.c:1928:22: warning: symbol 'l2c_cbc_dfs_ents'
> was not declared. Should it be static?
> drivers/edac/thunderx_edac.c:1934:22: warning: symbol 'l2c_mci_dfs_ents'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/edac/thunderx_edac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
