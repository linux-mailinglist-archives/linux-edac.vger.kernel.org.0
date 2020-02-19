Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47C164F7A
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2020 21:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSUEF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Feb 2020 15:04:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSUEF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 19 Feb 2020 15:04:05 -0500
Received: from zn.tnic (p200300EC2F095500E936A2094BFCA1EB.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:e936:a209:4bfc:a1eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF5581EC0C81;
        Wed, 19 Feb 2020 21:04:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582142644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DAahp4Ht/gkJNFnbombgDUbRUyv2Pc4Kb1YJ7JE+TO4=;
        b=NFrFNKppJQxs28KdnuWae3BEFfMUXQyOPtHqAFTR8KQc0u8rZSI5M9Mo7TJfl/VV93y08u
        /LtVlznK9Xbry5KB7TDmCAfz7QxQR3lPSz0m40X1JoehShuPsi4u2ZQozzlx/Wo2qLlGcv
        NkcJbtX4MckPTqGGaV0dOwNXFNBSnK8=
Date:   Wed, 19 Feb 2020 21:03:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        ruizhao@microsoft.com, Lei Wang <lewan@microsoft.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <20200219200358.GJ30966@zn.tnic>
References: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
 <20200217181055.GC14426@zn.tnic>
 <4c02326d-cf38-e1e1-1822-d24de22fa2cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c02326d-cf38-e1e1-1822-d24de22fa2cc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 18, 2020 at 09:12:15AM -0800, Shiping Ji wrote:
> Actually I didn't send v11 of the driver since it will be identical to v10,
> sorry for keeping you waiting on this. Please review v10, thanks!

Ok, both patches queued and will appear in linux-next soon.

Thanks for the effort and persistence!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
