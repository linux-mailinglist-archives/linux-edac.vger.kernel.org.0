Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08DA918C69
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEIOye (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 10:54:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37346 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEIOye (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 10:54:34 -0400
Received: from zn.tnic (p200300EC2F0F5F00A4EF991375FD2B9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:a4ef:9913:75fd:2b9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA71E1EC0229;
        Thu,  9 May 2019 16:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557413672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HoVmf9AN756VzHeCmA9mSEXehEDoZc/0MyWCdj5XOgU=;
        b=T7byKNeu44qF10WqTKv81v42E651obZYY8Etz9WQVkNM29ytPZcCeKljOO3EC2ddqlzBq4
        JG02joFxyvHmqngeoRuxVA6WGyelSn9nVVRUJUS8UgYJ7qtFJqjAXDVHQBJ4zAY6wqn5GW
        qBCdUMJQaSd2sw+xHVWDpGKZO5xpNmw=
Date:   Thu, 9 May 2019 16:54:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Message-ID: <20190509145426.GC17053@zn.tnic>
References: <20190508224201.27120-1-colin.king@canonical.com>
 <20190509141313.GA17053@zn.tnic>
 <55f8efee-a02c-1574-42fa-35e1d3df14f7@canonical.com>
 <20190509144113.GB17053@zn.tnic>
 <20190509144650.GG21059@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509144650.GG21059@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 09, 2019 at 05:46:50PM +0300, Dan Carpenter wrote:
> On Thu, May 09, 2019 at 04:41:13PM +0200, Borislav Petkov wrote:
> > Bottom line of what I'm trying to say is, those tags better be useful to
> > the general kernel audience - that means, they should be documented so
> > that people can look them up - or better not be in commit messages at
> > all.
> 
> Other people will complain if you don't mention the tool name...

To quote again what I said: "... they should be documented so that
people can look them up... "

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
