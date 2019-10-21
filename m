Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4139BDF01B
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfJUOkw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 10:40:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUOkw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 10:40:52 -0400
Received: from zn.tnic (p2E584653.dip0.t-ipconnect.de [46.88.70.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED7501EC0A91;
        Mon, 21 Oct 2019 16:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571668851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sZ/MDfegUgGm8z+DRUVp9+PgEkJ14FoaH/PagdpdVVQ=;
        b=SPnQESjSv3gQJnxBeQ6d82yTpnny42QaV/indOZRO0X3OyepdjZid8re/6wd6suC9HpGUQ
        yHE8MmmAGoAYE8YruJkZwy0eftaJI2BYYnxbHatfw/8lwxi1tC7i1yEE3gXCE2qgEYsgij
        xCTPk8vvbKP42ozwxH5Q7lOODxjJrJc=
Date:   Mon, 21 Oct 2019 16:40:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] EDAC/amd64: Save max number of controllers to family
 type
Message-ID: <20191021144012.GD7014@zn.tnic>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
 <20191018153114.39378-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018153114.39378-4-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 03:31:26PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The maximum number of memory controllers is fixed within a family/model
> group. In most cases, this has been fixed at 2, but some systems may
> have up to 8.
> 
> The struct amd64_family_type already contains family/model-specific
> information, and this can be used rather than adding model checks to
> various functions.
> 
> Create a new field in struct amd64_family_type for max_num_controllers.
> Set this when setting other family type information, and use this when
> needing the maximum number of memory controllers possible for a system.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190821235938.118710-9-Yazen.Ghannam@amd.com

...

> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 8c3cda81e619..0d5a9bc4d6de 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -479,6 +479,7 @@ struct low_ops {
>  struct amd64_family_type {
>  	const char *ctl_name;
>  	u16 f0_id, f1_id, f2_id, f6_id;
> +	u8 max_num_controllers;

Sure but call that max_mcs or so, so that the code which mentions it,
doesn't stick out too much. You can put a comment above it here to
explain what it is:

	/* Maximum number of memory controllers per node */
	u8 max_mcs;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
