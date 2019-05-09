Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008C818B52
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEIONX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 10:13:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfEIONX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 10:13:23 -0400
Received: from zn.tnic (p200300EC2F0F5F00A4EF991375FD2B9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:a4ef:9913:75fd:2b9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 844EF1EC0AD6;
        Thu,  9 May 2019 16:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557411201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+PHLiSfYmDjlELYK+9z1QfW58niSz8+w36T8ZEcU68k=;
        b=mrm0yewwvirES4xxq5BoKs3UMEVvkMcA4rAauxjG9tRKhxdr5ouftUo6GE72JG6VL+FlJC
        9oC3Q73j5v28nuII7af0DPlN7wxZ2VZeZzOYXoBz4BbTqC8nj1Q5pMVeBCSBXI9C1FLXEy
        FKrSvk/ByJrF7GRIL4l6bXNpdScYXIw=
Date:   Thu, 9 May 2019 16:13:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Message-ID: <20190509141313.GA17053@zn.tnic>
References: <20190508224201.27120-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508224201.27120-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 08, 2019 at 11:42:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable tad_base is being set to a value that is never read
> and is being over-written on the next iteration of a for-loop.
> This assignment is therefore redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")

What's that tag's function supposed to be?

I see a lot of those in commit messages but it is nowhere documented in
the tree.

$ git grep -i coverity

doesn't give anything relevant.

Hmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
