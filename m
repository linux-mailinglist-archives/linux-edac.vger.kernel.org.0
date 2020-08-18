Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD6A24864F
	for <lists+linux-edac@lfdr.de>; Tue, 18 Aug 2020 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHRNoe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Aug 2020 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRNoc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Aug 2020 09:44:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C7C061389
        for <linux-edac@vger.kernel.org>; Tue, 18 Aug 2020 06:44:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A25B01EC0242;
        Tue, 18 Aug 2020 15:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597758268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I7EyPnBFsdx28h0B5ghdEt7kgKWI/V5mIZuG/72OxL4=;
        b=UjQTnT5VIvwYtJPX1za/FSVSxXQLdn74K/soN63McrUEyG1qvkKklI6jbZG8g/avwkZ7L6
        g51lql6QuTRvcYyAFwkmvDK4ceUFqlnnpvJad+RlLRRXZjpCINoAOvagDwIbch1n17cDjc
        /bNhctwCcck3mGxay0D5k53zAvOm4OE=
Date:   Tue, 18 Aug 2020 15:45:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC, i7core, sb, pnd2, skx: Fix error event severity
Message-ID: <20200818134522.GD31641@zn.tnic>
References: <20200707194324.14884-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707194324.14884-1-tony.luck@intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 07, 2020 at 12:43:24PM -0700, Tony Luck wrote:
> IA32_MCG_STATUS.RIPV indicates whether the return RIP value pushed onto
> the stack as part of machine check delivery is valid or not.
> 
> Various drivers copied a code fragment that uses the RIPV bit to
> determine the severity of the error as either HW_EVENT_ERR_UNCORRECTED
> or HW_EVENT_ERR_FATAL, but this check is reversed (marking errors where
> RIPV is set as "FATAL").
> 
> Reverse the tests so that the error is marked fatal when RIPV is not set.
> 
> Reported-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/i7core_edac.c | 4 ++--
>  drivers/edac/pnd2_edac.c   | 2 +-
>  drivers/edac/sb_edac.c     | 4 ++--
>  drivers/edac/skx_common.c  | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)

Queued on edac-urgent, will send to Linus next week.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
