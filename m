Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB137A5CA
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEKLcy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 07:32:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40726 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhEKLcx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 07:32:53 -0400
Received: from zn.tnic (p200300ec2f0ec70038bae042ea25b78e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:38ba:e042:ea25:b78e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FB5A1EC0373;
        Tue, 11 May 2021 13:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620732706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iD/mLUexiG9Uw5+sPNvqGd6wScn21U33gzwthPIxSi4=;
        b=GKIuVxhVx9TcGXZt+6ZuPzn8Hm1GUXEROWokX1oF9aKMHYk88vYIRIGt+A9DckIK5UStb1
        AacRJLwFKTICE7VByDjj5yxwusKhWYN7MHY1OgGAyYSEKiZmbEebZfPpYMKtRztLQjbzK5
        fkToO1nCjSEIvaMXK+GlrRkxZuLV8x4=
Date:   Tue, 11 May 2021 13:31:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] EDAC: ti: Add missing MODULE_DEVICE_TABLE
Message-ID: <YJprIzhI9UF5wVQp@zn.tnic>
References: <20210508031506.53687-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210508031506.53687-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, May 08, 2021 at 11:15:06AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> correct modalias for automatic loading of this driver when it is built
> as an external module.

"external" or simply a module?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
