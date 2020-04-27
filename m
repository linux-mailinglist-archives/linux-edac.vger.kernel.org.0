Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BF1BA59C
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgD0OA7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgD0OAw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Apr 2020 10:00:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8AC0610D5;
        Mon, 27 Apr 2020 07:00:51 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F000ACB29DFFDE7AC3C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f000:acb2:9dff:de7a:c3c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 051BC1EC0D21;
        Mon, 27 Apr 2020 16:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587996050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gQyJ11P5tivvLKUDiEhjBf0KP30jTDiuWezjtD55r5k=;
        b=o5I+3Fo2V/A1ngZQovDfjFGfYcSHt3DEtamirS28hpdqSZcbVvoee+Wfc78mxWcFySh7p2
        ckyceC3H4UoG0f1kaKF65y/TnkYlKxIrnv+AV7lXlC6YQDsU8tEBcJq54+EdP7ewHsiFyk
        QsP0skNBlv4+k5e8A8bD8K3fnhNZQxg=
Date:   Mon, 27 Apr 2020 16:00:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] EDAC/ghes: Cleanup struct ghes_edac_dimm_fill,
 rename it to ghes_dimm_fill
Message-ID: <20200427135923.GF11036@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-8-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-8-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:11PM +0200, Robert Richter wrote:
> The struct is used to store temporary data for the dmidecode callback.
> Clean this up a bit:
> 
>  1) Rename member count to index since this is what it is used for.
> 
>  2) Move code close to ghes_edac_dmidecode() where it is used.
> 
>  3) While at it, use edac_get_dimm_by_index().
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Ok except the commit title is wrong. And yes, pls keep it "dimm_fill" -
short and sweet and without yet another "ghes" in the name. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
