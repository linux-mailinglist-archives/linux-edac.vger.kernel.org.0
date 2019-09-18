Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9246BB6177
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2019 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbfIRKac (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Sep 2019 06:30:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfIRKac (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Sep 2019 06:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XRaAKjfFAIyV3Cm0SyBkJ7/R9q7OtMIWq/5Yq1FWwM4=; b=m/yM9GRftf8JI4gon4CoaKtJL
        otLnZz3ObXwKj84K7XsNVrMZmEQsEAsKHCoY43x8xcuWOs/sQ58+5Nk06CiSDjWi8tdcBrh2MYSxO
        tLexj+3FZEZz4n39JGmkQAZsTiUMmFcmFjbBRHB5uebBTR8pmtwnZo8ygRad3C1qZWVxC+56WXGaj
        +HuvgGXBf41iz+c7710ISPzoLXXI95Kh9L72G8Vv/SqnFbU/frBGMRjwmhXb816+LHtnvSxOdlQ3y
        jXI7XYex9VLcTMsuNmbylsFmANjeCsa0OoguhlgaP8XcX3PUcpBkDM5yb+IOM8l1+bXkjmvgux/XT
        gzn7vosyQ==;
Received: from 177.96.192.152.dynamic.adsl.gvt.net.br ([177.96.192.152] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAXEE-00045e-96; Wed, 18 Sep 2019 10:30:30 +0000
Date:   Wed, 18 Sep 2019 07:30:26 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 0/2] EDAC, skx: Provide more machine specific location
 detail
Message-ID: <20190918073026.6b810136@coco.lan>
In-Reply-To: <20190917200503.hwizqhlukpbsipom@redhat.com>
References: <20190913221344.13055-1-tony.luck@intel.com>
        <20190917200503.hwizqhlukpbsipom@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Tue, 17 Sep 2019 16:05:04 -0400
Aristeu Rozanski <aris@redhat.com> escreveu:

> Hi Tony,
> 
> On Fri, Sep 13, 2019 at 03:13:42PM -0700, Tony Luck wrote:
> > First patch refactors code so that second can work on systems
> > with and without the ACPI ADXL address translation code. Perhaps
> > has some value on its own as the code is, IMHO, a little cleaner.
> > 
> > Second is in RFC state. Im looking for input on whether to just print
> > the extra information to the console log (as the patch does now) or
> > whether to tag it onto the long string that we push though the EDAC
> > reporting path.  
> 
> I believe it'll be more interesting for users that only care about error
> counts to keep this out of the console. For those who care about the extra
> information, having it available with rasdaemon or equivalent will be
> easier than have to look at both stored errors and kernel logs.

I agree with Aris here: the best is to report extra info via the
EDAC way, as some monitoring tool like rasdaemon will store it on 
a database and/or report via some mechanism like ABRT. 

I would expect that someone interested on monitoring hardware errors
to have all relevant details at the same place.

So, between a more detailed print or a more complete EDAC report, I
would do the latter.

Yet, nothing prevents to do both. 

Thanks,
Mauro
