Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80D9493868
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jan 2022 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353659AbiASK2O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jan 2022 05:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353429AbiASK2O (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Jan 2022 05:28:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7184C061574;
        Wed, 19 Jan 2022 02:28:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 755CAB81919;
        Wed, 19 Jan 2022 10:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7085BC004E1;
        Wed, 19 Jan 2022 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642588091;
        bh=0jCJMjVYWUcxzXHIesD3FU8jEvbBrlINZq0n/Yx5ufA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVsoStA8AfGP7kacCQWh7DOEew0wWHsb7nfEx20TWLXyJ4aZm19/S+6taVoIA+5KV
         osLhrA9ulw9N3/oRT1dxRwC0DKUlWHb5MkFDiDNGhoSZOwA7LeS66QQIieS04IjaEQ
         l55DBO5WE2LwdJY9JIUeSX50Zw3Az79aCuCcstIc=
Date:   Wed, 19 Jan 2022 11:28:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <YefnuCPwMq5V2lgl@kroah.com>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
 <YefXQHXNlsxk8yUc@kroah.com>
 <Yefb7zO9p1iPF3Jm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yefb7zO9p1iPF3Jm@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 19, 2022 at 10:37:51AM +0100, Borislav Petkov wrote:
> On Wed, Jan 19, 2022 at 10:17:52AM +0100, Greg Kroah-Hartman wrote:
> > For this specific change, I do NOT think it should be backported at all,
> > mostly for the reason that people are still arguing over the whole
> > platform_get_*_optional() mess that we currently have.  Let's not go and
> > backport anything right now to stable trees until we have all of that
> > sorted out, as it looks like it all might be changing again.  See:
> > 	https://lore.kernel.org/r/20220110195449.12448-1-s.shtylyov@omp.ru
> > for all of the gory details and the 300+ emails written on the topic so
> > far.
> 
> It sounds to me I should not even take this patch upstream yet,
> considering that's still ongoing...

Yes, I would not take that just yet at all.  Let's let the api argument
settle down a bit first.

thanks,

greg k-h
