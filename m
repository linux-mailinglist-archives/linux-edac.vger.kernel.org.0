Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66867BBC3A
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440493AbfIWTZ2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 15:25:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440469AbfIWTZ1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 15:25:27 -0400
Received: from zn.tnic (p200300EC2F060400F036B51F4D309BFC.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:f036:b51f:4d30:9bfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 457551EC06F3;
        Mon, 23 Sep 2019 21:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569266726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pMXwX4ItsmZtNTpj59AdITYDi1NqjioGLxhIyytmhS0=;
        b=hxdMxTDLpYAZWegqznkELUHinhJU6AH1696H5um0x6wxa7+Q2cxuU6aPnX9fIymE6KprHJ
        6tShg3HkeQpyZapqiWqrQxOtGk4aAzzhGI5DCFnvQWAq0WXe1paChX1maFOQOhUMPz+v7Z
        NgpBQOJkmetntqwclwBRFEAyQe12DnU=
Date:   Mon, 23 Sep 2019 21:25:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>
Subject: Re: [PATCH v6 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190923192526.GK15355@zn.tnic>
References: <BY5PR04MB65990410B5B26C11DBE9C9B186890@BY5PR04MB6599.namprd04.prod.outlook.com>
 <20190923165034.GJ15355@zn.tnic>
 <BY5PR04MB6599FD4A19BF295C2AADC59086850@BY5PR04MB6599.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6599FD4A19BF295C2AADC59086850@BY5PR04MB6599.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 23, 2019 at 06:07:27PM +0000, Lei Wang wrote:
> After merge is over, it would be something like Linux v5.4-rc1?

Yes, I'll update it once v5.4-rc1 is released.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
