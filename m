Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C540F18C78
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 16:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfEIOzi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 10:55:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfEIOzi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 10:55:38 -0400
Received: from zn.tnic (p200300EC2F0F5F00A4EF991375FD2B9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:a4ef:9913:75fd:2b9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B81E41EC0229;
        Thu,  9 May 2019 16:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557413736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UfQPopqWasAcPWpNglIaSN0rcEU8uA4iEC6U8dxr6GI=;
        b=YztM7FRxGmwUlcpRcTghJBiQ2RkeHK2QfrLoNG0zTnQ2G2/rfs2UmX0xnd2uCvzPQj9443
        CePQOD1YGw+Z5lXgW2YnnGcxxNn+Zuqtnlr8Xv2oYZzTOAHg9uq1F/Sg8WrFM52ynNwS1y
        y8LnNvh1hJ7uTyHkAw+/MrUTUN9Ey3M=
Date:   Thu, 9 May 2019 16:55:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
Message-ID: <20190509145534.GD17053@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250>
 <20190508101238.GB19015@zn.tnic>
 <87o94bvfxm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o94bvfxm.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 10, 2019 at 12:52:05AM +1000, Michael Ellerman wrote:
> Thanks. It would be nice if you could send it as a fix for 5.2, it's the
> last thing blocking one of my allmodconfig builds. But if you don't
> think it qualifies as a fix that's fine too, it can wait.

Sure, no problem. Will do a pull request later.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
