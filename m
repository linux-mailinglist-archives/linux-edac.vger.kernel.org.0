Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45B11C4FF
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2019 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfENIb1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 May 2019 04:31:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfENIb1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 May 2019 04:31:27 -0400
Received: from zn.tnic (p200300EC2F29E5001D7DC1D592351BAD.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:e500:1d7d:c1d5:9235:1bad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE2F61EC0400;
        Tue, 14 May 2019 10:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557822685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HG0WXJqrGZ2lLUm72OEL8UR46M7kssXY79lj4QERGYE=;
        b=Q9XTjB2O4Pk+EDquI9si6mSAkW3USOL9kM8Gf2tpb2ksW0CfsoQcV4932+tnGJqAkhKUqI
        +1+PxbCHKBno1kt6RScQ4lPyNvb9clKxofuSCh3vlqMrQE6b2ucN0odj9PdUgtKoUlRgQ7
        iFrI1NWRgxSAx6vAO5cRTqJnxBd6WZA=
Date:   Tue, 14 May 2019 10:31:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
Message-ID: <20190514083110.GA31140@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250>
 <20190508101238.GB19015@zn.tnic>
 <87o94bvfxm.fsf@concordia.ellerman.id.au>
 <20190509145534.GD17053@zn.tnic>
 <20190509180220.GH17053@zn.tnic>
 <87bm0avb03.fsf@concordia.ellerman.id.au>
 <20190510141320.GB29927@zn.tnic>
 <20190510182512.GG29927@zn.tnic>
 <87d0klttpy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0klttpy.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 14, 2019 at 04:50:49PM +1000, Michael Ellerman wrote:
> Looks good. I even booted it :)

Cool, thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
