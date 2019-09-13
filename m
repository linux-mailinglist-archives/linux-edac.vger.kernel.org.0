Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF89B24C2
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfIMRx1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 13:53:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45788 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfIMRx1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 13:53:27 -0400
Received: from zn.tnic (p200300EC2F0DC5006892875336F1420F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:6892:8753:36f1:420f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E97671EC03F6;
        Fri, 13 Sep 2019 19:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568397206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpFJ0Or1yxeNvpl7TVaHByalBVgRzhebTRgTdu/Myoo=;
        b=GQhXiY0RK7UxrkeUSbC6UeOZRWgIOOSG8xqxRO0+tErFfykWm7CKpe96eGDHONqNKhRPFG
        VQ277y4HQg/4nuP+h8lk3ZMEsR5WyF0cUnDrUrdYp1hUX0KZAqiNUtq8o8h6KrVzvd5BmK
        kSXh0o+qjLqc35Z+6pDXe49SMYIKzSo=
Date:   Fri, 13 Sep 2019 19:53:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>
Subject: Re: [PATCH 0/7] Address most issues when building with W=1
Message-ID: <20190913175320.GD4190@zn.tnic>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1568385816.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 13, 2019 at 11:50:25AM -0300, Mauro Carvalho Chehab wrote:
> There is a recent discussion at KS ML with regards to use W=1 as default.
> 
> No idea if this will happen or not, but it doesn't hurt cleaning up W=1
> warnings from the EDAC subsystem, specially since it helps to cleanup
> a few things.
> 
> This patch series addresses most of such warnings.  After this series,
> there will be just two W=1 warnings:
> 
> 1) i5100 EDAC driver:
> 
> 	drivers/edac/i5100_edac.c: In function ‘i5100_read_log’:
> 	drivers/edac/i5100_edac.c:487:11: warning: variable ‘ecc_loc’ set but not used [-Wunused-but-set-variable]
> 	  487 |  unsigned ecc_loc = 0;
> 	      |           ^~~~~~~
> 
> 
>    The ecc_loc contents is filled from MC data, but it is not used anywere.
>    The i5100 MC is very old: the affected code was added in 2008. It should
>    probably be safe to just drop the corresponding data, but, as it may
>    contain some relevant info, I was a little reticent of doing that.
> 
> 2) Xgene EDAC driver:
> 
> 	drivers/edac/xgene_edac.c: In function ‘xgene_edac_rb_report’:
> 	drivers/edac/xgene_edac.c:1486:7: warning: variable ‘address’ set but not used [-Wunused-but-set-variable]
> 	 1486 |   u32 address;
> 	      |       ^~~~~~~
> 
>    I suspect that the content of the address field should actually be used on
>    at least some of the logs.

+ Khuong Dinh <khuong@os.amperecomputing.com> for that.

> I may eventually submit patches later to address the above cases, but let's
> solve first the other cases, as they all sound trivial enough.
> 
> Mauro Carvalho Chehab (7):
>   EDAC: i5100_edac: get rid of an unused var
>   EDAC: i7300_edac: rename a kernel-doc var description
>   EDAC: i7300_edac: fix a kernel-doc syntax
>   EDAC: i5400_edac: print type at debug message
>   EDAC: i5400_edac: get rid of some unused vars
>   EDAC: sb_edac: get rid of unused vars
>   EDAC: skx_common: get rid of unused type var
> 
>  drivers/edac/i5100_edac.c |  2 --
>  drivers/edac/i5400_edac.c | 15 +++------------
>  drivers/edac/i7300_edac.c |  4 ++--
>  drivers/edac/sb_edac.c    | 21 ++++++++-------------
>  drivers/edac/skx_common.c |  5 +----
>  5 files changed, 14 insertions(+), 33 deletions(-)

Looks ok to me at a quick glance, ACK.

I've already sent the 5.4 pull request to Linus so you could queue those
after -rc1. It's not like they're urgent or so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
