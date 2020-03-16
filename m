Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F82186807
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 10:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgCPJks (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 05:40:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35356 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgCPJkr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 05:40:47 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B4DF1EC0A9C;
        Mon, 16 Mar 2020 10:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584351646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B0X3DBaS6qk8U10kushsnt8gYgIx6lDYZA9ypH96C7g=;
        b=S3xXXVDE6hI4IP9RQYpC2DUkHRUUfqYM/65m/u+9ZHrTyW1w3ot9dFOfwwlx48wOJrNHmf
        txLaOYi5PWSMNRGk2csJ5UQ2m8Jtd3+s2dSdPXLyst0H3QIMf5HIsgZhhg9iwUJLiBIWPl
        ZF1r4dflPNIOUsbYb9jtilF9Fclop/0=
Date:   Mon, 16 Mar 2020 10:40:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] EDAC/ghes: Implement DIMM mapping table for SMBIOS
 handles
Message-ID: <20200316094056.GC26126@zn.tnic>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-10-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306151318.17422-10-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 06, 2020 at 04:13:16PM +0100, Robert Richter wrote:
> GHES uses SMBIOS handles to identify the DIMM that was causing a hw
> error. Currently this is stored in smbios_handle of struct dimm_info.
> This implementation has several drawbacks. The information is private
> to the ghes driver, but struct dimm_info is for general use. The DIMMs
> are tied to a *mci struct, which makes a lockup inefficient. It is

"lookup"

> hard to dynamically allocate DIMMs and also to meet locking
> constraints when adding or removing them. This becomes even more
> challenging when having multiple MC instances that group a set of
> DIMMs, so the change is needed also to later support multiple MC
> instances.

Err, I don't understand: normally a bunch of DIMMs belong to a memory
controller and that gives you the hierarchy automatically. Why is that a
problem?

And normally you allocate the DIMM representations on MC init and
deallocate them when removing the MC.

So what is the problem here?

...

...
> @@ -72,6 +79,52 @@ struct memdev_dmi_entry {
>  	u16 conf_mem_clk_speed;
>  } __attribute__((__packed__));
>  
> +/* ghes_reg_mutex must be held. */

lockdep_assert_held()

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
